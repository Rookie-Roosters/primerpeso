package finance

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"log/slog"
	"regexp"
	"slices"
	"strings"
	"time"
	"unicode"

	"connectrpc.com/connect"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgtype"
	"google.golang.org/protobuf/types/known/timestamppb"

	documentsv1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/documents/v1"
	financev1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/finance/v1"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/finance/store"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/authn"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/connectx"
	cryptox "github.com/Rookie-Roosters/primerpeso/backend/internal/platform/crypto"
)

type ReceiptDraftLookup interface {
	LookupDraft(ctx context.Context, userID, receiptID string) (*documentsv1.ReceiptDraft, error)
}

type Service struct {
	logger  *slog.Logger
	queries *store.Queries
	crypto  *cryptox.Service
	drafts  ReceiptDraftLookup
}

type scoreFactorRecord struct {
	Key         string `json:"key"`
	Title       string `json:"title"`
	Explanation string `json:"explanation"`
	Delta       int32  `json:"delta"`
}

func NewService(logger *slog.Logger, queries *store.Queries, crypto *cryptox.Service, drafts ReceiptDraftLookup) *Service {
	return &Service{
		logger:  logger,
		queries: queries,
		crypto:  crypto,
		drafts:  drafts,
	}
}

func (s *Service) ConfirmExpense(ctx context.Context, req *connect.Request[financev1.ConfirmExpenseRequest]) (*connect.Response[financev1.ConfirmExpenseResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	response, err := s.confirmExpenseForUser(ctx, userID, req.Msg)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(response), nil
}

func (s *Service) ConfirmExpenseFromDraft(
	ctx context.Context,
	userID string,
	draft *documentsv1.ReceiptDraft,
) (*financev1.ConfirmExpenseResponse, error) {
	if strings.TrimSpace(userID) == "" {
		return nil, connectx.Unauthenticated("missing user id")
	}
	if draft == nil {
		return nil, connectx.InvalidArgument("receipt draft is required")
	}

	request := &financev1.ConfirmExpenseRequest{
		ReceiptId:    draft.GetId(),
		MerchantName: draft.GetMerchantName(),
		DisplayTitle: expenseTitle(draft.GetMerchantName()),
		Category:     firstNonEmpty(draft.GetSuggestedCategory(), "general"),
		Amount:       draft.GetTotal(),
		OccurredAt:   draft.GetPurchasedAt(),
	}
	return s.confirmExpenseForUser(ctx, userID, request)
}

func (s *Service) RegisterManualMovement(
	ctx context.Context,
	userID string,
	kind string,
	preferUpdate bool,
	merchantName string,
	category string,
	currencyCode string,
	amountUnits int64,
	occurredAt time.Time,
) (*financev1.ConfirmExpenseResponse, error) {
	if strings.TrimSpace(userID) == "" {
		return nil, connectx.Unauthenticated("missing user id")
	}
	if amountUnits == 0 {
		return nil, connectx.InvalidArgument("amount must be non-zero")
	}

	normalizedKind := normalizeMovementKind(kind)
	normalizedAmount := amountUnits
	if normalizedKind == "income" && normalizedAmount > 0 {
		normalizedAmount *= -1
	}
	if normalizedKind == "expense" && normalizedAmount < 0 {
		normalizedAmount *= -1
	}

	name := firstNonEmpty(merchantName, manualMovementLabel(normalizedKind))
	displayTitle := manualMovementTitle(normalizedKind, name)
	resolvedCategory := strings.TrimSpace(category)
	if resolvedCategory == "" {
		if normalizedKind == "income" {
			resolvedCategory = "income"
		} else {
			resolvedCategory = guessExpenseCategory(name)
		}
	}
	resolvedCurrency := firstNonEmpty(strings.ToUpper(strings.TrimSpace(currencyCode)), "MXN")
	if occurredAt.IsZero() {
		occurredAt = time.Now()
	}

	if preferUpdate {
		updated, err := s.tryUpdateExistingMovement(
			ctx,
			userID,
			normalizedKind,
			name,
			displayTitle,
			resolvedCategory,
			resolvedCurrency,
			normalizedAmount,
			occurredAt,
		)
		if err != nil {
			return nil, err
		}
		if updated != nil {
			return updated, nil
		}
	}

	return s.confirmExpenseForUser(ctx, userID, &financev1.ConfirmExpenseRequest{
		MerchantName: name,
		DisplayTitle: displayTitle,
		Category:     resolvedCategory,
		Amount: &financev1.Money{
			CurrencyCode: resolvedCurrency,
			Units:        normalizedAmount,
		},
		OccurredAt: timestamppb.New(occurredAt),
	})
}

func (s *Service) UpdateManualMovement(
	ctx context.Context,
	userID string,
	kind string,
	merchantName string,
	category string,
	currencyCode string,
	amountUnits int64,
	occurredAt time.Time,
	temporalRef string,
) (*financev1.ConfirmExpenseResponse, error) {
	if strings.TrimSpace(userID) == "" {
		return nil, connectx.Unauthenticated("missing user id")
	}
	if amountUnits == 0 {
		return nil, connectx.InvalidArgument("amount must be non-zero")
	}

	normalizedKind := normalizeMovementKind(kind)
	normalizedAmount := amountUnits
	if normalizedKind == "income" && normalizedAmount > 0 {
		normalizedAmount *= -1
	}
	if normalizedKind == "expense" && normalizedAmount < 0 {
		normalizedAmount *= -1
	}
	name := firstNonEmpty(merchantName, manualMovementLabel(normalizedKind))
	displayTitle := manualMovementTitle(normalizedKind, name)
	resolvedCategory := strings.TrimSpace(category)
	if resolvedCategory == "" {
		if normalizedKind == "income" {
			resolvedCategory = "income"
		} else {
			resolvedCategory = guessExpenseCategory(name)
		}
	}
	resolvedCurrency := firstNonEmpty(strings.ToUpper(strings.TrimSpace(currencyCode)), "MXN")
	if occurredAt.IsZero() {
		occurredAt = time.Now()
	}

	row, err := s.selectMovementForAction(ctx, userID, normalizedKind, name, temporalRef)
	if err != nil {
		return nil, err
	}
	if row == nil {
		return nil, nil
	}
	return s.updateMovementByID(
		ctx,
		userID,
		row.ID,
		name,
		displayTitle,
		resolvedCategory,
		resolvedCurrency,
		normalizedAmount,
		occurredAt,
	)
}

func (s *Service) tryUpdateExistingMovement(
	ctx context.Context,
	userID string,
	kind string,
	merchantName string,
	displayTitle string,
	category string,
	currencyCode string,
	amountUnits int64,
	occurredAt time.Time,
) (*financev1.ConfirmExpenseResponse, error) {
	row, err := s.selectMovementForAction(ctx, userID, kind, merchantName, "")
	if err != nil {
		return nil, err
	}
	if row == nil {
		return nil, nil
	}

	return s.updateMovementByID(
		ctx,
		userID,
		row.ID,
		merchantName,
		displayTitle,
		category,
		currencyCode,
		amountUnits,
		occurredAt,
	)
}

func (s *Service) updateMovementByID(
	ctx context.Context,
	userID string,
	rowID uuid.UUID,
	merchantName string,
	displayTitle string,
	category string,
	currencyCode string,
	amountUnits int64,
	occurredAt time.Time,
) (*financev1.ConfirmExpenseResponse, error) {
	encryptedMerchantName, err := s.crypto.EncryptString(merchantName)
	if err != nil {
		return nil, connectx.Internal("failed to encrypt merchant name")
	}
	encryptedTitle, err := s.crypto.EncryptString(displayTitle)
	if err != nil {
		return nil, connectx.Internal("failed to encrypt display title")
	}

	updated, err := s.queries.UpdateExpenseByID(ctx, store.UpdateExpenseByIDParams{
		UserID:                userID,
		ID:                    rowID,
		EncryptedMerchantName: encryptedMerchantName,
		MerchantHash:          s.crypto.HMACHex("merchant", strings.ToLower(merchantName)),
		EncryptedDisplayTitle: encryptedTitle,
		Category:              category,
		CurrencyCode:          currencyCode,
		AmountUnits:           amountUnits,
		AmountNanos:           0,
		OccurredAt:            pgtype.Timestamptz{Time: occurredAt, Valid: true},
	})
	if err != nil {
		return nil, connectx.Internal("failed to update movement")
	}

	scoreSummary, err := s.GetScoreSummaryData(ctx, userID)
	if err != nil {
		return nil, connectx.Internal("failed to compute score summary")
	}

	expenseMessage, err := s.toExpense(updated)
	if err != nil {
		return nil, connectx.Internal("failed to map expense")
	}

	return &financev1.ConfirmExpenseResponse{
		Expense:      expenseMessage,
		ScoreSummary: scoreSummary,
	}, nil
}

func (s *Service) selectMovementForAction(
	ctx context.Context,
	userID string,
	kind string,
	merchantName string,
	temporalRef string,
) (*store.Expense, error) {
	rows, err := s.queries.ListExpenses(ctx, store.ListExpensesParams{
		UserID: userID,
		Limit:  50,
	})
	if err != nil {
		return nil, connectx.Internal("failed to inspect recent movements")
	}
	if len(rows) == 0 {
		return nil, nil
	}

	target := normalizeMovementName(merchantName)
	generic := target == "" || isGenericMovementName(target)
	ref := normalizeTemporalReference(temporalRef)
	today := time.Now().In(time.Local)
	yesterday := today.AddDate(0, 0, -1)

	type candidate struct {
		row   store.Expense
		score int
	}
	candidates := make([]candidate, 0, len(rows))
	for i, row := range rows {
		if kind == "income" && row.AmountUnits >= 0 {
			continue
		}
		if kind == "expense" && row.AmountUnits < 0 {
			continue
		}

		score := 0
		// recency baseline
		score += maxInt(0, 80-i)
		if !generic {
			expense, err := s.toExpense(row)
			if err != nil {
				continue
			}
			score += movementNameMatchScore(
				target,
				normalizeMovementName(expense.GetMerchantName()),
				normalizeMovementName(expense.GetDisplayTitle()),
			)
		}
		switch ref {
		case "today":
			if sameCalendarDay(row.OccurredAt.Time, today) {
				score += 60
			}
		case "yesterday":
			if sameCalendarDay(row.OccurredAt.Time, yesterday) {
				score += 80
			}
		}
		candidates = append(candidates, candidate{row: row, score: score})
	}
	if len(candidates) == 0 {
		return nil, nil
	}

	if generic {
		// No reliable merchant text: default to latest movement of same kind.
		return &candidates[0].row, nil
	}

	best := candidates[0]
	for _, c := range candidates[1:] {
		if c.score > best.score {
			best = c
		}
	}
	if best.score < 55 {
		return nil, nil
	}
	return &best.row, nil
}

func (s *Service) DeleteMovement(
	ctx context.Context,
	userID string,
	kind string,
	merchantName string,
	temporalRef string,
) (*financev1.Expense, error) {
	if strings.TrimSpace(userID) == "" {
		return nil, connectx.Unauthenticated("missing user id")
	}
	row, err := s.selectMovementForAction(
		ctx,
		userID,
		normalizeMovementKind(kind),
		merchantName,
		temporalRef,
	)
	if err != nil {
		return nil, err
	}
	if row == nil {
		return nil, nil
	}

	deleted, err := s.queries.DeleteExpenseByID(ctx, store.DeleteExpenseByIDParams{
		UserID: userID,
		ID:     row.ID,
	})
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, nil
		}
		return nil, connectx.Internal("failed to delete movement")
	}

	expense, err := s.toExpense(deleted)
	if err != nil {
		return nil, connectx.Internal("failed to map removed movement")
	}
	return expense, nil
}

func (s *Service) UndoLatestMovement(
	ctx context.Context,
	userID string,
) (*financev1.Expense, error) {
	if strings.TrimSpace(userID) == "" {
		return nil, connectx.Unauthenticated("missing user id")
	}

	deleted, err := s.queries.DeleteLatestExpense(ctx, userID)
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, nil
		}
		return nil, connectx.Internal("failed to remove latest movement")
	}

	expense, err := s.toExpense(deleted)
	if err != nil {
		return nil, connectx.Internal("failed to map removed movement")
	}
	return expense, nil
}

func (s *Service) confirmExpenseForUser(
	ctx context.Context,
	userID string,
	input *financev1.ConfirmExpenseRequest,
) (*financev1.ConfirmExpenseResponse, error) {
	if input == nil {
		return nil, connectx.InvalidArgument("confirm request is required")
	}

	var draft *documentsv1.ReceiptDraft
	var err error
	if receiptID := strings.TrimSpace(input.GetReceiptId()); receiptID != "" {
		draft, err = s.drafts.LookupDraft(ctx, userID, receiptID)
		if err != nil {
			return nil, err
		}
	}

	merchantName := firstNonEmpty(input.GetMerchantName(), draft.GetMerchantName())
	displayTitle := firstNonEmpty(input.GetDisplayTitle(), expenseTitle(merchantName))
	category := firstNonEmpty(input.GetCategory(), draft.GetSuggestedCategory(), "general")
	amount := input.GetAmount()
	if amount == nil {
		amount = draft.GetTotal()
	}
	if amount == nil {
		return nil, connectx.InvalidArgument("expense amount is required")
	}

	occurredAt := input.GetOccurredAt()
	if occurredAt == nil {
		occurredAt = draft.GetPurchasedAt()
	}
	if occurredAt == nil {
		occurredAt = timestamppb.New(time.Now())
	}

	encryptedMerchantName, err := s.crypto.EncryptString(merchantName)
	if err != nil {
		return nil, connectx.Internal("failed to encrypt merchant name")
	}

	encryptedTitle, err := s.crypto.EncryptString(displayTitle)
	if err != nil {
		return nil, connectx.Internal("failed to encrypt display title")
	}

	params := store.CreateExpenseParams{
		UserID:                userID,
		ReceiptID:             toPGUUID(input.GetReceiptId()),
		EncryptedMerchantName: encryptedMerchantName,
		MerchantHash:          s.crypto.HMACHex("merchant", strings.ToLower(merchantName)),
		EncryptedDisplayTitle: encryptedTitle,
		Category:              category,
		CurrencyCode:          amount.GetCurrencyCode(),
		AmountUnits:           amount.GetUnits(),
		AmountNanos:           amount.GetNanos(),
		OccurredAt:            pgtype.Timestamptz{Time: occurredAt.AsTime(), Valid: true},
	}

	expense, err := s.queries.CreateExpense(ctx, params)
	if err != nil {
		return nil, connectx.Internal("failed to persist expense")
	}

	scoreSummary, err := s.GetScoreSummaryData(ctx, userID)
	if err != nil {
		return nil, connectx.Internal("failed to compute score summary")
	}

	expenseMessage, err := s.toExpense(expense)
	if err != nil {
		return nil, connectx.Internal("failed to map expense")
	}

	return &financev1.ConfirmExpenseResponse{
		Expense:      expenseMessage,
		ScoreSummary: scoreSummary,
	}, nil
}

func (s *Service) ListExpenses(ctx context.Context, req *connect.Request[financev1.ListExpensesRequest]) (*connect.Response[financev1.ListExpensesResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	expenses, err := s.ListRecentExpenses(ctx, userID, req.Msg.GetPageSize())
	if err != nil {
		return nil, connectx.Internal(err.Error())
	}

	return connect.NewResponse(&financev1.ListExpensesResponse{Expenses: expenses}), nil
}

func (s *Service) GetScoreSummary(ctx context.Context, _ *connect.Request[financev1.GetScoreSummaryRequest]) (*connect.Response[financev1.GetScoreSummaryResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	summary, err := s.GetScoreSummaryData(ctx, userID)
	if err != nil {
		return nil, connectx.Internal(err.Error())
	}

	return connect.NewResponse(&financev1.GetScoreSummaryResponse{Summary: summary}), nil
}

func (s *Service) ListRecentExpenses(ctx context.Context, userID string, limit int32) ([]*financev1.Expense, error) {
	if limit <= 0 {
		limit = 10
	}

	rows, err := s.queries.ListExpenses(ctx, store.ListExpensesParams{
		UserID: userID,
		Limit:  limit,
	})
	if err != nil {
		return nil, err
	}

	expenses := make([]*financev1.Expense, 0, len(rows))
	for _, row := range rows {
		expense, err := s.toExpense(row)
		if err != nil {
			return nil, err
		}
		expenses = append(expenses, expense)
	}

	return expenses, nil
}

func (s *Service) GetScoreSummaryData(ctx context.Context, userID string) (*financev1.ScoreSummary, error) {
	expenseCount, err := s.queries.CountExpenses(ctx, userID)
	if err != nil {
		return nil, err
	}

	categoryCoverage, err := s.queries.CountCategoryCoverage(ctx, userID)
	if err != nil {
		return nil, err
	}

	totalLast30, err := s.queries.SumLatestMonthExpenseUnits(ctx, userID)
	if err != nil {
		return nil, err
	}

	topCategoryLast30, err := s.queries.SumTopCategoryExpenseUnits(ctx, userID)
	if err != nil {
		return nil, err
	}

	factors := []scoreFactorRecord{
		{
			Key:         "baseline",
			Title:       "Base",
			Explanation: "Punto de partida neutro para el historial confirmado.",
			Delta:       600,
		},
		{
			Key:         "receipt_activity",
			Title:       "Actividad",
			Explanation: "Se premia registrar gastos confirmados con constancia.",
			Delta:       min32(int32(expenseCount)*8, 80),
		},
		{
			Key:         "category_coverage",
			Title:       "Cobertura",
			Explanation: "Tener gastos distribuidos en categorías distintas ayuda a explicar hábitos.",
			Delta:       min32(int32(categoryCoverage)*10, 60),
		},
		{
			Key:         "spending_concentration",
			Title:       "Concentración",
			Explanation: "Se penaliza una alta dependencia de una sola categoría reciente.",
			Delta:       concentrationDelta(totalLast30, topCategoryLast30),
		},
	}

	var score int32
	for _, factor := range factors {
		score += factor.Delta
	}
	if score < 300 {
		score = 300
	}
	if score > 900 {
		score = 900
	}

	factorsJSON, err := json.Marshal(factors)
	if err != nil {
		return nil, err
	}

	snapshot, err := s.queries.CreateScoreSnapshot(ctx, store.CreateScoreSnapshotParams{
		UserID:  userID,
		Score:   score,
		Factors: factorsJSON,
	})
	if err != nil {
		return nil, err
	}

	return &financev1.ScoreSummary{
		Score:     score,
		Factors:   toProtoFactors(factors),
		UpdatedAt: timestamppb.New(snapshot.CreatedAt.Time),
	}, nil
}

func (s *Service) toExpense(expense store.Expense) (*financev1.Expense, error) {
	merchantName, err := s.crypto.DecryptString(expense.EncryptedMerchantName)
	if err != nil {
		return nil, err
	}
	displayTitle, err := s.crypto.DecryptString(expense.EncryptedDisplayTitle)
	if err != nil {
		return nil, err
	}

	sourceReceiptID := ""
	if expense.ReceiptID.Valid {
		sourceReceiptID = uuid.UUID(expense.ReceiptID.Bytes).String()
	}

	return &financev1.Expense{
		Id:              expense.ID.String(),
		MerchantName:    merchantName,
		DisplayTitle:    displayTitle,
		Category:        expense.Category,
		SourceReceiptId: sourceReceiptID,
		Amount: &financev1.Money{
			CurrencyCode: expense.CurrencyCode,
			Units:        expense.AmountUnits,
			Nanos:        expense.AmountNanos,
		},
		OccurredAt: timestamppb.New(expense.OccurredAt.Time),
		CreatedAt:  timestamppb.New(expense.CreatedAt.Time),
	}, nil
}

func toProtoFactors(factors []scoreFactorRecord) []*financev1.ScoreFactor {
	out := make([]*financev1.ScoreFactor, 0, len(factors))
	for _, factor := range factors {
		out = append(out, &financev1.ScoreFactor{
			Key:         factor.Key,
			Title:       factor.Title,
			Explanation: factor.Explanation,
			Delta:       factor.Delta,
		})
	}
	return out
}

func concentrationDelta(totalLast30, topCategoryLast30 int64) int32 {
	if totalLast30 <= 0 || topCategoryLast30 <= 0 {
		return 0
	}

	ratio := float64(topCategoryLast30) / float64(totalLast30)
	switch {
	case ratio <= 0.35:
		return 40
	case ratio <= 0.55:
		return 20
	case ratio <= 0.75:
		return 0
	default:
		return -30
	}
}

func expenseTitle(merchantName string) string {
	if strings.TrimSpace(merchantName) == "" {
		return "Gasto confirmado"
	}
	return fmt.Sprintf("Gasto en %s", merchantName)
}

func manualMovementTitle(kind, merchantName string) string {
	if normalizeMovementKind(kind) == "income" {
		if strings.TrimSpace(merchantName) == "" {
			return "Ingreso registrado"
		}
		return fmt.Sprintf("Ingreso de %s", merchantName)
	}
	return expenseTitle(merchantName)
}

func manualMovementLabel(kind string) string {
	if normalizeMovementKind(kind) == "income" {
		return "Ingreso manual"
	}
	return "Gasto manual"
}

func normalizeMovementKind(kind string) string {
	if strings.EqualFold(strings.TrimSpace(kind), "income") {
		return "income"
	}
	return "expense"
}

func guessExpenseCategory(merchantName string) string {
	lower := strings.ToLower(strings.TrimSpace(merchantName))
	switch {
	case strings.Contains(lower, "taco"),
		strings.Contains(lower, "comida"),
		strings.Contains(lower, "rest"),
		strings.Contains(lower, "cafe"),
		strings.Contains(lower, "cafeter"):
		return "food"
	case strings.Contains(lower, "uber"),
		strings.Contains(lower, "didi"),
		strings.Contains(lower, "taxi"),
		strings.Contains(lower, "metro"),
		strings.Contains(lower, "gasolina"),
		strings.Contains(lower, "caseta"):
		return "transport"
	case strings.Contains(lower, "super"),
		strings.Contains(lower, "mercado"),
		strings.Contains(lower, "walmart"),
		strings.Contains(lower, "soriana"),
		strings.Contains(lower, "chedraui"):
		return "groceries"
	case strings.Contains(lower, "renta"), strings.Contains(lower, "alquiler"):
		return "housing"
	default:
		return "general"
	}
}

func firstNonEmpty(values ...string) string {
	for _, value := range values {
		if trimmed := strings.TrimSpace(value); trimmed != "" {
			return trimmed
		}
	}
	return ""
}

func toPGUUID(value string) pgtype.UUID {
	if strings.TrimSpace(value) == "" {
		return pgtype.UUID{}
	}
	parsed, err := uuid.Parse(value)
	if err != nil {
		return pgtype.UUID{}
	}
	return pgtype.UUID{Bytes: parsed, Valid: true}
}

func min32(a, b int32) int32 {
	if a < b {
		return a
	}
	return b
}

func minInt(a, b int) int {
	if a < b {
		return a
	}
	return b
}

var nonAlphaNum = regexp.MustCompile(`[^a-z0-9]+`)

func normalizeMovementName(value string) string {
	if strings.TrimSpace(value) == "" {
		return ""
	}
	lower := strings.ToLower(value)
	var b strings.Builder
	b.Grow(len(lower))
	for _, r := range lower {
		switch {
		case unicode.IsLetter(r) || unicode.IsNumber(r):
			b.WriteRune(r)
		case unicode.IsSpace(r):
			b.WriteRune(' ')
		default:
			b.WriteRune(' ')
		}
	}
	clean := strings.TrimSpace(nonAlphaNum.ReplaceAllString(b.String(), " "))
	return strings.Join(strings.Fields(clean), " ")
}

func isGenericMovementName(normalized string) bool {
	return normalized == "" ||
		normalized == "gasto manual" ||
		normalized == "ingreso manual" ||
		normalized == "gasto confirmado" ||
		normalized == "ingreso registrado"
}

func movementNameMatchScore(target, merchant, title string) int {
	if target == "" {
		return 0
	}
	return maxInt(singleNameScore(target, merchant), singleNameScore(target, title))
}

func singleNameScore(target, candidate string) int {
	if target == "" || candidate == "" {
		return 0
	}
	if target == candidate {
		return 100
	}
	targetCompact := strings.ReplaceAll(target, " ", "")
	candidateCompact := strings.ReplaceAll(candidate, " ", "")
	if targetCompact == candidateCompact {
		return 96
	}
	if strings.Contains(candidate, target) || strings.Contains(target, candidate) {
		return 88
	}
	if strings.Contains(candidateCompact, targetCompact) || strings.Contains(targetCompact, candidateCompact) {
		return 84
	}

	targetTokens := strings.Fields(target)
	candidateTokens := strings.Fields(candidate)
	if len(targetTokens) == 0 || len(candidateTokens) == 0 {
		return 0
	}
	targetSet := make(map[string]struct{}, len(targetTokens))
	for _, token := range targetTokens {
		targetSet[token] = struct{}{}
	}
	shared := 0
	for _, token := range candidateTokens {
		if _, ok := targetSet[token]; ok {
			shared++
		}
	}
	if shared == 0 {
		return 0
	}
	base := (shared * 100) / maxInt(len(targetTokens), len(candidateTokens))
	if hasOrderedTokenSubset(targetTokens, candidateTokens) {
		base += 8
	}
	if base > 100 {
		return 100
	}
	return base
}

func hasOrderedTokenSubset(target, candidate []string) bool {
	if len(target) == 0 || len(candidate) == 0 {
		return false
	}
	i := 0
	for _, token := range candidate {
		if i < len(target) && target[i] == token {
			i++
		}
	}
	return i >= minInt(2, len(target))
}

func normalizeTemporalReference(value string) string {
	lower := strings.ToLower(strings.TrimSpace(value))
	switch {
	case strings.Contains(lower, "ayer"), strings.Contains(lower, "yesterday"):
		return "yesterday"
	case strings.Contains(lower, "hoy"), strings.Contains(lower, "today"):
		return "today"
	default:
		return ""
	}
}

func sameCalendarDay(a, b time.Time) bool {
	aa := a.In(time.Local)
	bb := b.In(time.Local)
	return aa.Year() == bb.Year() && aa.Month() == bb.Month() && aa.Day() == bb.Day()
}

func maxInt(a, b int) int {
	return slices.Max([]int{a, b})
}

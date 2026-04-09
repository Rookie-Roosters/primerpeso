package finance

import (
	"context"
	"encoding/json"
	"fmt"
	"log/slog"
	"strings"
	"time"

	"connectrpc.com/connect"
	"github.com/google/uuid"
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

	var draft *documentsv1.ReceiptDraft
	var err error
	if receiptID := strings.TrimSpace(req.Msg.GetReceiptId()); receiptID != "" {
		draft, err = s.drafts.LookupDraft(ctx, userID, receiptID)
		if err != nil {
			return nil, err
		}
	}

	merchantName := firstNonEmpty(req.Msg.GetMerchantName(), draft.GetMerchantName())
	displayTitle := firstNonEmpty(req.Msg.GetDisplayTitle(), expenseTitle(merchantName))
	category := firstNonEmpty(req.Msg.GetCategory(), draft.GetSuggestedCategory(), "general")
	amount := req.Msg.GetAmount()
	if amount == nil {
		amount = draft.GetTotal()
	}
	if amount == nil {
		return nil, connectx.InvalidArgument("expense amount is required")
	}

	occurredAt := req.Msg.GetOccurredAt()
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
		ReceiptID:             toPGUUID(req.Msg.GetReceiptId()),
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

	return connect.NewResponse(&financev1.ConfirmExpenseResponse{
		Expense:      expenseMessage,
		ScoreSummary: scoreSummary,
	}), nil
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

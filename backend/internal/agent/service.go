package agent

import (
	"context"
	"encoding/json"
	"fmt"
	"log/slog"
	"regexp"
	"strconv"
	"strings"
	"time"
	"unicode"
	"unicode/utf8"

	"connectrpc.com/connect"
	"github.com/firebase/genkit/go/ai"
	"github.com/firebase/genkit/go/genkit"
	oai "github.com/firebase/genkit/go/plugins/compat_oai"
	"github.com/google/uuid"
	"google.golang.org/protobuf/types/known/structpb"

	agentv1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/agent/v1"
	documentsv1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/documents/v1"
	financev1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/finance/v1"
	savingsv1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/savings/v1"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/authn"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/config"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/connectx"
)

type scoreProvider interface {
	GetScoreSummaryData(ctx context.Context, userID string) (*financev1.ScoreSummary, error)
	ListRecentExpenses(ctx context.Context, userID string, limit int32) ([]*financev1.Expense, error)
	RegisterManualMovement(
		ctx context.Context,
		userID string,
		kind string,
		preferUpdate bool,
		merchantName string,
		category string,
		currencyCode string,
		amountUnits int64,
		occurredAt time.Time,
	) (*financev1.ConfirmExpenseResponse, error)
	UpdateManualMovement(
		ctx context.Context,
		userID string,
		kind string,
		merchantName string,
		category string,
		currencyCode string,
		amountUnits int64,
		occurredAt time.Time,
		temporalRef string,
	) (*financev1.ConfirmExpenseResponse, error)
	DeleteMovement(
		ctx context.Context,
		userID string,
		kind string,
		merchantName string,
		temporalRef string,
	) (*financev1.Expense, error)
	UndoLatestMovement(ctx context.Context, userID string) (*financev1.Expense, error)
}

type receiptProvider interface {
	LookupDraft(ctx context.Context, userID, receiptID string) (*documentsv1.ReceiptDraft, error)
	LatestDraft(ctx context.Context, userID string) (*documentsv1.ReceiptDraft, error)
}

type savingsProvider interface {
	CreateApartadoForUser(ctx context.Context, userID string, req *savingsv1.CreateApartadoRequest) (*savingsv1.Apartado, error)
	GetApartadoForUser(ctx context.Context, userID, apartadoID string) (*savingsv1.Apartado, error)
	ListApartadosForUser(ctx context.Context, userID string, limit int32) ([]*savingsv1.Apartado, error)
	UpdateApartadoForUser(ctx context.Context, userID string, req *savingsv1.UpdateApartadoRequest) (*savingsv1.Apartado, error)
	DeleteApartadoForUser(ctx context.Context, userID, apartadoID string) (*savingsv1.Apartado, error)
	CreateFinancialGoalForUser(ctx context.Context, userID string, req *savingsv1.CreateFinancialGoalRequest) (*savingsv1.FinancialGoal, error)
	GetFinancialGoalForUser(ctx context.Context, userID, goalID string) (*savingsv1.FinancialGoal, error)
	ListFinancialGoalsForUser(ctx context.Context, userID string, limit int32) ([]*savingsv1.FinancialGoal, error)
	UpdateFinancialGoalForUser(ctx context.Context, userID string, req *savingsv1.UpdateFinancialGoalRequest) (*savingsv1.FinancialGoal, error)
	DeleteFinancialGoalForUser(ctx context.Context, userID, goalID string) (*savingsv1.FinancialGoal, error)
	CreateRecurringPaymentReminderForUser(ctx context.Context, userID string, req *savingsv1.CreateRecurringPaymentReminderRequest) (*savingsv1.RecurringPaymentReminder, error)
	GetRecurringPaymentReminderForUser(ctx context.Context, userID, reminderID string) (*savingsv1.RecurringPaymentReminder, error)
	ListRecurringPaymentRemindersForUser(ctx context.Context, userID string, limit int32) ([]*savingsv1.RecurringPaymentReminder, error)
	UpdateRecurringPaymentReminderForUser(ctx context.Context, userID string, req *savingsv1.UpdateRecurringPaymentReminderRequest) (*savingsv1.RecurringPaymentReminder, error)
	DeleteRecurringPaymentReminderForUser(ctx context.Context, userID, reminderID string) (*savingsv1.RecurringPaymentReminder, error)
}

type Service struct {
	logger       *slog.Logger
	model        *genkit.Genkit
	cfg          config.Config
	finance      scoreProvider
	receipts     receiptProvider
	savings      savingsProvider
	systemPrompt string
	aprendeCrece *aprendeCreceIndex
}

func NewService(ctx context.Context, cfg config.Config, logger *slog.Logger, finance scoreProvider, receipts receiptProvider, savings savingsProvider) *Service {
	service := &Service{
		logger:   logger,
		cfg:      cfg,
		finance:  finance,
		receipts: receipts,
		savings:  savings,
	}

	if strings.TrimSpace(cfg.XAIAPIKey) != "" {
		service.model = genkit.Init(
			ctx,
			genkit.WithPlugins(&oai.OpenAICompatible{
				Provider: "xai",
				APIKey:   cfg.XAIAPIKey,
				BaseURL:  cfg.XAIBaseURL,
			}),
			genkit.WithDefaultModel("xai/"+cfg.XAIModel),
		)
	}

	prompt, err := loadSystemPrompt(cfg.AgentSystemPromptPath)
	if err != nil {
		logger.Warn("failed to load external agent system prompt, using fallback", "path", cfg.AgentSystemPromptPath, "error", err)
	}
	service.systemPrompt = prompt
	aprendeCrece, err := loadAprendeCreceIndex(cfg.AgentAprendeCrecePath)
	if err != nil {
		logger.Warn("failed to load aprende y crece knowledge base; tool will be disabled", "path", cfg.AgentAprendeCrecePath, "error", err)
	} else {
		service.aprendeCrece = aprendeCrece
	}

	return service
}

func (s *Service) Run(ctx context.Context, req *connect.Request[agentv1.RunRequest], stream *connect.ServerStream[agentv1.RunEvent]) error {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return connectx.Unauthenticated("missing access token")
	}

	threadID := firstNonEmpty(req.Msg.GetThreadId(), uuid.NewString())
	runID := firstNonEmpty(req.Msg.GetRunId(), uuid.NewString())
	messageID := uuid.NewString()
	lastUserMessage := latestUserMessage(req.Msg.GetMessages())

	send := func(event *agentv1.RunEvent) error {
		return stream.Send(event)
	}

	if err := send(runStarted(threadID, runID)); err != nil {
		return err
	}

	promptContext, err := s.applyTools(ctx, send, userID, threadID, runID, req.Msg, lastUserMessage)
	if err != nil {
		_ = send(runError(threadID, runID, err.Error(), "tool_error"))
		return nil
	}

	if err := send(textStart(threadID, runID, messageID)); err != nil {
		return err
	}

	reply := s.generateReply(ctx, req.Msg, lastUserMessage, promptContext)
	for _, chunk := range splitChunks(reply, 48) {
		if err := send(textDelta(threadID, runID, messageID, chunk)); err != nil {
			return err
		}
	}

	if err := send(textEnd(threadID, runID, messageID)); err != nil {
		return err
	}
	if err := send(runFinished(threadID, runID)); err != nil {
		return err
	}

	return nil
}

func (s *Service) applyTools(
	ctx context.Context,
	send func(*agentv1.RunEvent) error,
	userID, threadID, runID string,
	request *agentv1.RunRequest,
	lastUserMessage string,
) (string, error) {
	var contextParts []string
	lower := strings.ToLower(lastUserMessage)

	if isLedgerRelated(lower) {
		toolCallID := uuid.NewString()
		if err := send(toolStart(threadID, runID, toolCallID, "list_recent_movements")); err != nil {
			return "", err
		}
		if err := send(toolArgs(threadID, runID, toolCallID, `{"limit":10}`)); err != nil {
			return "", err
		}
		movements, err := s.finance.ListRecentExpenses(ctx, userID, 10)
		if err != nil {
			s.logger.Warn("failed to prefetch recent movements", "error", err)
			if err := send(toolEnd(threadID, runID, toolCallID)); err != nil {
				return "", err
			}
			contextParts = append(contextParts, "AUTO_REPLY:No pude consultar tu historial en este momento. Inténtalo de nuevo en unos segundos.")
			contextParts = append(contextParts, "El pre-listado de movimientos fallo; se bloquearon mutaciones de ledger en esta corrida.")
			return strings.Join(contextParts, "\n"), nil
		}
		if err := send(toolEnd(threadID, runID, toolCallID)); err != nil {
			return "", err
		}
		contextParts = append(contextParts, movementContext(movements))

		action := s.resolveLedgerAction(ctx, request, lastUserMessage, movements)
		if shouldSkipRegistration(lower) && (action.Action == "create" || action.Action == "update") {
			contextParts = append(contextParts, "AUTO_REPLY:Entendido, no registro ni modifico ese movimiento.")
		} else {
			ledgerContext, err := s.executeLedgerAction(ctx, send, userID, threadID, runID, lower, action, movements)
			if err != nil {
				return "", err
			}
			if ledgerContext != "" {
				contextParts = append(contextParts, ledgerContext)
			}
		}
	}

	if shouldFetchScore(lower) {
		toolCallID := uuid.NewString()
		if err := send(toolStart(threadID, runID, toolCallID, "get_score_summary")); err != nil {
			return "", err
		}
		if err := send(toolArgs(threadID, runID, toolCallID, `{}`)); err != nil {
			return "", err
		}
		scoreSummary, err := s.finance.GetScoreSummaryData(ctx, userID)
		if err != nil {
			return "", err
		}
		contextParts = append(contextParts, fmt.Sprintf("Puntaje actual: %d.", scoreSummary.GetScore()))
		if err := send(toolEnd(threadID, runID, toolCallID)); err != nil {
			return "", err
		}
		if err := send(scoreDelta(threadID, runID, scoreSummary)); err != nil {
			return "", err
		}
	}

	if shouldFetchReceipt(lower) {
		toolCallID := uuid.NewString()
		if err := send(toolStart(threadID, runID, toolCallID, "get_receipt_draft")); err != nil {
			return "", err
		}
		var draft *documentsv1.ReceiptDraft
		var err error
		if receiptID := stateString(request.GetState(), "selectedReceiptId"); receiptID != "" {
			if err := send(toolArgs(threadID, runID, toolCallID, fmt.Sprintf(`{"receipt_id":"%s"}`, receiptID))); err != nil {
				return "", err
			}
			draft, err = s.receipts.LookupDraft(ctx, userID, receiptID)
		} else {
			if err := send(toolArgs(threadID, runID, toolCallID, `{"mode":"latest"}`)); err != nil {
				return "", err
			}
			draft, err = s.receipts.LatestDraft(ctx, userID)
		}
		if err == nil && draft != nil {
			contextParts = append(contextParts, fmt.Sprintf("Borrador de ticket: %s por %d %s.", draft.GetMerchantName(), draft.GetTotal().GetUnits(), draft.GetTotal().GetCurrencyCode()))
		}
		if err := send(toolEnd(threadID, runID, toolCallID)); err != nil {
			return "", err
		}
	}

	if shouldFetchAprendeCrece(lower) && s.aprendeCrece != nil {
		toolCallID := uuid.NewString()
		if err := send(toolStart(threadID, runID, toolCallID, "search_aprende_y_crece")); err != nil {
			return "", err
		}
		if err := send(toolArgs(threadID, runID, toolCallID, jsonObject(map[string]any{
			"query":       lastUserMessage,
			"max_results": 3,
		}))); err != nil {
			return "", err
		}
		results := s.aprendeCrece.Search(lastUserMessage, 3)
		if err := send(toolEnd(threadID, runID, toolCallID)); err != nil {
			return "", err
		}
		if context := formatAprendeCreceContext(results); context != "" {
			contextParts = append(contextParts, context)
		}
	}

	if shouldHandleSavings(lower) && s.savings != nil {
		savingsContext, err := s.executeSavingsAction(ctx, send, userID, threadID, runID, lastUserMessage, lower)
		if err != nil {
			return "", err
		}
		if savingsContext != "" {
			contextParts = append(contextParts, savingsContext)
		}
	}

	if route, toolName := navigationFor(lower); route != "" {
		toolCallID := uuid.NewString()
		if err := send(toolStart(threadID, runID, toolCallID, toolName)); err != nil {
			return "", err
		}
		if err := send(toolArgs(threadID, runID, toolCallID, fmt.Sprintf(`{"route":"%s"}`, route))); err != nil {
			return "", err
		}
		if err := send(toolEnd(threadID, runID, toolCallID)); err != nil {
			return "", err
		}
		if err := send(navigationDelta(threadID, runID, route)); err != nil {
			return "", err
		}
		contextParts = append(contextParts, fmt.Sprintf("La app debe navegar a %s.", route))
	}

	return strings.Join(contextParts, "\n"), nil
}

type ledgerAction struct {
	Action        string   `json:"action"`
	Kind          string   `json:"kind,omitempty"`
	AmountUnits   *int64   `json:"amount_units,omitempty"`
	Currency      string   `json:"currency,omitempty"`
	Merchant      string   `json:"merchant,omitempty"`
	Category      string   `json:"category,omitempty"`
	TemporalRef   string   `json:"temporal_reference,omitempty"`
	Confidence    float64  `json:"confidence,omitempty"`
	MissingFields []string `json:"missing_fields,omitempty"`
}

func (s *Service) resolveLedgerAction(
	ctx context.Context,
	request *agentv1.RunRequest,
	lastUserMessage string,
	movements []*financev1.Expense,
) ledgerAction {
	if action, ok := s.extractLedgerActionWithModel(ctx, request, lastUserMessage, movements); ok {
		return action
	}
	return heuristicLedgerAction(lastUserMessage)
}

func (s *Service) extractLedgerActionWithModel(
	ctx context.Context,
	request *agentv1.RunRequest,
	lastUserMessage string,
	movements []*financev1.Expense,
) (ledgerAction, bool) {
	if s.model == nil {
		return ledgerAction{}, false
	}
	raw, err := s.generateText(ctx, buildLedgerActionPrompt(request, lastUserMessage, movements))
	if err != nil {
		s.logger.Warn("ledger action extraction failed", "error", err)
		return ledgerAction{}, false
	}
	action, ok := parseLedgerActionJSON(raw)
	if !ok {
		return ledgerAction{}, false
	}
	if !validateLedgerAction(&action) {
		return ledgerAction{}, false
	}
	return action, true
}

func validateLedgerAction(action *ledgerAction) bool {
	if action == nil {
		return false
	}
	action.Action = strings.ToLower(strings.TrimSpace(action.Action))
	action.Kind = normalizeLedgerKind(action.Kind)
	action.Currency = firstNonEmpty(strings.ToUpper(strings.TrimSpace(action.Currency)), "MXN")
	action.Merchant = strings.TrimSpace(action.Merchant)
	action.Category = strings.TrimSpace(action.Category)
	action.TemporalRef = normalizeTemporalReference(action.TemporalRef)

	switch action.Action {
	case "none":
		return true
	case "list":
		if action.Kind == "" {
			action.Kind = "any"
		}
		return true
	case "undo":
		return true
	case "create":
		if action.Kind == "" {
			action.MissingFields = append(action.MissingFields, "tipo (gasto o ingreso)")
		}
		if action.AmountUnits == nil || *action.AmountUnits <= 0 {
			action.MissingFields = append(action.MissingFields, "monto")
		}
		return len(action.MissingFields) == 0
	case "update":
		if action.Kind == "" {
			action.MissingFields = append(action.MissingFields, "tipo (gasto o ingreso)")
		}
		if action.AmountUnits == nil || *action.AmountUnits <= 0 {
			action.MissingFields = append(action.MissingFields, "monto final")
		}
		return len(action.MissingFields) == 0
	case "delete":
		if action.Kind == "" {
			action.Kind = "expense"
		}
		return action.Merchant != "" || action.TemporalRef != ""
	default:
		return false
	}
}

func (s *Service) executeLedgerAction(
	ctx context.Context,
	send func(*agentv1.RunEvent) error,
	userID, threadID, runID string,
	lowerUserMessage string,
	action ledgerAction,
	movements []*financev1.Expense,
) (string, error) {
	switch action.Action {
	case "undo":
		return s.executeUndoTool(ctx, send, userID, threadID, runID)
	case "list":
		return "AUTO_REPLY:" + summarizeMovementsForUser(movements, action.Kind), nil
	case "create":
		return s.executeCreateMovementTool(ctx, send, userID, threadID, runID, lowerUserMessage, action)
	case "update":
		return s.executeUpdateMovementTool(ctx, send, userID, threadID, runID, lowerUserMessage, action)
	case "delete":
		return s.executeDeleteMovementTool(ctx, send, userID, threadID, runID, action)
	default:
		// Fallback for ledger turns with no explicit action: answer from listed context.
		return "AUTO_REPLY:" + summarizeMovementsForUser(movements, inferMovementKindFromQuestion(lowerUserMessage)), nil
	}
}

func (s *Service) executeUndoTool(
	ctx context.Context,
	send func(*agentv1.RunEvent) error,
	userID, threadID, runID string,
) (string, error) {
	toolCallID := uuid.NewString()
	if err := send(toolStart(threadID, runID, toolCallID, "undo_last_registration")); err != nil {
		return "", err
	}
	if err := send(toolArgs(threadID, runID, toolCallID, `{"mode":"latest"}`)); err != nil {
		return "", err
	}
	removed, err := s.finance.UndoLatestMovement(ctx, userID)
	if err != nil {
		return "", err
	}
	if err := send(toolEnd(threadID, runID, toolCallID)); err != nil {
		return "", err
	}
	if removed == nil {
		return "AUTO_REPLY:No encontré movimientos para deshacer.", nil
	}
	if err := send(ledgerDelta(threadID, runID, "undo", removed)); err != nil {
		return "", err
	}
	return fmt.Sprintf(
		"AUTO_REPLY:Listo, deshice el último movimiento: %s por %d %s.",
		removed.GetDisplayTitle(),
		abs64(removed.GetAmount().GetUnits()),
		firstNonEmpty(removed.GetAmount().GetCurrencyCode(), "MXN"),
	), nil
}

func (s *Service) executeCreateMovementTool(
	ctx context.Context,
	send func(*agentv1.RunEvent) error,
	userID, threadID, runID string,
	lowerUserMessage string,
	action ledgerAction,
) (string, error) {
	if len(action.MissingFields) > 0 {
		return "AUTO_REPLY:Para registrarlo necesito " + strings.Join(action.MissingFields, " y ") + ".", nil
	}
	toolName := "register_expense"
	if action.Kind == "income" {
		toolName = "register_income"
	}
	toolCallID := uuid.NewString()
	if err := send(toolStart(threadID, runID, toolCallID, toolName)); err != nil {
		return "", err
	}
	args := jsonObject(map[string]any{
		"kind":     action.Kind,
		"amount":   *action.AmountUnits,
		"currency": action.Currency,
		"merchant": firstNonEmpty(action.Merchant, manualLabelForKind(action.Kind)),
		"category": firstNonEmpty(action.Category, inferCategory(lowerUserMessage, action.Kind, action.Merchant)),
	})
	if err := send(toolArgs(threadID, runID, toolCallID, args)); err != nil {
		return "", err
	}
	registered, err := s.finance.RegisterManualMovement(
		ctx,
		userID,
		action.Kind,
		false,
		firstNonEmpty(action.Merchant, manualLabelForKind(action.Kind)),
		firstNonEmpty(action.Category, inferCategory(lowerUserMessage, action.Kind, action.Merchant)),
		action.Currency,
		*action.AmountUnits,
		time.Now(),
	)
	if err != nil {
		return "", err
	}
	if err := send(toolEnd(threadID, runID, toolCallID)); err != nil {
		return "", err
	}
	entry := registered.GetExpense()
	if entry == nil {
		return "AUTO_REPLY:No pude confirmar el registro de ese movimiento.", nil
	}
	if err := send(ledgerDelta(threadID, runID, "register", entry)); err != nil {
		return "", err
	}
	if summary := registered.GetScoreSummary(); summary != nil {
		if err := send(scoreDelta(threadID, runID, summary)); err != nil {
			return "", err
		}
	}
	return "AUTO_REPLY:" + formatRegistrationConfirmation(entry, action.Kind), nil
}

func (s *Service) executeUpdateMovementTool(
	ctx context.Context,
	send func(*agentv1.RunEvent) error,
	userID, threadID, runID string,
	lowerUserMessage string,
	action ledgerAction,
) (string, error) {
	if len(action.MissingFields) > 0 {
		return "AUTO_REPLY:Para corregirlo necesito " + strings.Join(action.MissingFields, " y ") + ".", nil
	}
	toolCallID := uuid.NewString()
	if err := send(toolStart(threadID, runID, toolCallID, "update_movement")); err != nil {
		return "", err
	}
	args := jsonObject(map[string]any{
		"kind":               action.Kind,
		"amount":             *action.AmountUnits,
		"currency":           action.Currency,
		"merchant":           action.Merchant,
		"category":           firstNonEmpty(action.Category, inferCategory(lowerUserMessage, action.Kind, action.Merchant)),
		"temporal_reference": action.TemporalRef,
	})
	if err := send(toolArgs(threadID, runID, toolCallID, args)); err != nil {
		return "", err
	}
	updated, err := s.finance.UpdateManualMovement(
		ctx,
		userID,
		action.Kind,
		action.Merchant,
		firstNonEmpty(action.Category, inferCategory(lowerUserMessage, action.Kind, action.Merchant)),
		action.Currency,
		*action.AmountUnits,
		time.Now(),
		action.TemporalRef,
	)
	if err != nil {
		return "", err
	}
	if err := send(toolEnd(threadID, runID, toolCallID)); err != nil {
		return "", err
	}
	if updated == nil || updated.GetExpense() == nil {
		return "AUTO_REPLY:No encontré un movimiento que coincida para actualizar.", nil
	}
	entry := updated.GetExpense()
	if err := send(ledgerDelta(threadID, runID, "update", entry)); err != nil {
		return "", err
	}
	if summary := updated.GetScoreSummary(); summary != nil {
		if err := send(scoreDelta(threadID, runID, summary)); err != nil {
			return "", err
		}
	}
	return fmt.Sprintf(
		"AUTO_REPLY:Movimiento actualizado: %s por %d %s.",
		firstNonEmpty(entry.GetDisplayTitle(), entry.GetMerchantName()),
		abs64(entry.GetAmount().GetUnits()),
		firstNonEmpty(entry.GetAmount().GetCurrencyCode(), "MXN"),
	), nil
}

func (s *Service) executeDeleteMovementTool(
	ctx context.Context,
	send func(*agentv1.RunEvent) error,
	userID, threadID, runID string,
	action ledgerAction,
) (string, error) {
	toolCallID := uuid.NewString()
	if err := send(toolStart(threadID, runID, toolCallID, "delete_movement")); err != nil {
		return "", err
	}
	args := jsonObject(map[string]any{
		"kind":               firstNonEmpty(action.Kind, "expense"),
		"merchant":           action.Merchant,
		"temporal_reference": action.TemporalRef,
	})
	if err := send(toolArgs(threadID, runID, toolCallID, args)); err != nil {
		return "", err
	}
	deleted, err := s.finance.DeleteMovement(
		ctx,
		userID,
		firstNonEmpty(action.Kind, "expense"),
		action.Merchant,
		action.TemporalRef,
	)
	if err != nil {
		return "", err
	}
	if err := send(toolEnd(threadID, runID, toolCallID)); err != nil {
		return "", err
	}
	if deleted == nil {
		return "AUTO_REPLY:No encontré un movimiento que coincida para eliminar.", nil
	}
	if err := send(ledgerDelta(threadID, runID, "delete", deleted)); err != nil {
		return "", err
	}
	return fmt.Sprintf(
		"AUTO_REPLY:Movimiento eliminado: %s por %d %s.",
		firstNonEmpty(deleted.GetDisplayTitle(), deleted.GetMerchantName()),
		abs64(deleted.GetAmount().GetUnits()),
		firstNonEmpty(deleted.GetAmount().GetCurrencyCode(), "MXN"),
	), nil
}

type savingsAction struct {
	Entity      string
	Action      string
	ID          string
	Name        string
	Description string
	Payee       string
	AmountUnits int64
	TargetUnits int64
	Frequency   savingsv1.RecurrenceFrequency
	Interval    int32
	LocalTime   string
	Timezone    string
	DayOfWeek   *int32
	DayOfMonth  *int32
	MonthOfYear *int32
}

var uuidPattern = regexp.MustCompile(`(?i)\b[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}\b`)
var quotedTextPattern = regexp.MustCompile(`["']([^"']{2,80})["']`)

func shouldHandleSavings(lower string) bool {
	return containsAny(
		lower,
		"apartado", "apartados", "meta financiera", "metas financieras", "meta", "metas",
		"recordatorio", "recordatorios", "pago recurrente", "pagos recurrentes", "recurrente",
	)
}

func resolveSavingsAction(message, lower string) savingsAction {
	entity := ""
	switch {
	case containsAny(lower, "apartado", "apartados"):
		entity = "apartado"
	case containsAny(lower, "meta financiera", "metas financieras", "meta", "metas"):
		entity = "financial_goal"
	case containsAny(lower, "recordatorio", "recordatorios", "pago recurrente", "pagos recurrentes", "recurrente"):
		entity = "recurring_payment_reminder"
	default:
		return savingsAction{}
	}

	action := "list"
	switch {
	case containsAny(lower, "elimina", "eliminar", "borra", "borrar"):
		action = "delete"
	case containsAny(lower, "actualiza", "actualizar", "edita", "editar", "modifica", "modificar", "cambia", "cambiar"):
		action = "update"
	case containsAny(lower, "crea", "crear", "agrega", "agregar", "nuevo", "nueva", "programa", "registra", "registrar"):
		action = "create"
	case containsAny(lower, "detalle", "consulta", "obten", "obtén") && uuidPattern.MatchString(message):
		action = "get"
	case containsAny(lower, "lista", "listar", "muestra", "mostrar", "ver mis", "mis "):
		action = "list"
	}

	id := ""
	if match := uuidPattern.FindString(message); match != "" {
		id = match
	}

	name := ""
	if match := quotedTextPattern.FindStringSubmatch(message); len(match) > 1 {
		name = strings.TrimSpace(match[1])
	}
	if name == "" {
		switch entity {
		case "apartado":
			name = "Apartado"
		case "financial_goal":
			name = "Meta financiera"
		case "recurring_payment_reminder":
			name = "Pago recurrente"
		}
	}

	amountUnits, _ := parseAmountUnits(message)
	targetUnits := amountUnits
	if targetUnits <= 0 {
		targetUnits = 1000
	}

	frequency := savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_MONTHLY
	switch {
	case containsAny(lower, "diario", "diaria", "cada dia", "cada día"):
		frequency = savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_DAILY
	case containsAny(lower, "semanal", "cada semana"):
		frequency = savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_WEEKLY
	case containsAny(lower, "anual", "cada año", "cada ano"):
		frequency = savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_YEARLY
	}

	return savingsAction{
		Entity:      entity,
		Action:      action,
		ID:          id,
		Name:        name,
		Payee:       extractCounterparty(message, "expense"),
		AmountUnits: amountUnits,
		TargetUnits: targetUnits,
		Frequency:   frequency,
		Interval:    1,
		LocalTime:   "09:00",
		Timezone:    "America/Mexico_City",
	}
}

func savingsToolName(entity, action string) string {
	switch entity {
	case "apartado":
		return action + "_apartado"
	case "financial_goal":
		return action + "_financial_goal"
	case "recurring_payment_reminder":
		return action + "_recurring_payment_reminder"
	default:
		return "savings_tool"
	}
}

func (s *Service) executeSavingsAction(
	ctx context.Context,
	send func(*agentv1.RunEvent) error,
	userID, threadID, runID, message, lower string,
) (string, error) {
	action := resolveSavingsAction(message, lower)
	if action.Entity == "" {
		return "", nil
	}

	toolName := savingsToolName(action.Entity, action.Action)
	toolCallID := uuid.NewString()
	if err := send(toolStart(threadID, runID, toolCallID, toolName)); err != nil {
		return "", err
	}
	if err := send(toolArgs(threadID, runID, toolCallID, jsonObject(map[string]any{
		"entity": action.Entity,
		"action": action.Action,
		"id":     action.ID,
		"name":   action.Name,
	}))); err != nil {
		return "", err
	}

	var stateID string
	var reply string
	var err error

	switch action.Entity {
	case "apartado":
		stateID, reply, err = s.executeApartadoTool(ctx, userID, action)
	case "financial_goal":
		stateID, reply, err = s.executeFinancialGoalTool(ctx, userID, action)
	case "recurring_payment_reminder":
		stateID, reply, err = s.executeReminderTool(ctx, userID, action)
	}
	if err != nil {
		return "", err
	}

	if err := send(toolEnd(threadID, runID, toolCallID)); err != nil {
		return "", err
	}
	if stateID != "" {
		if err := send(savingsDelta(threadID, runID, action.Entity, action.Action, stateID)); err != nil {
			return "", err
		}
	}
	if reply == "" {
		return "", nil
	}
	return "AUTO_REPLY:" + reply, nil
}

func (s *Service) executeApartadoTool(ctx context.Context, userID string, action savingsAction) (string, string, error) {
	switch action.Action {
	case "create":
		item, err := s.savings.CreateApartadoForUser(ctx, userID, &savingsv1.CreateApartadoRequest{
			Name:        action.Name,
			Description: action.Description,
			CurrentAmount: &financev1.Money{
				CurrencyCode: "MXN",
				Units:        maxInt64(action.AmountUnits, 0),
			},
			TargetAmount: &financev1.Money{
				CurrencyCode: "MXN",
				Units:        maxInt64(action.TargetUnits, 1),
			},
		})
		if err != nil {
			return "", "", err
		}
		return item.GetId(), fmt.Sprintf("Apartado creado: %s.", item.GetName()), nil
	case "get":
		if action.ID == "" {
			return "", "Compárteme el ID del apartado para consultarlo.", nil
		}
		item, err := s.savings.GetApartadoForUser(ctx, userID, action.ID)
		if err != nil {
			return "", "", err
		}
		return item.GetId(), fmt.Sprintf("Apartado: %s (%d %s).", item.GetName(), item.GetCurrentAmount().GetUnits(), item.GetCurrentAmount().GetCurrencyCode()), nil
	case "list":
		items, err := s.savings.ListApartadosForUser(ctx, userID, 10)
		if err != nil {
			return "", "", err
		}
		if len(items) == 0 {
			return "", "No tienes apartados activos.", nil
		}
		parts := make([]string, 0, minInt(len(items), 4))
		for i, item := range items {
			if i >= 4 {
				break
			}
			parts = append(parts, item.GetName())
		}
		return items[0].GetId(), "Tus apartados: " + strings.Join(parts, ", ") + ".", nil
	case "update":
		if action.ID == "" {
			return "", "Compárteme el ID del apartado que quieres actualizar.", nil
		}
		current, err := s.savings.GetApartadoForUser(ctx, userID, action.ID)
		if err != nil {
			return "", "", err
		}
		item, err := s.savings.UpdateApartadoForUser(ctx, userID, &savingsv1.UpdateApartadoRequest{
			ApartadoId:  current.GetId(),
			Name:        firstNonEmpty(action.Name, current.GetName()),
			Description: firstNonEmpty(action.Description, current.GetDescription()),
			CurrentAmount: &financev1.Money{
				CurrencyCode: current.GetCurrentAmount().GetCurrencyCode(),
				Units:        choosePositive(action.AmountUnits, current.GetCurrentAmount().GetUnits()),
				Nanos:        current.GetCurrentAmount().GetNanos(),
			},
			TargetAmount: &financev1.Money{
				CurrencyCode: current.GetTargetAmount().GetCurrencyCode(),
				Units:        choosePositive(action.TargetUnits, current.GetTargetAmount().GetUnits()),
				Nanos:        current.GetTargetAmount().GetNanos(),
			},
			FinancialGoalId: current.FinancialGoalId,
		})
		if err != nil {
			return "", "", err
		}
		return item.GetId(), fmt.Sprintf("Apartado actualizado: %s.", item.GetName()), nil
	case "delete":
		if action.ID == "" {
			return "", "Compárteme el ID del apartado que quieres eliminar.", nil
		}
		item, err := s.savings.DeleteApartadoForUser(ctx, userID, action.ID)
		if err != nil {
			return "", "", err
		}
		return item.GetId(), fmt.Sprintf("Apartado eliminado: %s.", item.GetName()), nil
	default:
		return "", "", nil
	}
}

func (s *Service) executeFinancialGoalTool(ctx context.Context, userID string, action savingsAction) (string, string, error) {
	switch action.Action {
	case "create":
		item, err := s.savings.CreateFinancialGoalForUser(ctx, userID, &savingsv1.CreateFinancialGoalRequest{
			Name:        action.Name,
			Description: action.Description,
			TargetAmount: &financev1.Money{
				CurrencyCode: "MXN",
				Units:        maxInt64(action.TargetUnits, 1),
			},
		})
		if err != nil {
			return "", "", err
		}
		return item.GetId(), fmt.Sprintf("Meta creada: %s.", item.GetName()), nil
	case "get":
		if action.ID == "" {
			return "", "Compárteme el ID de la meta para consultarla.", nil
		}
		item, err := s.savings.GetFinancialGoalForUser(ctx, userID, action.ID)
		if err != nil {
			return "", "", err
		}
		return item.GetId(), fmt.Sprintf("Meta: %s (%d/%d %s).", item.GetName(), item.GetCurrentAmount().GetUnits(), item.GetTargetAmount().GetUnits(), item.GetTargetAmount().GetCurrencyCode()), nil
	case "list":
		items, err := s.savings.ListFinancialGoalsForUser(ctx, userID, 10)
		if err != nil {
			return "", "", err
		}
		if len(items) == 0 {
			return "", "No tienes metas financieras activas.", nil
		}
		parts := make([]string, 0, minInt(len(items), 4))
		for i, item := range items {
			if i >= 4 {
				break
			}
			parts = append(parts, item.GetName())
		}
		return items[0].GetId(), "Tus metas: " + strings.Join(parts, ", ") + ".", nil
	case "update":
		if action.ID == "" {
			return "", "Compárteme el ID de la meta que quieres actualizar.", nil
		}
		current, err := s.savings.GetFinancialGoalForUser(ctx, userID, action.ID)
		if err != nil {
			return "", "", err
		}
		item, err := s.savings.UpdateFinancialGoalForUser(ctx, userID, &savingsv1.UpdateFinancialGoalRequest{
			FinancialGoalId: current.GetId(),
			Name:            firstNonEmpty(action.Name, current.GetName()),
			Description:     firstNonEmpty(action.Description, current.GetDescription()),
			TargetAmount: &financev1.Money{
				CurrencyCode: current.GetTargetAmount().GetCurrencyCode(),
				Units:        choosePositive(action.TargetUnits, current.GetTargetAmount().GetUnits()),
				Nanos:        current.GetTargetAmount().GetNanos(),
			},
			TargetDate: current.GetTargetDate(),
		})
		if err != nil {
			return "", "", err
		}
		return item.GetId(), fmt.Sprintf("Meta actualizada: %s.", item.GetName()), nil
	case "delete":
		if action.ID == "" {
			return "", "Compárteme el ID de la meta que quieres eliminar.", nil
		}
		item, err := s.savings.DeleteFinancialGoalForUser(ctx, userID, action.ID)
		if err != nil {
			return "", "", err
		}
		return item.GetId(), fmt.Sprintf("Meta eliminada: %s.", item.GetName()), nil
	default:
		return "", "", nil
	}
}

func (s *Service) executeReminderTool(ctx context.Context, userID string, action savingsAction) (string, string, error) {
	now := time.Now()
	day := int32(now.Day())
	month := int32(now.Month())
	weekday := int32(now.Weekday())

	ensureAnchors := func(freq savingsv1.RecurrenceFrequency, in savingsAction) (dow, dom, moy *int32) {
		switch freq {
		case savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_WEEKLY:
			if in.DayOfWeek != nil {
				return in.DayOfWeek, nil, nil
			}
			return &weekday, nil, nil
		case savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_MONTHLY:
			if in.DayOfMonth != nil {
				return nil, in.DayOfMonth, nil
			}
			return nil, &day, nil
		case savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_YEARLY:
			dom = in.DayOfMonth
			moy = in.MonthOfYear
			if dom == nil {
				dom = &day
			}
			if moy == nil {
				moy = &month
			}
			return nil, dom, moy
		default:
			return nil, nil, nil
		}
	}

	switch action.Action {
	case "create":
		freq := action.Frequency
		if freq == savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_UNSPECIFIED {
			freq = savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_MONTHLY
		}
		dow, dom, moy := ensureAnchors(freq, action)
		item, err := s.savings.CreateRecurringPaymentReminderForUser(ctx, userID, &savingsv1.CreateRecurringPaymentReminderRequest{
			Title:       action.Name,
			Payee:       action.Payee,
			Amount:      &financev1.Money{CurrencyCode: "MXN", Units: maxInt64(action.AmountUnits, 1)},
			Frequency:   freq,
			Interval:    maxInt32(action.Interval, 1),
			DayOfWeek:   dow,
			DayOfMonth:  dom,
			MonthOfYear: moy,
			LocalTime:   firstNonEmpty(action.LocalTime, "09:00"),
			Timezone:    firstNonEmpty(action.Timezone, "America/Mexico_City"),
		})
		if err != nil {
			return "", "", err
		}
		return item.GetId(), fmt.Sprintf("Recordatorio creado: %s.", item.GetTitle()), nil
	case "get":
		if action.ID == "" {
			return "", "Compárteme el ID del recordatorio para consultarlo.", nil
		}
		item, err := s.savings.GetRecurringPaymentReminderForUser(ctx, userID, action.ID)
		if err != nil {
			return "", "", err
		}
		return item.GetId(), fmt.Sprintf("Recordatorio: %s (%d %s).", item.GetTitle(), item.GetAmount().GetUnits(), item.GetAmount().GetCurrencyCode()), nil
	case "list":
		items, err := s.savings.ListRecurringPaymentRemindersForUser(ctx, userID, 10)
		if err != nil {
			return "", "", err
		}
		if len(items) == 0 {
			return "", "No tienes recordatorios recurrentes activos.", nil
		}
		parts := make([]string, 0, minInt(len(items), 4))
		for i, item := range items {
			if i >= 4 {
				break
			}
			parts = append(parts, item.GetTitle())
		}
		return items[0].GetId(), "Tus recordatorios: " + strings.Join(parts, ", ") + ".", nil
	case "update":
		if action.ID == "" {
			return "", "Compárteme el ID del recordatorio que quieres actualizar.", nil
		}
		current, err := s.savings.GetRecurringPaymentReminderForUser(ctx, userID, action.ID)
		if err != nil {
			return "", "", err
		}
		freq := current.GetFrequency()
		if action.Frequency != savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_UNSPECIFIED {
			freq = action.Frequency
		}
		dow := current.DayOfWeek
		dom := current.DayOfMonth
		moy := current.MonthOfYear
		if action.Frequency != savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_UNSPECIFIED {
			dow, dom, moy = ensureAnchors(freq, action)
		}
		item, err := s.savings.UpdateRecurringPaymentReminderForUser(ctx, userID, &savingsv1.UpdateRecurringPaymentReminderRequest{
			RecurringPaymentReminderId: current.GetId(),
			Title:                      firstNonEmpty(action.Name, current.GetTitle()),
			Payee:                      firstNonEmpty(action.Payee, current.GetPayee()),
			Amount: &financev1.Money{
				CurrencyCode: current.GetAmount().GetCurrencyCode(),
				Units:        choosePositive(action.AmountUnits, current.GetAmount().GetUnits()),
				Nanos:        current.GetAmount().GetNanos(),
			},
			Frequency:   freq,
			Interval:    maxInt32(maxInt32(action.Interval, current.GetInterval()), 1),
			DayOfWeek:   dow,
			DayOfMonth:  dom,
			MonthOfYear: moy,
			LocalTime:   firstNonEmpty(action.LocalTime, current.GetLocalTime()),
			Timezone:    firstNonEmpty(action.Timezone, current.GetTimezone()),
		})
		if err != nil {
			return "", "", err
		}
		return item.GetId(), fmt.Sprintf("Recordatorio actualizado: %s.", item.GetTitle()), nil
	case "delete":
		if action.ID == "" {
			return "", "Compárteme el ID del recordatorio que quieres eliminar.", nil
		}
		item, err := s.savings.DeleteRecurringPaymentReminderForUser(ctx, userID, action.ID)
		if err != nil {
			return "", "", err
		}
		return item.GetId(), fmt.Sprintf("Recordatorio eliminado: %s.", item.GetTitle()), nil
	default:
		return "", "", nil
	}
}

func buildLedgerActionPrompt(
	request *agentv1.RunRequest,
	lastUserMessage string,
	movements []*financev1.Expense,
) string {
	return fmt.Sprintf(
		`Extrae la intención de ledger del usuario y responde SOLO JSON válido.
Formato JSON:
{"action":"none|list|create|update|delete|undo","kind":"expense|income|any","amount_units":number,"currency":"MXN","merchant":"texto","category":"texto","temporal_reference":"today|yesterday|latest|","confidence":0.0,"missing_fields":["campo"]}

Herramientas disponibles:
%s

Movimientos recientes:
%s

Mensaje del usuario:
%s`,
		formatToolCatalog(request.GetTools()),
		movementContext(movements),
		lastUserMessage,
	)
}

func heuristicLedgerAction(lastUserMessage string) ledgerAction {
	lower := strings.ToLower(lastUserMessage)
	if shouldUndoRegistration(lower) {
		return ledgerAction{Action: "undo", Kind: "any", Currency: "MXN"}
	}
	if shouldDeleteMovement(lower) {
		kind, ok := detectMovementKind(lower)
		if !ok {
			kind = "expense"
		}
		return ledgerAction{
			Action:      "delete",
			Kind:        kind,
			Merchant:    extractCounterparty(lastUserMessage, kind),
			TemporalRef: detectTemporalReference(lower),
			Currency:    "MXN",
		}
	}
	if intent, ok := parseManualRegistrationIntent(lastUserMessage); ok {
		action := "create"
		if intent.preferUpdate {
			action = "update"
		}
		amount := intent.amountUnits
		return ledgerAction{
			Action:      action,
			Kind:        intent.kind,
			AmountUnits: &amount,
			Currency:    intent.currencyCode,
			Merchant:    intent.merchantName,
			Category:    intent.category,
			TemporalRef: detectTemporalReference(lower),
		}
	}
	if shouldListMovements(lower) {
		return ledgerAction{
			Action: "list",
			Kind:   inferMovementKindFromQuestion(lower),
		}
	}
	return ledgerAction{Action: "none", Kind: inferMovementKindFromQuestion(lower)}
}

func parseLedgerActionJSON(raw string) (ledgerAction, bool) {
	payload := extractJSONObject(raw)
	if payload == "" {
		return ledgerAction{}, false
	}
	var out ledgerAction
	if err := json.Unmarshal([]byte(payload), &out); err != nil {
		return ledgerAction{}, false
	}
	return out, true
}

func extractJSONObject(raw string) string {
	start := strings.Index(raw, "{")
	end := strings.LastIndex(raw, "}")
	if start < 0 || end <= start {
		return ""
	}
	return raw[start : end+1]
}

func (s *Service) generateText(ctx context.Context, prompt string) (string, error) {
	if s.model == nil {
		return "", fmt.Errorf("model is not configured")
	}
	var out strings.Builder
	for chunk, err := range genkit.GenerateStream(
		ctx,
		s.model,
		ai.WithPrompt(prompt),
		ai.WithToolChoice(ai.ToolChoiceNone),
	) {
		if err != nil {
			return "", err
		}
		if chunk == nil {
			continue
		}
		if chunk.Done {
			if text := strings.TrimSpace(chunk.Response.Text()); text != "" && out.Len() == 0 {
				out.WriteString(text)
			}
			continue
		}
		out.WriteString(chunk.Chunk.Text())
	}
	return strings.TrimSpace(out.String()), nil
}

func (s *Service) generateReply(ctx context.Context, request *agentv1.RunRequest, lastUserMessage, toolContext string) string {
	if auto := extractAutoReply(toolContext); auto != "" {
		auto = compactPlainURLs(auto)
		return ensureAprendeCreceSourceLink(auto, toolContext)
	}

	prompt := buildPrompt(s.systemPrompt, request, lastUserMessage, toolContext)
	if s.model == nil {
		reply := compactPlainURLs(fallbackReply(lastUserMessage, toolContext))
		return ensureAprendeCreceSourceLink(reply, toolContext)
	}

	var reply strings.Builder
	for chunk, err := range genkit.GenerateStream(
		ctx,
		s.model,
		ai.WithPrompt(prompt),
		ai.WithToolChoice(ai.ToolChoiceNone),
	) {
		if err != nil {
			s.logger.Warn("agent generation failed, using fallback reply", "error", err)
			reply := compactPlainURLs(fallbackReply(lastUserMessage, toolContext))
			return ensureAprendeCreceSourceLink(reply, toolContext)
		}
		if chunk == nil {
			continue
		}
		if chunk.Done {
			if text := strings.TrimSpace(chunk.Response.Text()); text != "" && reply.Len() == 0 {
				reply.WriteString(text)
			}
			continue
		}
		reply.WriteString(chunk.Chunk.Text())
	}

	result := strings.TrimSpace(reply.String())
	if result == "" {
		result = fallbackReply(lastUserMessage, toolContext)
	}
	if looksLikeToolCallMarkup(result) {
		if fallback := fallbackAprendeCreceReply(toolContext); fallback != "" {
			result = fallback
		} else {
			result = fallbackReply(lastUserMessage, toolContext)
		}
	}
	if shouldAttemptAutoRegistration(strings.ToLower(lastUserMessage)) && looksLikeManualInstruction(result) {
		result = "Lo gestiono yo directamente. Si quieres corregir un movimiento, dime el monto final y el comercio, y lo actualizo."
	}
	result = compactPlainURLs(result)

	return ensureAprendeCreceSourceLink(result, toolContext)
}

func looksLikeToolCallMarkup(text string) bool {
	lower := strings.ToLower(strings.TrimSpace(text))
	if lower == "" {
		return false
	}
	return strings.Contains(lower, "<function_call") ||
		strings.Contains(lower, "</function_call>") ||
		strings.Contains(lower, "<tool_call") ||
		strings.Contains(lower, "<argument name=")
}

func buildPrompt(systemPrompt string, request *agentv1.RunRequest, lastUserMessage, toolContext string) string {
	var conversation strings.Builder
	for _, message := range request.GetMessages() {
		if strings.TrimSpace(message.GetContent()) == "" {
			continue
		}
		conversation.WriteString(message.GetRole())
		conversation.WriteString(": ")
		conversation.WriteString(message.GetContent())
		conversation.WriteString("\n")
	}

	basePrompt := strings.TrimSpace(systemPrompt)
	if basePrompt == "" {
		basePrompt = fallbackSystemPrompt
	}
	return fmt.Sprintf(
		`%s

Herramientas disponibles en esta corrida:
%s

Contexto de herramientas:
%s

Conversacion:
%s

Ultimo mensaje del usuario:
%s`,
		basePrompt,
		formatToolCatalog(request.GetTools()),
		toolContext,
		conversation.String(),
		lastUserMessage,
	)
}

func fallbackReply(lastUserMessage, toolContext string) string {
	switch {
	case shouldUndoRegistration(strings.ToLower(lastUserMessage)):
		return "Listo, revierto el ultimo movimiento registrado y te confirmo como quedo."
	case shouldSkipRegistration(strings.ToLower(lastUserMessage)):
		return "Entendido, no registro ese movimiento."
	case parseManualIntentOnly(lastUserMessage):
		return "Puedo registrar ese movimiento por ti de inmediato y reflejarlo en tu historial."
	case shouldAttemptAutoRegistration(strings.ToLower(lastUserMessage)):
		return "Puedo registrarlo por ti en automático; compárteme monto exacto y si es gasto o ingreso."
	case shouldFetchScore(strings.ToLower(lastUserMessage)):
		return "Ya tengo tu contexto financiero reciente. Puedo explicarte tu puntaje actual y los factores que mas lo empujan hacia arriba o hacia abajo."
	case shouldFetchExpenses(strings.ToLower(lastUserMessage)):
		return "Revise tus gastos recientes. Si quieres, te ayudo a detectar en que categoria te estas cargando mas o cuales tickets te conviene confirmar primero."
	case shouldFetchReceipt(strings.ToLower(lastUserMessage)):
		return "Puedo ayudarte a revisar el borrador del ticket y dejarlo listo antes de confirmarlo como gasto."
	case toolContext != "":
		return "Listo. Use el contexto disponible para seguir con la accion dentro de la app y mantener la conversacion enfocada en tus gastos."
	default:
		return "Puedo ayudarte con tickets, gastos, historial y puntaje. Si me dices que quieres revisar, te respondo con el contexto financiero disponible."
	}
}

func latestUserMessage(messages []*agentv1.ChatMessage) string {
	for i := len(messages) - 1; i >= 0; i-- {
		if strings.EqualFold(messages[i].GetRole(), "user") {
			return messages[i].GetContent()
		}
	}
	return ""
}

func shouldFetchScore(text string) bool {
	return strings.Contains(text, "puntaje") || strings.Contains(text, "score")
}

func shouldFetchExpenses(text string) bool {
	return shouldListMovements(text)
}

func shouldFetchReceipt(text string) bool {
	return strings.Contains(text, "ticket") || strings.Contains(text, "recibo") || strings.Contains(text, "voucher")
}

func shouldFetchAprendeCrece(text string) bool {
	lower := strings.ToLower(strings.TrimSpace(text))
	if lower == "" {
		return false
	}
	if shouldFetchReceipt(lower) {
		return false
	}
	hasTopic := containsAny(
		lower,
		"aprende y crece",
		"educacion financiera", "educación financiera",
		"finanzas personales",
		"ahorro", "ahorrar",
		"presupuesto",
		"deuda", "deudas",
		"credito", "crédito",
		"afore",
		"inversion", "inversión", "invertir",
		"seguros", "seguro",
		"salud financiera",
		"ciberseguridad",
	)
	if !hasTopic && !catWordPattern.MatchString(normalizeAprendeCreceText(lower)) {
		return false
	}
	if containsAny(
		lower,
		"registra", "registrar",
		"actualiza", "actualizar",
		"elimina", "eliminar", "borra", "borrar",
		"deshaz", "deshacer",
	) &&
		containsAny(lower, "gasto", "gastos", "ingreso", "ingresos", "movimiento", "movimientos", "historial") {
		return false
	}
	return true
}

func compactPlainURLs(text string) string {
	trimmed := strings.TrimSpace(text)
	if trimmed == "" {
		return trimmed
	}
	matches := plainURLPattern.FindAllStringIndex(trimmed, -1)
	if len(matches) == 0 {
		return trimmed
	}

	urlLabels := map[string]string{}
	labelCount := 0

	var out strings.Builder
	last := 0
	for _, span := range matches {
		start, end := span[0], span[1]
		if start < last {
			continue
		}

		out.WriteString(trimmed[last:start])

		raw := trimmed[start:end]
		url, trailing := splitURLAndTrailingPunctuation(raw)
		if url == "" || isInsideMarkdownLink(trimmed, start) {
			out.WriteString(raw)
			last = end
			continue
		}

		label, ok := urlLabels[url]
		if !ok {
			labelCount++
			label = fmt.Sprintf("Fuente %d", labelCount)
			urlLabels[url] = label
		}
		out.WriteString(fmt.Sprintf("[%s](%s)%s", label, url, trailing))
		last = end
	}
	out.WriteString(trimmed[last:])
	return out.String()
}

func splitURLAndTrailingPunctuation(raw string) (url, trailing string) {
	if raw == "" {
		return "", ""
	}
	end := len(raw)
	for end > 0 {
		switch raw[end-1] {
		case '.', ',', ';', ':', '!', '?':
			end--
		default:
			return raw[:end], raw[end:]
		}
	}
	return raw, ""
}

func isInsideMarkdownLink(text string, start int) bool {
	if start <= 0 || start > len(text)-1 {
		return false
	}
	if text[start-1] != '(' {
		return false
	}
	openBracket := strings.LastIndex(text[:start], "[")
	closeBracket := strings.LastIndex(text[:start], "]")
	return openBracket >= 0 && closeBracket > openBracket
}

func isLedgerRelated(text string) bool {
	if kind, ok := detectMovementKind(strings.ToLower(text)); ok && kind != "" {
		return true
	}
	return containsAny(
		text,
		"gasto", "gastos", "egreso", "egresos",
		"ingreso", "ingresos", "movimiento", "movimientos", "historial", "balance",
		"registr", "actualiz", "corrig", "elimin", "borr", "deshaz", "deshacer",
		"me depositaron", "me pagaron", "me cayeron",
		"me gast", "gaste", "gasté", "pague", "pagué", "compre", "compré",
	)
}

func shouldListMovements(text string) bool {
	return containsAny(
		text,
		"qué gastos", "que gastos",
		"qué ingresos", "que ingresos",
		"qué movimientos", "que movimientos",
		"lista", "historial", "movimientos recientes", "mis gastos", "mis ingresos",
	)
}

func shouldDeleteMovement(text string) bool {
	return containsAny(
		text,
		"borra", "elimina", "eliminar", "quita", "quita el", "borrar", "remueve",
	)
}

func inferMovementKindFromQuestion(text string) string {
	switch {
	case containsAny(text, "ingreso", "ingresos", "depositaron", "pagaron"):
		return "income"
	case containsAny(text, "gasto", "gastos", "egreso", "egresos"):
		return "expense"
	default:
		return "any"
	}
}

func manualLabelForKind(kind string) string {
	if kind == "income" {
		return "Ingreso manual"
	}
	return "Gasto manual"
}

func summarizeMovementsForUser(expenses []*financev1.Expense, kind string) string {
	filtered := filterMovementsByKind(expenses, kind)
	if len(filtered) == 0 {
		switch kind {
		case "income":
			return "No encontré ingresos recientes registrados."
		case "expense":
			return "No encontré gastos recientes registrados."
		default:
			return "No encontré movimientos recientes registrados."
		}
	}

	parts := make([]string, 0, len(filtered))
	for _, expense := range filtered {
		parts = append(parts, fmt.Sprintf("%s %d %s", firstNonEmpty(expense.GetDisplayTitle(), expense.GetMerchantName()), abs64(expense.GetAmount().GetUnits()), firstNonEmpty(expense.GetAmount().GetCurrencyCode(), "MXN")))
	}
	switch kind {
	case "income":
		return "Tus ingresos recientes: " + strings.Join(parts, "; ")
	case "expense":
		return "Tus gastos recientes: " + strings.Join(parts, "; ")
	default:
		return "Tus movimientos recientes: " + strings.Join(parts, "; ")
	}
}

func filterMovementsByKind(expenses []*financev1.Expense, kind string) []*financev1.Expense {
	if kind == "" || kind == "any" {
		return expenses
	}
	filtered := make([]*financev1.Expense, 0, len(expenses))
	for _, entry := range expenses {
		if entry == nil || entry.GetAmount() == nil {
			continue
		}
		if kind == "income" && entry.GetAmount().GetUnits() < 0 {
			filtered = append(filtered, entry)
		}
		if kind == "expense" && entry.GetAmount().GetUnits() >= 0 {
			filtered = append(filtered, entry)
		}
	}
	return filtered
}

func detectTemporalReference(text string) string {
	switch {
	case containsAny(text, "ayer", "yesterday"):
		return "yesterday"
	case containsAny(text, "hoy", "today"):
		return "today"
	case containsAny(text, "ultimo", "último", "latest", "reciente"):
		return "latest"
	default:
		return ""
	}
}

func normalizeTemporalReference(value string) string {
	switch strings.ToLower(strings.TrimSpace(value)) {
	case "yesterday", "ayer":
		return "yesterday"
	case "today", "hoy":
		return "today"
	case "latest", "ultimo", "último":
		return "latest"
	default:
		return ""
	}
}

func normalizeLedgerKind(value string) string {
	switch strings.ToLower(strings.TrimSpace(value)) {
	case "income", "ingreso", "ingresos":
		return "income"
	case "expense", "gasto", "gastos", "egreso", "egresos":
		return "expense"
	case "any", "todos", "movimientos":
		return "any"
	default:
		return ""
	}
}

func formatToolCatalog(tools []*agentv1.ToolDefinition) string {
	if len(tools) == 0 {
		return "Sin catálogo explícito de tools."
	}
	lines := make([]string, 0, len(tools))
	for _, tool := range tools {
		if tool == nil {
			continue
		}
		line := fmt.Sprintf("- %s: %s", tool.GetName(), strings.TrimSpace(tool.GetDescription()))
		if params := tool.GetParameters(); params != nil {
			if serialized, err := json.Marshal(params.AsMap()); err == nil && string(serialized) != "{}" {
				line += " params=" + string(serialized)
			}
		}
		lines = append(lines, line)
	}
	if len(lines) == 0 {
		return "Sin catálogo explícito de tools."
	}
	return strings.Join(lines, "\n")
}

func navigationFor(text string) (route string, toolName string) {
	switch {
	case strings.Contains(text, "tracker"), strings.Contains(text, "escanear"), strings.Contains(text, "subir ticket"):
		return "/tracker", "open_tracker"
	case strings.Contains(text, "historial"):
		return "/history", "open_history"
	case strings.Contains(text, "puntaje"), strings.Contains(text, "score"):
		return "/score", "open_score"
	case strings.Contains(text, "ajustes"), strings.Contains(text, "configuracion"), strings.Contains(text, "settings"):
		return "/settings", "open_settings"
	default:
		return "", ""
	}
}

func movementContext(expenses []*financev1.Expense) string {
	if len(expenses) == 0 {
		return "No hay movimientos confirmados recientes."
	}

	parts := make([]string, 0, len(expenses))
	for _, expense := range expenses {
		kind := "gasto"
		if expense.GetAmount().GetUnits() < 0 {
			kind = "ingreso"
		}
		parts = append(parts, fmt.Sprintf("%s: %d %s en %s (%s)", firstNonEmpty(expense.GetMerchantName(), expense.GetDisplayTitle()), abs64(expense.GetAmount().GetUnits()), expense.GetAmount().GetCurrencyCode(), expense.GetCategory(), kind))
	}
	return "Movimientos recientes: " + strings.Join(parts, "; ")
}

func stateString(state *structpb.Struct, key string) string {
	if state == nil {
		return ""
	}
	value, ok := state.AsMap()[key]
	if !ok {
		return ""
	}
	asString, _ := value.(string)
	return asString
}

func runStarted(threadID, runID string) *agentv1.RunEvent {
	return &agentv1.RunEvent{
		Event: &agentv1.RunEvent_RunStarted{
			RunStarted: &agentv1.RunStarted{
				ThreadId: threadID,
				RunId:    runID,
			},
		},
	}
}

func runFinished(threadID, runID string) *agentv1.RunEvent {
	return &agentv1.RunEvent{
		Event: &agentv1.RunEvent_RunFinished{
			RunFinished: &agentv1.RunFinished{
				ThreadId: threadID,
				RunId:    runID,
			},
		},
	}
}

func runError(threadID, runID, message, code string) *agentv1.RunEvent {
	return &agentv1.RunEvent{
		Event: &agentv1.RunEvent_RunError{
			RunError: &agentv1.RunError{
				ThreadId: threadID,
				RunId:    runID,
				Message:  message,
				Code:     code,
			},
		},
	}
}

func textStart(threadID, runID, messageID string) *agentv1.RunEvent {
	return &agentv1.RunEvent{
		Event: &agentv1.RunEvent_TextMessageStart{
			TextMessageStart: &agentv1.TextMessageStart{
				ThreadId:  threadID,
				RunId:     runID,
				MessageId: messageID,
				Role:      "assistant",
			},
		},
	}
}

func textDelta(threadID, runID, messageID, delta string) *agentv1.RunEvent {
	return &agentv1.RunEvent{
		Event: &agentv1.RunEvent_TextMessageContent{
			TextMessageContent: &agentv1.TextMessageContent{
				ThreadId:  threadID,
				RunId:     runID,
				MessageId: messageID,
				Delta:     delta,
			},
		},
	}
}

func textEnd(threadID, runID, messageID string) *agentv1.RunEvent {
	return &agentv1.RunEvent{
		Event: &agentv1.RunEvent_TextMessageEnd{
			TextMessageEnd: &agentv1.TextMessageEnd{
				ThreadId:  threadID,
				RunId:     runID,
				MessageId: messageID,
			},
		},
	}
}

func toolStart(threadID, runID, toolCallID, name string) *agentv1.RunEvent {
	return &agentv1.RunEvent{
		Event: &agentv1.RunEvent_ToolCallStart{
			ToolCallStart: &agentv1.ToolCallStart{
				ThreadId:   threadID,
				RunId:      runID,
				ToolCallId: toolCallID,
				Name:       name,
			},
		},
	}
}

func toolArgs(threadID, runID, toolCallID, delta string) *agentv1.RunEvent {
	return &agentv1.RunEvent{
		Event: &agentv1.RunEvent_ToolCallArgs{
			ToolCallArgs: &agentv1.ToolCallArgs{
				ThreadId:   threadID,
				RunId:      runID,
				ToolCallId: toolCallID,
				Delta:      delta,
			},
		},
	}
}

func toolEnd(threadID, runID, toolCallID string) *agentv1.RunEvent {
	return &agentv1.RunEvent{
		Event: &agentv1.RunEvent_ToolCallEnd{
			ToolCallEnd: &agentv1.ToolCallEnd{
				ThreadId:   threadID,
				RunId:      runID,
				ToolCallId: toolCallID,
			},
		},
	}
}

func navigationDelta(threadID, runID, route string) *agentv1.RunEvent {
	delta, _ := structpb.NewStruct(map[string]any{
		"navigation": map[string]any{
			"route": route,
		},
	})

	return &agentv1.RunEvent{
		Event: &agentv1.RunEvent_StateDelta{
			StateDelta: &agentv1.StateDelta{
				ThreadId: threadID,
				RunId:    runID,
				Delta:    delta,
			},
		},
	}
}

func scoreDelta(threadID, runID string, summary *financev1.ScoreSummary) *agentv1.RunEvent {
	return &agentv1.RunEvent{
		Event: &agentv1.RunEvent_StateDelta{
			StateDelta: &agentv1.StateDelta{
				ThreadId:     threadID,
				RunId:        runID,
				ScoreSummary: summary,
			},
		},
	}
}

func ledgerDelta(threadID, runID, action string, expense *financev1.Expense) *agentv1.RunEvent {
	delta, _ := structpb.NewStruct(map[string]any{
		"ledger": map[string]any{
			"updated": true,
			"action":  action,
			"id":      expense.GetId(),
		},
	})

	return &agentv1.RunEvent{
		Event: &agentv1.RunEvent_StateDelta{
			StateDelta: &agentv1.StateDelta{
				ThreadId: threadID,
				RunId:    runID,
				Delta:    delta,
			},
		},
	}
}

func savingsDelta(threadID, runID, entity, action, id string) *agentv1.RunEvent {
	delta, _ := structpb.NewStruct(map[string]any{
		"savings": map[string]any{
			"updated": true,
			"entity":  entity,
			"action":  action,
			"id":      id,
		},
	})

	return &agentv1.RunEvent{
		Event: &agentv1.RunEvent_StateDelta{
			StateDelta: &agentv1.StateDelta{
				ThreadId: threadID,
				RunId:    runID,
				Delta:    delta,
			},
		},
	}
}

func splitChunks(text string, size int) []string {
	if size <= 0 || text == "" {
		return []string{text}
	}

	chunks := make([]string, 0, len(text)/size+1)
	var current strings.Builder
	currentSize := 0
	for _, r := range text {
		current.WriteRune(r)
		currentSize++
		if currentSize >= size {
			chunks = append(chunks, current.String())
			current.Reset()
			currentSize = 0
		}
	}
	if current.Len() > 0 {
		chunks = append(chunks, current.String())
	}

	if len(chunks) == 0 && utf8.ValidString(text) {
		return []string{text}
	}

	return chunks
}

func firstNonEmpty(values ...string) string {
	for _, value := range values {
		if trimmed := strings.TrimSpace(value); trimmed != "" {
			return trimmed
		}
	}
	return ""
}

type manualRegistrationIntent struct {
	kind         string
	preferUpdate bool
	merchantName string
	category     string
	currencyCode string
	amountUnits  int64
}

var amountPattern = regexp.MustCompile(`\d[\d\.,]*`)
var trailingPunctuation = regexp.MustCompile(`[!?.,;:]+$`)
var plainURLPattern = regexp.MustCompile(`https?://[^\s<>"']+`)
var catWordPattern = regexp.MustCompile(`\bcat\b`)

func parseManualRegistrationIntent(text string) (*manualRegistrationIntent, bool) {
	lower := strings.ToLower(text)
	kind, ok := detectMovementKind(lower)
	if !ok {
		return nil, false
	}
	amountUnits, ok := parseAmountUnits(text)
	if !ok || amountUnits <= 0 {
		return nil, false
	}
	merchant := extractCounterparty(text, kind)
	category := inferCategory(lower, kind, merchant)

	return &manualRegistrationIntent{
		kind:         kind,
		preferUpdate: isUpdateIntent(lower),
		merchantName: merchant,
		category:     category,
		currencyCode: "MXN",
		amountUnits:  amountUnits,
	}, true
}

func parseManualIntentOnly(text string) bool {
	_, ok := parseManualRegistrationIntent(text)
	return ok
}

func detectMovementKind(lowerText string) (string, bool) {
	switch {
	case hasRegistrationCommand(lowerText) && containsAny(lowerText, "ingreso", "nomina", "nómina", "sueldo", "salario"):
		return "income", true
	case hasRegistrationCommand(lowerText) && containsAny(lowerText, "gasto", "egreso", "compra", "pago", "ticket", "recibo"):
		return "expense", true
	case containsAny(lowerText, "que registr", "que registre", "que registré") && containsAny(lowerText, "en realidad", "era de", "fue de", "fueron"):
		if containsAny(lowerText, "ingreso", "nomina", "nómina", "sueldo", "salario") {
			return "income", true
		}
		return "expense", true
	case containsAny(lowerText, "el gasto de ", "el gasto del ", "gasto de ", "gasto del ") && containsAny(lowerText, "actualiza", "actualíz", "corrige", "en realidad", "fueron", "fue"):
		return "expense", true
	case containsAny(lowerText,
		"me gaste", "me gasté", "gaste", "gasté", "pague", "pagué",
		"compre", "compré", "me costo", "me costó", "pague", "pagué",
	):
		return "expense", true
	case containsAny(lowerText,
		"me pagaron", "recibi", "recibí", "ingrese", "ingresé", "gane",
		"gané", "cobre", "cobré", "depositaron", "me depositaron", "me llego", "me llegó",
		"me cayeron", "me cayo", "me cayó", "me callo", "me calló",
	):
		return "income", true
	default:
		return "", false
	}
}

func parseAmountUnits(text string) (int64, bool) {
	type candidate struct {
		amount int64
		score  int
		start  int
	}
	candidates := make([]candidate, 0, 4)
	lower := strings.ToLower(text)
	for _, span := range amountPattern.FindAllStringIndex(text, -1) {
		start, end := span[0], span[1]
		if adjacentToLetter(text, start, end) {
			continue
		}
		token := text[start:end]
		raw := strings.TrimSpace(token)
		lastSep := strings.LastIndexAny(raw, ".,")
		integerPart := raw
		if lastSep > 0 && len(raw)-lastSep-1 <= 2 {
			integerPart = raw[:lastSep]
		}
		digits := onlyDigits(integerPart)
		if digits == "" {
			continue
		}
		parsed, err := strconv.ParseInt(digits, 10, 64)
		if err != nil || parsed <= 0 {
			continue
		}
		score := 0
		if end < len(lower) && containsAny(lower[end:minInt(end+18, len(lower))], "peso", "mxn") {
			score += 120
		}
		if start > 0 && text[start-1] == '$' {
			score += 100
		}
		if start >= 3 && strings.Contains(lower[maxInt(0, start-6):start], "de ") {
			score += 40
		}
		if len(digits) >= 3 {
			score += 20
		}
		score += start / 8 // prefer later tokens on ties
		candidates = append(candidates, candidate{amount: parsed, score: score, start: start})
	}
	if len(candidates) == 0 {
		return 0, false
	}
	best := candidates[0]
	for _, c := range candidates[1:] {
		if c.score > best.score || (c.score == best.score && c.start > best.start) {
			best = c
		}
	}
	return best.amount, true
}

func onlyDigits(value string) string {
	var b strings.Builder
	for _, r := range value {
		if r >= '0' && r <= '9' {
			b.WriteRune(r)
		}
	}
	return b.String()
}

func extractCounterparty(text, kind string) string {
	lower := strings.ToLower(text)
	var marker string
	if kind == "income" {
		if idx := strings.Index(lower, "ingreso de "); idx >= 0 {
			marker = text[idx+11:]
		} else if idx := strings.LastIndex(lower, " de "); idx >= 0 {
			marker = text[idx+4:]
		} else if idx := strings.LastIndex(lower, " por "); idx >= 0 {
			marker = text[idx+5:]
		}
	} else {
		if idx := strings.Index(lower, " que registr"); strings.HasPrefix(lower, "el ") && idx > 3 {
			marker = text[3:idx]
		} else if idx := strings.Index(lower, "gasto de "); idx >= 0 {
			marker = text[idx+9:]
		} else if idx := strings.Index(lower, "gasto del "); idx >= 0 {
			marker = text[idx+10:]
		} else if idx := strings.LastIndex(lower, " en "); idx >= 0 {
			marker = text[idx+4:]
		} else if idx := strings.LastIndex(lower, " para "); idx >= 0 {
			marker = text[idx+6:]
		} else if idx := strings.LastIndex(lower, " de "); idx >= 0 {
			marker = text[idx+4:]
		}
	}

	marker = strings.TrimSpace(marker)
	marker = trimMerchantCandidate(marker)
	marker = trailingPunctuation.ReplaceAllString(marker, "")
	marker = strings.Trim(marker, "\"' ")
	if kind == "income" && containsAny(strings.ToLower(marker), "ingreso", "ingresos", "nomina", "nómina") {
		marker = "Ingreso manual"
	}
	if kind == "expense" && containsAny(strings.ToLower(marker), "gasto", "egreso") {
		marker = "Gasto manual"
	}
	if marker == "" {
		if kind == "income" {
			return "Ingreso manual"
		}
		return "Gasto manual"
	}
	return marker
}

func hasRegistrationCommand(lowerText string) bool {
	return containsAny(
		lowerText,
		"registra", "registrar", "agrega", "agregar", "anota", "anotar",
		"guarda", "guardar", "mete", "pon", "actualiza", "actualizalo", "actualízalo",
		"corrige", "corrígelo", "corrigelo", "registré", "registre",
	)
}

func isUpdateIntent(lowerText string) bool {
	return containsAny(
		lowerText,
		"actualiza", "actualíz", "corrige", "corríg", "modifica", "cambia",
		"en realidad", "ajusta", "ajúst",
	)
}

func shouldAttemptAutoRegistration(lowerText string) bool {
	if hasRegistrationCommand(lowerText) {
		return true
	}
	return containsAny(
		lowerText,
		"me gaste", "me gasté", "gaste", "gasté",
		"me pagaron", "recibi", "recibí", "me cayeron", "me cayó", "me cayo", "me calló", "me callo",
		"ingreso", "gasto", "que registr", "en realidad era de", "en realidad fue de",
	)
}

func adjacentToLetter(text string, start, end int) bool {
	if start > 0 {
		r, _ := utf8.DecodeLastRuneInString(text[:start])
		if unicode.IsLetter(r) {
			return true
		}
	}
	if end < len(text) {
		r, _ := utf8.DecodeRuneInString(text[end:])
		if unicode.IsLetter(r) {
			return true
		}
	}
	return false
}

func trimMerchantCandidate(value string) string {
	lower := strings.ToLower(value)
	cut := len(value)
	for _, needle := range []string{
		" fueron ", " fue ", " en realidad", " por ", " para ", " con ", ",", ".", ";",
		" actualiza", " actualíz", " corrige", " corríg",
	} {
		if idx := strings.Index(lower, needle); idx >= 0 && idx < cut {
			cut = idx
		}
	}
	return strings.TrimSpace(value[:cut])
}

func inferCategory(lowerText, kind, merchant string) string {
	if kind == "income" {
		return "income"
	}
	lowerMerchant := strings.ToLower(merchant)
	switch {
	case containsAny(lowerText, "taco", "comida", "restaurante", "cafe", "cafeter"), containsAny(lowerMerchant, "taco", "comida", "restaurante", "cafe", "cafeter"):
		return "food"
	case containsAny(lowerText, "uber", "didi", "gasolina", "transporte"), containsAny(lowerMerchant, "uber", "didi", "gasolina", "transporte"):
		return "transport"
	case containsAny(lowerText, "super", "mercado", "walmart", "soriana"), containsAny(lowerMerchant, "super", "mercado", "walmart", "soriana"):
		return "groceries"
	default:
		return "general"
	}
}

func shouldSkipRegistration(lowerText string) bool {
	return containsAny(
		lowerText,
		"no lo registres",
		"no registrar",
		"sin registrar",
		"no lo guardes",
		"no guardar",
	)
}

func shouldUndoRegistration(lowerText string) bool {
	if !containsAny(lowerText, "deshaz", "deshacer", "borra", "elimina", "cancela", "revert") {
		return false
	}
	if containsAny(lowerText, "ultimo", "último", "anterior", "reciente", "última", "ultima") {
		return true
	}
	return containsAny(
		lowerText,
		"deshaz eso",
		"deshazlo",
		"cancela eso",
		"revertir eso",
		"revertirlo",
	)
}

func containsAny(text string, terms ...string) bool {
	for _, term := range terms {
		if strings.Contains(text, term) {
			return true
		}
	}
	return false
}

func jsonObject(value map[string]any) string {
	out, err := json.Marshal(value)
	if err != nil {
		return "{}"
	}
	return string(out)
}

func extractAutoReply(toolContext string) string {
	const prefix = "AUTO_REPLY:"
	for _, line := range strings.Split(toolContext, "\n") {
		trimmed := strings.TrimSpace(line)
		if strings.HasPrefix(trimmed, prefix) {
			reply := strings.TrimSpace(strings.TrimPrefix(trimmed, prefix))
			if reply != "" {
				return reply
			}
		}
	}
	return ""
}

func formatRegistrationConfirmation(expense *financev1.Expense, kind string) string {
	if expense == nil || expense.GetAmount() == nil {
		if kind == "income" {
			return "Ingreso registrado."
		}
		return "Gasto registrado."
	}
	amount := expense.GetAmount().GetUnits()
	currency := firstNonEmpty(expense.GetAmount().GetCurrencyCode(), "MXN")
	title := firstNonEmpty(expense.GetDisplayTitle(), expense.GetMerchantName())
	if kind == "income" {
		return fmt.Sprintf("Ingreso registrado: %s por %d %s.", title, abs64(amount), currency)
	}
	return fmt.Sprintf("Gasto registrado: %s por %d %s.", title, abs64(amount), currency)
}

func abs64(value int64) int64 {
	if value < 0 {
		return -value
	}
	return value
}

func minInt(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func maxInt(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxInt32(a, b int32) int32 {
	if a > b {
		return a
	}
	return b
}

func maxInt64(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}

func choosePositive(candidate, fallback int64) int64 {
	if candidate > 0 {
		return candidate
	}
	return fallback
}

func looksLikeManualInstruction(text string) bool {
	lower := strings.ToLower(text)
	return containsAny(
		lower,
		"ve a ", "selecciona", "ingresa", "edita", "guarda",
		"hazlo", "manualmente", "paso", "1.", "2.",
	)
}

package agent

import (
	"context"
	"fmt"
	"log/slog"
	"strings"
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
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/authn"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/config"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/connectx"
)

type scoreProvider interface {
	GetScoreSummaryData(ctx context.Context, userID string) (*financev1.ScoreSummary, error)
	ListRecentExpenses(ctx context.Context, userID string, limit int32) ([]*financev1.Expense, error)
}

type receiptProvider interface {
	LookupDraft(ctx context.Context, userID, receiptID string) (*documentsv1.ReceiptDraft, error)
	LatestDraft(ctx context.Context, userID string) (*documentsv1.ReceiptDraft, error)
}

type Service struct {
	logger   *slog.Logger
	model    *genkit.Genkit
	cfg      config.Config
	finance  scoreProvider
	receipts receiptProvider
}

func NewService(ctx context.Context, cfg config.Config, logger *slog.Logger, finance scoreProvider, receipts receiptProvider) *Service {
	service := &Service{
		logger:   logger,
		cfg:      cfg,
		finance:  finance,
		receipts: receipts,
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

	if shouldFetchExpenses(lower) {
		toolCallID := uuid.NewString()
		if err := send(toolStart(threadID, runID, toolCallID, "list_recent_expenses")); err != nil {
			return "", err
		}
		if err := send(toolArgs(threadID, runID, toolCallID, `{"limit":5}`)); err != nil {
			return "", err
		}
		expenses, err := s.finance.ListRecentExpenses(ctx, userID, 5)
		if err != nil {
			return "", err
		}
		contextParts = append(contextParts, expenseContext(expenses))
		if err := send(toolEnd(threadID, runID, toolCallID)); err != nil {
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

func (s *Service) generateReply(ctx context.Context, request *agentv1.RunRequest, lastUserMessage, toolContext string) string {
	prompt := buildPrompt(request, lastUserMessage, toolContext)
	if s.model == nil {
		return fallbackReply(lastUserMessage, toolContext)
	}

	var reply strings.Builder
	for chunk, err := range genkit.GenerateStream(ctx, s.model, ai.WithPrompt(prompt)) {
		if err != nil {
			s.logger.Warn("agent generation failed, using fallback reply", "error", err)
			return fallbackReply(lastUserMessage, toolContext)
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
		return fallbackReply(lastUserMessage, toolContext)
	}

	return result
}

func buildPrompt(request *agentv1.RunRequest, lastUserMessage, toolContext string) string {
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

	return fmt.Sprintf(
		`Eres Peso, un asistente financiero para PrimerPeso.
Responde siempre en espanol claro y breve.
Tu alcance es solo finanzas personales, tickets, gastos, puntaje y navegacion dentro de la app.
No pidas ni expongas datos sensibles completos.

Contexto de herramientas:
%s

Conversacion:
%s

Ultimo mensaje del usuario:
%s`,
		toolContext,
		conversation.String(),
		lastUserMessage,
	)
}

func fallbackReply(lastUserMessage, toolContext string) string {
	switch {
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
	return strings.Contains(text, "gasto") || strings.Contains(text, "historial") || strings.Contains(text, "movimiento")
}

func shouldFetchReceipt(text string) bool {
	return strings.Contains(text, "ticket") || strings.Contains(text, "recibo") || strings.Contains(text, "voucher")
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

func expenseContext(expenses []*financev1.Expense) string {
	if len(expenses) == 0 {
		return "No hay gastos confirmados recientes."
	}

	parts := make([]string, 0, len(expenses))
	for _, expense := range expenses {
		parts = append(parts, fmt.Sprintf("%s: %d %s en %s", expense.GetMerchantName(), expense.GetAmount().GetUnits(), expense.GetAmount().GetCurrencyCode(), expense.GetCategory()))
	}
	return "Gastos recientes: " + strings.Join(parts, "; ")
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

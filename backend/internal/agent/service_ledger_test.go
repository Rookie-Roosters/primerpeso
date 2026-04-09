package agent

import (
	"context"
	"errors"
	"log/slog"
	"strings"
	"testing"
	"time"

	agentv1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/agent/v1"
	documentsv1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/documents/v1"
	financev1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/finance/v1"
)

type stubFinance struct {
	listErr        error
	movements      []*financev1.Expense
	listCalls      int
	registerCalls  int
	updateCalls    int
	deleteCalls    int
	undoCalls      int
	scoreSummary   *financev1.ScoreSummary
	registerResult *financev1.ConfirmExpenseResponse
	updateResult   *financev1.ConfirmExpenseResponse
	deleteResult   *financev1.Expense
}

func (s *stubFinance) GetScoreSummaryData(context.Context, string) (*financev1.ScoreSummary, error) {
	if s.scoreSummary != nil {
		return s.scoreSummary, nil
	}
	return &financev1.ScoreSummary{Score: 700}, nil
}

func (s *stubFinance) ListRecentExpenses(context.Context, string, int32) ([]*financev1.Expense, error) {
	s.listCalls++
	if s.listErr != nil {
		return nil, s.listErr
	}
	return s.movements, nil
}

func (s *stubFinance) RegisterManualMovement(context.Context, string, string, bool, string, string, string, int64, time.Time) (*financev1.ConfirmExpenseResponse, error) {
	s.registerCalls++
	if s.registerResult != nil {
		return s.registerResult, nil
	}
	return &financev1.ConfirmExpenseResponse{Expense: &financev1.Expense{Amount: &financev1.Money{CurrencyCode: "MXN", Units: 100}, DisplayTitle: "Gasto manual"}}, nil
}

func (s *stubFinance) UpdateManualMovement(context.Context, string, string, string, string, string, int64, time.Time, string) (*financev1.ConfirmExpenseResponse, error) {
	s.updateCalls++
	if s.updateResult != nil {
		return s.updateResult, nil
	}
	return nil, nil
}

func (s *stubFinance) DeleteMovement(context.Context, string, string, string, string) (*financev1.Expense, error) {
	s.deleteCalls++
	return s.deleteResult, nil
}

func (s *stubFinance) UndoLatestMovement(context.Context, string) (*financev1.Expense, error) {
	s.undoCalls++
	return nil, nil
}

type stubReceipts struct{}

func (stubReceipts) LookupDraft(context.Context, string, string) (*documentsv1.ReceiptDraft, error) {
	return nil, nil
}
func (stubReceipts) LatestDraft(context.Context, string) (*documentsv1.ReceiptDraft, error) {
	return nil, nil
}

func TestIsLedgerRelatedIncomeQuestion(t *testing.T) {
	if !isLedgerRelated("qué ingresos tengo") {
		t.Fatalf("expected income question to be ledger-related")
	}
}

func TestApplyToolsPrelistFailureBlocksMutation(t *testing.T) {
	finance := &stubFinance{listErr: errors.New("db unavailable")}
	svc := &Service{
		logger:       slog.Default(),
		finance:      finance,
		receipts:     stubReceipts{},
		systemPrompt: fallbackSystemPrompt,
	}

	request := &agentv1.RunRequest{}
	contextText, err := svc.applyTools(
		context.Background(),
		func(*agentv1.RunEvent) error { return nil },
		"user-1",
		"thread-1",
		"run-1",
		request,
		"Me depositaron 1500",
	)
	if err != nil {
		t.Fatalf("applyTools returned error: %v", err)
	}
	if finance.listCalls != 1 {
		t.Fatalf("expected exactly one pre-list call, got %d", finance.listCalls)
	}
	if finance.registerCalls != 0 {
		t.Fatalf("expected no register calls when pre-list fails, got %d", finance.registerCalls)
	}
	if !strings.Contains(contextText, "AUTO_REPLY:No pude consultar tu historial") {
		t.Fatalf("expected operational error auto reply, got %q", contextText)
	}
}

func TestHeuristicLedgerActionDelete(t *testing.T) {
	action := heuristicLedgerAction("Borra el gasto de Uber de ayer")
	if action.Action != "delete" {
		t.Fatalf("expected delete action, got %q", action.Action)
	}
	if action.Kind != "expense" {
		t.Fatalf("expected expense kind, got %q", action.Kind)
	}
	if action.TemporalRef != "yesterday" {
		t.Fatalf("expected yesterday temporal ref, got %q", action.TemporalRef)
	}
}

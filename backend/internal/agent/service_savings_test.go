package agent

import (
	"context"
	"log/slog"
	"strings"
	"testing"

	agentv1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/agent/v1"
	financev1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/finance/v1"
	savingsv1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/savings/v1"
)

type stubSavings struct {
	createApartadoCalls int
}

func (s *stubSavings) CreateApartadoForUser(context.Context, string, *savingsv1.CreateApartadoRequest) (*savingsv1.Apartado, error) {
	s.createApartadoCalls++
	id := "apartado-1"
	return &savingsv1.Apartado{
		Id:              id,
		Name:            "Viaje",
		CurrentAmount:   &financev1.Money{CurrencyCode: "MXN", Units: 0},
		TargetAmount:    &financev1.Money{CurrencyCode: "MXN", Units: 5000},
		FinancialGoalId: nil,
	}, nil
}

func (*stubSavings) GetApartadoForUser(context.Context, string, string) (*savingsv1.Apartado, error) {
	id := "apartado-1"
	return &savingsv1.Apartado{
		Id:            id,
		Name:          "Viaje",
		CurrentAmount: &financev1.Money{CurrencyCode: "MXN", Units: 0},
		TargetAmount:  &financev1.Money{CurrencyCode: "MXN", Units: 5000},
	}, nil
}

func (*stubSavings) ListApartadosForUser(context.Context, string, int32) ([]*savingsv1.Apartado, error) {
	id := "apartado-1"
	return []*savingsv1.Apartado{{Id: id, Name: "Viaje"}}, nil
}

func (*stubSavings) UpdateApartadoForUser(context.Context, string, *savingsv1.UpdateApartadoRequest) (*savingsv1.Apartado, error) {
	id := "apartado-1"
	return &savingsv1.Apartado{Id: id, Name: "Viaje"}, nil
}

func (*stubSavings) DeleteApartadoForUser(context.Context, string, string) (*savingsv1.Apartado, error) {
	id := "apartado-1"
	return &savingsv1.Apartado{Id: id, Name: "Viaje"}, nil
}

func (*stubSavings) CreateFinancialGoalForUser(context.Context, string, *savingsv1.CreateFinancialGoalRequest) (*savingsv1.FinancialGoal, error) {
	id := "goal-1"
	return &savingsv1.FinancialGoal{Id: id, Name: "Meta"}, nil
}

func (*stubSavings) GetFinancialGoalForUser(context.Context, string, string) (*savingsv1.FinancialGoal, error) {
	id := "goal-1"
	return &savingsv1.FinancialGoal{Id: id, Name: "Meta"}, nil
}

func (*stubSavings) ListFinancialGoalsForUser(context.Context, string, int32) ([]*savingsv1.FinancialGoal, error) {
	id := "goal-1"
	return []*savingsv1.FinancialGoal{{Id: id, Name: "Meta"}}, nil
}

func (*stubSavings) UpdateFinancialGoalForUser(context.Context, string, *savingsv1.UpdateFinancialGoalRequest) (*savingsv1.FinancialGoal, error) {
	id := "goal-1"
	return &savingsv1.FinancialGoal{Id: id, Name: "Meta"}, nil
}

func (*stubSavings) DeleteFinancialGoalForUser(context.Context, string, string) (*savingsv1.FinancialGoal, error) {
	id := "goal-1"
	return &savingsv1.FinancialGoal{Id: id, Name: "Meta"}, nil
}

func (*stubSavings) CreateRecurringPaymentReminderForUser(context.Context, string, *savingsv1.CreateRecurringPaymentReminderRequest) (*savingsv1.RecurringPaymentReminder, error) {
	id := "reminder-1"
	return &savingsv1.RecurringPaymentReminder{Id: id, Title: "Renta"}, nil
}

func (*stubSavings) GetRecurringPaymentReminderForUser(context.Context, string, string) (*savingsv1.RecurringPaymentReminder, error) {
	id := "reminder-1"
	return &savingsv1.RecurringPaymentReminder{Id: id, Title: "Renta"}, nil
}

func (*stubSavings) ListRecurringPaymentRemindersForUser(context.Context, string, int32) ([]*savingsv1.RecurringPaymentReminder, error) {
	id := "reminder-1"
	return []*savingsv1.RecurringPaymentReminder{{Id: id, Title: "Renta"}}, nil
}

func (*stubSavings) UpdateRecurringPaymentReminderForUser(context.Context, string, *savingsv1.UpdateRecurringPaymentReminderRequest) (*savingsv1.RecurringPaymentReminder, error) {
	id := "reminder-1"
	return &savingsv1.RecurringPaymentReminder{Id: id, Title: "Renta"}, nil
}

func (*stubSavings) DeleteRecurringPaymentReminderForUser(context.Context, string, string) (*savingsv1.RecurringPaymentReminder, error) {
	id := "reminder-1"
	return &savingsv1.RecurringPaymentReminder{Id: id, Title: "Renta"}, nil
}

func TestShouldHandleSavings(t *testing.T) {
	if !shouldHandleSavings("quiero crear un apartado") {
		t.Fatalf("expected apartado sentence to be savings-related")
	}
	if shouldHandleSavings("quiero registrar un gasto") {
		t.Fatalf("did not expect plain ledger sentence to be savings-related")
	}
}

func TestExecuteSavingsActionCreateApartado(t *testing.T) {
	savings := &stubSavings{}
	svc := &Service{
		logger:       slog.Default(),
		savings:      savings,
		systemPrompt: fallbackSystemPrompt,
	}

	var events []*agentv1.RunEvent
	send := func(event *agentv1.RunEvent) error {
		events = append(events, event)
		return nil
	}

	contextText, err := svc.executeSavingsAction(
		context.Background(),
		send,
		"user-1",
		"thread-1",
		"run-1",
		"crea un apartado \"viaje\" de 5000",
		strings.ToLower("crea un apartado \"viaje\" de 5000"),
	)
	if err != nil {
		t.Fatalf("executeSavingsAction returned error: %v", err)
	}
	if savings.createApartadoCalls != 1 {
		t.Fatalf("expected one create apartado call, got %d", savings.createApartadoCalls)
	}
	if !strings.Contains(contextText, "AUTO_REPLY:Apartado creado") {
		t.Fatalf("expected auto reply for created apartado, got %q", contextText)
	}

	var toolName string
	var hasSavingsDelta bool
	for _, event := range events {
		if start := event.GetToolCallStart(); start != nil {
			toolName = start.GetName()
		}
		if delta := event.GetStateDelta(); delta != nil && delta.GetDelta() != nil {
			if payload, ok := delta.GetDelta().AsMap()["savings"].(map[string]any); ok {
				hasSavingsDelta = payload["updated"] == true
			}
		}
	}
	if toolName != "create_apartado" {
		t.Fatalf("expected create_apartado tool name, got %q", toolName)
	}
	if !hasSavingsDelta {
		t.Fatalf("expected savings state delta")
	}
}

func TestResolveSavingsActionReminderFrequency(t *testing.T) {
	action := resolveSavingsAction("crea recordatorio semanal de renta", "crea recordatorio semanal de renta")
	if action.Entity != "recurring_payment_reminder" {
		t.Fatalf("expected recurring_payment_reminder entity, got %q", action.Entity)
	}
	if action.Frequency != savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_WEEKLY {
		t.Fatalf("expected weekly frequency, got %v", action.Frequency)
	}
}

func TestExecuteReminderToolCreateDefaults(t *testing.T) {
	savings := &stubSavings{}
	svc := &Service{logger: slog.Default(), savings: savings}

	action := savingsAction{
		Entity:    "recurring_payment_reminder",
		Action:    "create",
		Name:      "Renta",
		Frequency: savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_MONTHLY,
		Interval:  1,
	}

	_, reply, err := svc.executeReminderTool(context.Background(), "user-1", action)
	if err != nil {
		t.Fatalf("executeReminderTool returned error: %v", err)
	}
	if !strings.Contains(reply, "Recordatorio creado") {
		t.Fatalf("expected reminder created reply, got %q", reply)
	}
}

func TestExecuteSavingsActionIgnoresUnknown(t *testing.T) {
	svc := &Service{logger: slog.Default(), savings: &stubSavings{}}
	ctxText, err := svc.executeSavingsAction(context.Background(), func(*agentv1.RunEvent) error { return nil }, "user-1", "thread", "run", "hola", "hola")
	if err != nil {
		t.Fatalf("executeSavingsAction returned error: %v", err)
	}
	if ctxText != "" {
		t.Fatalf("expected empty context for unrelated message, got %q", ctxText)
	}
}

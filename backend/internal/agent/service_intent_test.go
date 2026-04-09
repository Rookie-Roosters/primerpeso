package agent

import "testing"

func TestParseManualRegistrationIntentExpense(t *testing.T) {
	intent, ok := parseManualRegistrationIntent("Me gasté 250 pesos en los tacos")
	if !ok {
		t.Fatalf("expected expense intent to be detected")
	}
	if intent.kind != "expense" {
		t.Fatalf("expected kind expense, got %q", intent.kind)
	}
	if intent.amountUnits != 250 {
		t.Fatalf("expected amount 250, got %d", intent.amountUnits)
	}
	if intent.merchantName != "los tacos" {
		t.Fatalf("expected merchant 'los tacos', got %q", intent.merchantName)
	}
}

func TestParseManualRegistrationIntentExpenseUpdateCommand(t *testing.T) {
	intent, ok := parseManualRegistrationIntent("El gasto de 7eleven fueron en realidad 250, actualizalo")
	if !ok {
		t.Fatalf("expected update expense intent to be detected")
	}
	if intent.kind != "expense" {
		t.Fatalf("expected kind expense, got %q", intent.kind)
	}
	if intent.amountUnits != 250 {
		t.Fatalf("expected amount 250, got %d", intent.amountUnits)
	}
	if intent.merchantName != "7eleven" {
		t.Fatalf("expected merchant '7eleven', got %q", intent.merchantName)
	}
}

func TestParseManualRegistrationIntentExpenseRegisteredYesterday(t *testing.T) {
	intent, ok := parseManualRegistrationIntent(
		"El 7 eleven que registré ayer en realidad era de 777",
	)
	if !ok {
		t.Fatalf("expected correction intent to be detected")
	}
	if intent.kind != "expense" {
		t.Fatalf("expected kind expense, got %q", intent.kind)
	}
	if intent.amountUnits != 777 {
		t.Fatalf("expected amount 777, got %d", intent.amountUnits)
	}
	if intent.merchantName != "7 eleven" {
		t.Fatalf("expected merchant '7 eleven', got %q", intent.merchantName)
	}
	if !intent.preferUpdate {
		t.Fatalf("expected correction to prefer update")
	}
}

func TestParseManualRegistrationIntentIncome(t *testing.T) {
	intent, ok := parseManualRegistrationIntent("Hoy me pagaron 1200 de freelance")
	if !ok {
		t.Fatalf("expected income intent to be detected")
	}
	if intent.kind != "income" {
		t.Fatalf("expected kind income, got %q", intent.kind)
	}
	if intent.amountUnits != 1200 {
		t.Fatalf("expected amount 1200, got %d", intent.amountUnits)
	}
	if intent.merchantName != "freelance" {
		t.Fatalf("expected merchant 'freelance', got %q", intent.merchantName)
	}
}

func TestParseManualRegistrationIntentIncomeCommand(t *testing.T) {
	intent, ok := parseManualRegistrationIntent("Registra 100000 de ingreso")
	if !ok {
		t.Fatalf("expected income command intent to be detected")
	}
	if intent.kind != "income" {
		t.Fatalf("expected kind income, got %q", intent.kind)
	}
	if intent.amountUnits != 100000 {
		t.Fatalf("expected amount 100000, got %d", intent.amountUnits)
	}
}

func TestParseManualRegistrationIntentIncomeMeCayeron(t *testing.T) {
	intent, ok := parseManualRegistrationIntent("Me cayeron 100000 pesos")
	if !ok {
		t.Fatalf("expected income intent for me cayeron")
	}
	if intent.kind != "income" {
		t.Fatalf("expected kind income, got %q", intent.kind)
	}
	if intent.amountUnits != 100000 {
		t.Fatalf("expected amount 100000, got %d", intent.amountUnits)
	}
}

func TestUndoDetection(t *testing.T) {
	if !shouldUndoRegistration("deshaz el ultimo registro") {
		t.Fatalf("expected undo to be detected")
	}
	if shouldUndoRegistration("quiero ver mi historial de gastos") {
		t.Fatalf("did not expect undo for plain history request")
	}
}

func TestSkipDetection(t *testing.T) {
	if !shouldSkipRegistration("no lo registres") {
		t.Fatalf("expected skip-registration to be detected")
	}
	if shouldSkipRegistration("registralo por favor") {
		t.Fatalf("did not expect skip-registration for positive register instruction")
	}
}

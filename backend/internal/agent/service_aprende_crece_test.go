package agent

import (
	"context"
	"log/slog"
	"strings"
	"testing"

	agentv1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/agent/v1"
)

func TestShouldFetchAprendeCreceForBudgetQuestion(t *testing.T) {
	if !shouldFetchAprendeCrece("¿Cómo hago un presupuesto familiar?") {
		t.Fatalf("expected educational budget question to trigger aprende y crece search")
	}
}

func TestShouldFetchAprendeCreceForCATQuestion(t *testing.T) {
	if !shouldFetchAprendeCrece("Quiero información sobre el CAT") {
		t.Fatalf("expected CAT question to trigger aprende y crece search")
	}
}

func TestShouldFetchAprendeCreceForGeneralFinanzasQuestion(t *testing.T) {
	if !shouldFetchAprendeCrece("Quiero información para mejorar mis finanzas") {
		t.Fatalf("expected general finance question to trigger aprende y crece search")
	}
}

func TestShouldFetchAprendeCreceSkipsLedgerCrud(t *testing.T) {
	if shouldFetchAprendeCrece("Registra gasto de 250 en tacos") {
		t.Fatalf("did not expect plain ledger CRUD instruction to trigger aprende y crece search")
	}
}

func TestApplyToolsSearchAprendeCreceInjectsContext(t *testing.T) {
	svc := &Service{
		logger:   slog.Default(),
		finance:  &stubFinance{},
		receipts: stubReceipts{},
		aprendeCrece: &aprendeCreceIndex{
			articles: []aprendeCreceArticle{
				{
					Title:    "Cómo hacer un presupuesto familiar",
					URL:      "https://www.bancoazteca.com.mx/edu-fin/presupuesto.html",
					Summary:  "Pasos prácticos para organizar tus gastos del mes.",
					Category: "presupuesto familiar",
					tokens: tokenizeAprendeCrece(
						"como hacer un presupuesto familiar pasos practicos para organizar tus gastos del mes",
					),
				},
			},
		},
	}

	request := &agentv1.RunRequest{}
	var events []*agentv1.RunEvent
	toolContext, err := svc.applyTools(
		context.Background(),
		func(event *agentv1.RunEvent) error {
			events = append(events, event)
			return nil
		},
		"user-1",
		"thread-1",
		"run-1",
		request,
		"¿Cómo hago un presupuesto familiar?",
	)
	if err != nil {
		t.Fatalf("applyTools returned error: %v", err)
	}

	if !strings.Contains(toolContext, "APRENDE_CRECE_CONTEXT:") {
		t.Fatalf("expected APRENDE_CRECE_CONTEXT block in tool context, got %q", toolContext)
	}
	if !strings.Contains(toolContext, "APRENDE_CRECE_SOURCES:") {
		t.Fatalf("expected APRENDE_CRECE_SOURCES block in tool context, got %q", toolContext)
	}
	if !strings.Contains(toolContext, "https://www.bancoazteca.com.mx/edu-fin/presupuesto.html") {
		t.Fatalf("expected context to include matched article URL, got %q", toolContext)
	}
	if !hasToolStart(events, "search_aprende_y_crece") {
		t.Fatalf("expected search_aprende_y_crece tool call start")
	}
}

func TestApplyToolsSearchAprendeCreceNoMatchKeepsContextClean(t *testing.T) {
	svc := &Service{
		logger:   slog.Default(),
		finance:  &stubFinance{},
		receipts: stubReceipts{},
		aprendeCrece: &aprendeCreceIndex{
			articles: []aprendeCreceArticle{
				{
					Title:    "Cómo hacer un presupuesto familiar",
					URL:      "https://www.bancoazteca.com.mx/edu-fin/presupuesto.html",
					Summary:  "Pasos prácticos para organizar tus gastos del mes.",
					Category: "presupuesto familiar",
					tokens:   tokenizeAprendeCrece("presupuesto familiar gastos mes organizar"),
				},
			},
		},
	}

	request := &agentv1.RunRequest{}
	var events []*agentv1.RunEvent
	toolContext, err := svc.applyTools(
		context.Background(),
		func(event *agentv1.RunEvent) error {
			events = append(events, event)
			return nil
		},
		"user-1",
		"thread-1",
		"run-1",
		request,
		"¿Cómo invertir mi dinero?",
	)
	if err != nil {
		t.Fatalf("applyTools returned error: %v", err)
	}
	if strings.Contains(toolContext, "APRENDE_CRECE_CONTEXT:") || strings.Contains(toolContext, "APRENDE_CRECE_SOURCES:") {
		t.Fatalf("did not expect aprende y crece blocks when there are no matches, got %q", toolContext)
	}
	if !hasToolStart(events, "search_aprende_y_crece") {
		t.Fatalf("expected search_aprende_y_crece tool call start even when there are no matches")
	}
}

func TestEnsureAprendeCreceSourceLinkAppendsSource(t *testing.T) {
	toolContext := strings.Join([]string{
		"APRENDE_CRECE_CONTEXT:",
		"- [Cómo hacer un presupuesto familiar](https://www.bancoazteca.com.mx/edu-fin/presupuesto.html) [presupuesto]: Pasos prácticos",
		"APRENDE_CRECE_SOURCES:",
		"- [Cómo hacer un presupuesto familiar](https://www.bancoazteca.com.mx/edu-fin/presupuesto.html)",
	}, "\n")

	reply := "Empieza separando gastos fijos, variables y un fondo de emergencia."
	out := ensureAprendeCreceSourceLink(reply, toolContext)

	if !strings.Contains(out, "Fuente: [Cómo hacer un presupuesto familiar](https://www.bancoazteca.com.mx/edu-fin/presupuesto.html)") {
		t.Fatalf("expected source link appended to reply, got %q", out)
	}
}

func TestEnsureAprendeCreceSourceLinkNoDuplicateWhenURLAlreadyPresent(t *testing.T) {
	toolContext := strings.Join([]string{
		"APRENDE_CRECE_CONTEXT:",
		"- [Cómo hacer un presupuesto familiar](https://www.bancoazteca.com.mx/edu-fin/presupuesto.html) [presupuesto]: Pasos prácticos",
		"APRENDE_CRECE_SOURCES:",
		"- [Cómo hacer un presupuesto familiar](https://www.bancoazteca.com.mx/edu-fin/presupuesto.html)",
	}, "\n")

	reply := "Te puede servir esta guía: [Cómo hacer un presupuesto familiar](https://www.bancoazteca.com.mx/edu-fin/presupuesto.html)"
	out := ensureAprendeCreceSourceLink(reply, toolContext)

	if out != strings.TrimSpace(reply) {
		t.Fatalf("expected reply unchanged when URL already present, got %q", out)
	}
}

func TestLooksLikeToolCallMarkup(t *testing.T) {
	raw := `<function_call name="search_aprende_y_crece">
<argument name="query">qué es el CAT</argument>
</function_call>`
	if !looksLikeToolCallMarkup(raw) {
		t.Fatalf("expected tool-call markup to be detected")
	}
	if looksLikeToolCallMarkup("El CAT es el costo anual total de un crédito.") {
		t.Fatalf("did not expect plain user-facing text to be detected as markup")
	}
}

func TestFallbackAprendeCreceReplyFromContext(t *testing.T) {
	toolContext := strings.Join([]string{
		"APRENDE_CRECE_CONTEXT:",
		"- [Qué es el CAT y para qué sirve](https://www.bancoazteca.com.mx/edu-fin/cat.html) [credito]: El CAT permite comparar el costo total de distintos créditos en porcentaje anual.",
		"APRENDE_CRECE_SOURCES:",
		"- [Qué es el CAT y para qué sirve](https://www.bancoazteca.com.mx/edu-fin/cat.html)",
	}, "\n")

	reply := fallbackAprendeCreceReply(toolContext)
	if !strings.Contains(reply, "CAT permite comparar el costo total") {
		t.Fatalf("expected fallback to use context summary, got %q", reply)
	}
	out := ensureAprendeCreceSourceLink(reply, toolContext)
	if !strings.Contains(out, "https://www.bancoazteca.com.mx/edu-fin/cat.html") {
		t.Fatalf("expected source URL in final output, got %q", out)
	}
}

func TestCompactPlainURLs(t *testing.T) {
	in := "Revisa esto: https://www.bancoazteca.com.mx/edu-fin/cat.html para comparar créditos."
	out := compactPlainURLs(in)
	if !strings.Contains(out, "[Fuente 1](https://www.bancoazteca.com.mx/edu-fin/cat.html)") {
		t.Fatalf("expected compact markdown link, got %q", out)
	}
	if strings.Contains(out, "https://www.bancoazteca.com.mx/edu-fin/cat.html para") {
		t.Fatalf("expected plain URL to be replaced, got %q", out)
	}
}

func TestStripLeadingToolArgsArtifacts(t *testing.T) {
	in := strings.Join([]string{
		`: "consejos para mejorar finanzas personales"}}`,
		"",
		"¡Aquí van tips clave para mejorar tus finanzas!",
	}, "\n")
	out := stripLeadingToolArgsArtifacts(in)
	if strings.Contains(out, `: "consejos para mejorar finanzas personales"}}`) {
		t.Fatalf("expected malformed tool args artifact to be removed, got %q", out)
	}
	if !strings.Contains(out, "¡Aquí van tips clave para mejorar tus finanzas!") {
		t.Fatalf("expected user-facing content to be preserved, got %q", out)
	}
}

func hasToolStart(events []*agentv1.RunEvent, toolName string) bool {
	for _, event := range events {
		if start := event.GetToolCallStart(); start != nil && start.GetName() == toolName {
			return true
		}
	}
	return false
}

package documents

import (
	"testing"

	documentsv1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/documents/v1"
	financev1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/finance/v1"
)

func TestExtractionDecisionFor_AutoRegister(t *testing.T) {
	normalized := normalizedReceipt{
		MerchantName:      "Cafe Centro",
		SuggestedCategory: "food",
		Total: &financev1.Money{
			CurrencyCode: "MXN",
			Units:        250,
		},
	}

	decision, missing, _, confidence := extractionDecisionFor(normalized)
	if decision != documentsv1.ExtractionDecision_EXTRACTION_DECISION_AUTO_REGISTER {
		t.Fatalf("expected auto-register decision, got %v", decision)
	}
	if len(missing) != 0 {
		t.Fatalf("expected no missing fields, got %v", missing)
	}
	if confidence <= 0.8 {
		t.Fatalf("expected high confidence, got %f", confidence)
	}
}

func TestExtractionDecisionFor_NeedsClarification(t *testing.T) {
	normalized := normalizedReceipt{
		MerchantName: "Comercio sin nombre",
		Total: &financev1.Money{
			CurrencyCode: "MXN",
			Units:        0,
		},
	}

	decision, missing, _, confidence := extractionDecisionFor(normalized)
	if decision != documentsv1.ExtractionDecision_EXTRACTION_DECISION_NEEDS_CLARIFICATION {
		t.Fatalf("expected clarification decision, got %v", decision)
	}
	if len(missing) < 2 {
		t.Fatalf("expected missing merchant and amount, got %v", missing)
	}
	if confidence >= 0.8 {
		t.Fatalf("expected lower confidence, got %f", confidence)
	}
}

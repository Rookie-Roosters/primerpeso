package finance

import (
	"testing"
	"time"
)

func TestNormalizeMovementName(t *testing.T) {
	got := normalizeMovementName(" 7-Eleven, S.A. de C.V. ")
	if got != "7 eleven s a de c v" {
		t.Fatalf("unexpected normalized value: %q", got)
	}
}

func TestMovementNameMatchScore(t *testing.T) {
	score := movementNameMatchScore(
		normalizeMovementName("7eleven"),
		normalizeMovementName("7-Eleven"),
		normalizeMovementName("Gasto en 7 Eleven"),
	)
	if score < 55 {
		t.Fatalf("expected strong score for equivalent merchant names, got %d", score)
	}
}

func TestIsGenericMovementName(t *testing.T) {
	if !isGenericMovementName("gasto manual") {
		t.Fatalf("expected generic movement name")
	}
	if isGenericMovementName("7 eleven") {
		t.Fatalf("did not expect merchant name as generic")
	}
}

func TestNormalizeTemporalReference(t *testing.T) {
	if got := normalizeTemporalReference("ayer"); got != "yesterday" {
		t.Fatalf("expected yesterday, got %q", got)
	}
	if got := normalizeTemporalReference("hoy"); got != "today" {
		t.Fatalf("expected today, got %q", got)
	}
	if got := normalizeTemporalReference("semana pasada"); got != "" {
		t.Fatalf("expected empty reference, got %q", got)
	}
}

func TestSameCalendarDay(t *testing.T) {
	a := time.Date(2026, 4, 9, 9, 0, 0, 0, time.Local)
	b := time.Date(2026, 4, 9, 23, 59, 0, 0, time.Local)
	if !sameCalendarDay(a, b) {
		t.Fatalf("expected same day")
	}

	c := time.Date(2026, 4, 10, 0, 0, 0, 0, time.Local)
	if sameCalendarDay(a, c) {
		t.Fatalf("expected different day")
	}
}

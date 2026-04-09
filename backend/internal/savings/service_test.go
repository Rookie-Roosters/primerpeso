package savings

import (
	"testing"
	"time"

	savingsv1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/savings/v1"
	"github.com/jackc/pgx/v5/pgtype"
)

func TestComputeNextDueAtDaily(t *testing.T) {
	now := time.Date(2026, 4, 9, 10, 0, 0, 0, time.UTC)
	next, err := computeNextDueAt(
		now,
		"America/Mexico_City",
		"09:00",
		"DAILY",
		1,
		pgtype.Int4{},
		pgtype.Int4{},
		pgtype.Int4{},
	)
	if err != nil {
		t.Fatalf("computeNextDueAt returned error: %v", err)
	}
	loc, _ := time.LoadLocation("America/Mexico_City")
	nextLocal := next.In(loc)
	if nextLocal.Hour() != 9 || nextLocal.Minute() != 0 {
		t.Fatalf("expected 09:00 local time, got %s", nextLocal)
	}
	if !next.After(now) {
		t.Fatalf("expected next due date to be after now")
	}
}

func TestComputeNextDueAtWeekly(t *testing.T) {
	now := time.Date(2026, 4, 6, 13, 0, 0, 0, time.UTC) // Monday
	dow := pgtype.Int4{Int32: int32(time.Tuesday), Valid: true}
	next, err := computeNextDueAt(
		now,
		"America/Mexico_City",
		"09:00",
		"WEEKLY",
		1,
		dow,
		pgtype.Int4{},
		pgtype.Int4{},
	)
	if err != nil {
		t.Fatalf("computeNextDueAt returned error: %v", err)
	}
	loc, _ := time.LoadLocation("America/Mexico_City")
	nextLocal := next.In(loc)
	if nextLocal.Weekday() != time.Tuesday {
		t.Fatalf("expected Tuesday, got %s", nextLocal.Weekday())
	}
}

func TestComputeNextDueAtMonthlyClampsDay(t *testing.T) {
	now := time.Date(2026, 4, 30, 20, 0, 0, 0, time.UTC)
	next, err := computeNextDueAt(
		now,
		"America/Mexico_City",
		"09:00",
		"MONTHLY",
		1,
		pgtype.Int4{},
		pgtype.Int4{Int32: 31, Valid: true},
		pgtype.Int4{},
	)
	if err != nil {
		t.Fatalf("computeNextDueAt returned error: %v", err)
	}
	loc, _ := time.LoadLocation("America/Mexico_City")
	nextLocal := next.In(loc)
	if nextLocal.Day() < 28 || nextLocal.Day() > 31 {
		t.Fatalf("expected clamped day between 28 and 31, got %d", nextLocal.Day())
	}
}

func TestValidateRecurrenceAnchors(t *testing.T) {
	err := validateRecurrenceAnchors("MONTHLY", pgtype.Int4{}, pgtype.Int4{Int32: 12, Valid: true}, pgtype.Int4{})
	if err != nil {
		t.Fatalf("expected monthly anchors to be valid: %v", err)
	}

	err = validateRecurrenceAnchors("MONTHLY", pgtype.Int4{Int32: 2, Valid: true}, pgtype.Int4{Int32: 12, Valid: true}, pgtype.Int4{})
	if err == nil {
		t.Fatalf("expected monthly anchors to reject day_of_week")
	}
}

func TestRecurrenceToDBRejectsUnspecified(t *testing.T) {
	_, err := recurrenceToDB(savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_UNSPECIFIED)
	if err == nil {
		t.Fatalf("expected error for unspecified recurrence")
	}
}

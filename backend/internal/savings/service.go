package savings

import (
	"context"
	"errors"
	"fmt"
	"log/slog"
	"regexp"
	"strings"
	"time"

	"connectrpc.com/connect"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgtype"
	"google.golang.org/protobuf/types/known/timestamppb"

	financev1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/finance/v1"
	savingsv1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/savings/v1"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/authn"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/connectx"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/savings/store"
)

var localTimePattern = regexp.MustCompile(`^(?:[01]\d|2[0-3]):[0-5]\d$`)

type Service struct {
	logger  *slog.Logger
	queries *store.Queries
}

func NewService(logger *slog.Logger, queries *store.Queries) *Service {
	return &Service{logger: logger, queries: queries}
}

func (s *Service) CreateApartado(ctx context.Context, req *connect.Request[savingsv1.CreateApartadoRequest]) (*connect.Response[savingsv1.CreateApartadoResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	apartado, err := s.CreateApartadoForUser(ctx, userID, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.CreateApartadoResponse{Apartado: apartado}), nil
}

func (s *Service) GetApartado(ctx context.Context, req *connect.Request[savingsv1.GetApartadoRequest]) (*connect.Response[savingsv1.GetApartadoResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	apartado, err := s.GetApartadoForUser(ctx, userID, req.Msg.GetApartadoId())
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.GetApartadoResponse{Apartado: apartado}), nil
}

func (s *Service) ListApartados(ctx context.Context, req *connect.Request[savingsv1.ListApartadosRequest]) (*connect.Response[savingsv1.ListApartadosResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	apartados, err := s.ListApartadosForUser(ctx, userID, req.Msg.GetPageSize())
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.ListApartadosResponse{Apartados: apartados}), nil
}

func (s *Service) UpdateApartado(ctx context.Context, req *connect.Request[savingsv1.UpdateApartadoRequest]) (*connect.Response[savingsv1.UpdateApartadoResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	apartado, err := s.UpdateApartadoForUser(ctx, userID, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.UpdateApartadoResponse{Apartado: apartado}), nil
}

func (s *Service) DeleteApartado(ctx context.Context, req *connect.Request[savingsv1.DeleteApartadoRequest]) (*connect.Response[savingsv1.DeleteApartadoResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	apartado, err := s.DeleteApartadoForUser(ctx, userID, req.Msg.GetApartadoId())
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.DeleteApartadoResponse{Apartado: apartado}), nil
}

func (s *Service) CreateFinancialGoal(ctx context.Context, req *connect.Request[savingsv1.CreateFinancialGoalRequest]) (*connect.Response[savingsv1.CreateFinancialGoalResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	goal, err := s.CreateFinancialGoalForUser(ctx, userID, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.CreateFinancialGoalResponse{FinancialGoal: goal}), nil
}

func (s *Service) GetFinancialGoal(ctx context.Context, req *connect.Request[savingsv1.GetFinancialGoalRequest]) (*connect.Response[savingsv1.GetFinancialGoalResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	goal, err := s.GetFinancialGoalForUser(ctx, userID, req.Msg.GetFinancialGoalId())
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.GetFinancialGoalResponse{FinancialGoal: goal}), nil
}

func (s *Service) ListFinancialGoals(ctx context.Context, req *connect.Request[savingsv1.ListFinancialGoalsRequest]) (*connect.Response[savingsv1.ListFinancialGoalsResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	goals, err := s.ListFinancialGoalsForUser(ctx, userID, req.Msg.GetPageSize())
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.ListFinancialGoalsResponse{FinancialGoals: goals}), nil
}

func (s *Service) UpdateFinancialGoal(ctx context.Context, req *connect.Request[savingsv1.UpdateFinancialGoalRequest]) (*connect.Response[savingsv1.UpdateFinancialGoalResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	goal, err := s.UpdateFinancialGoalForUser(ctx, userID, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.UpdateFinancialGoalResponse{FinancialGoal: goal}), nil
}

func (s *Service) DeleteFinancialGoal(ctx context.Context, req *connect.Request[savingsv1.DeleteFinancialGoalRequest]) (*connect.Response[savingsv1.DeleteFinancialGoalResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	goal, err := s.DeleteFinancialGoalForUser(ctx, userID, req.Msg.GetFinancialGoalId())
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.DeleteFinancialGoalResponse{FinancialGoal: goal}), nil
}

func (s *Service) CreateRecurringPaymentReminder(ctx context.Context, req *connect.Request[savingsv1.CreateRecurringPaymentReminderRequest]) (*connect.Response[savingsv1.CreateRecurringPaymentReminderResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	reminder, err := s.CreateRecurringPaymentReminderForUser(ctx, userID, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.CreateRecurringPaymentReminderResponse{RecurringPaymentReminder: reminder}), nil
}

func (s *Service) GetRecurringPaymentReminder(ctx context.Context, req *connect.Request[savingsv1.GetRecurringPaymentReminderRequest]) (*connect.Response[savingsv1.GetRecurringPaymentReminderResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	reminder, err := s.GetRecurringPaymentReminderForUser(ctx, userID, req.Msg.GetRecurringPaymentReminderId())
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.GetRecurringPaymentReminderResponse{RecurringPaymentReminder: reminder}), nil
}

func (s *Service) ListRecurringPaymentReminders(ctx context.Context, req *connect.Request[savingsv1.ListRecurringPaymentRemindersRequest]) (*connect.Response[savingsv1.ListRecurringPaymentRemindersResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	reminders, err := s.ListRecurringPaymentRemindersForUser(ctx, userID, req.Msg.GetPageSize())
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.ListRecurringPaymentRemindersResponse{RecurringPaymentReminders: reminders}), nil
}

func (s *Service) UpdateRecurringPaymentReminder(ctx context.Context, req *connect.Request[savingsv1.UpdateRecurringPaymentReminderRequest]) (*connect.Response[savingsv1.UpdateRecurringPaymentReminderResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	reminder, err := s.UpdateRecurringPaymentReminderForUser(ctx, userID, req.Msg)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.UpdateRecurringPaymentReminderResponse{RecurringPaymentReminder: reminder}), nil
}

func (s *Service) DeleteRecurringPaymentReminder(ctx context.Context, req *connect.Request[savingsv1.DeleteRecurringPaymentReminderRequest]) (*connect.Response[savingsv1.DeleteRecurringPaymentReminderResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	reminder, err := s.DeleteRecurringPaymentReminderForUser(ctx, userID, req.Msg.GetRecurringPaymentReminderId())
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&savingsv1.DeleteRecurringPaymentReminderResponse{RecurringPaymentReminder: reminder}), nil
}

func (s *Service) CreateApartadoForUser(ctx context.Context, userID string, req *savingsv1.CreateApartadoRequest) (*savingsv1.Apartado, error) {
	if strings.TrimSpace(userID) == "" {
		return nil, connectx.Unauthenticated("missing user id")
	}
	if req == nil {
		return nil, connectx.InvalidArgument("request is required")
	}

	name := strings.TrimSpace(req.GetName())
	if name == "" {
		return nil, connectx.InvalidArgument("apartado name is required")
	}
	currency, currentUnits, currentNanos, targetUnits, targetNanos, err := validateApartadoAmounts(req.GetCurrentAmount(), req.GetTargetAmount())
	if err != nil {
		return nil, err
	}

	goalID, err := s.resolveFinancialGoalLink(ctx, userID, req.FinancialGoalId, currency)
	if err != nil {
		return nil, err
	}

	row, err := s.queries.CreateApartado(ctx, store.CreateApartadoParams{
		UserID:          userID,
		FinancialGoalID: goalID,
		Name:            name,
		Description:     strings.TrimSpace(req.GetDescription()),
		CurrencyCode:    currency,
		CurrentUnits:    currentUnits,
		CurrentNanos:    currentNanos,
		TargetUnits:     targetUnits,
		TargetNanos:     targetNanos,
	})
	if err != nil {
		return nil, connectx.Internal("failed to create apartado")
	}
	return toApartadoProto(row), nil
}

func (s *Service) GetApartadoForUser(ctx context.Context, userID, apartadoID string) (*savingsv1.Apartado, error) {
	id, err := parseUUID(apartadoID, "apartado_id")
	if err != nil {
		return nil, err
	}
	row, err := s.queries.GetApartado(ctx, store.GetApartadoParams{UserID: userID, ID: id})
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, connectx.NotFound("apartado not found")
		}
		return nil, connectx.Internal("failed to get apartado")
	}
	return toApartadoProto(row), nil
}

func (s *Service) ListApartadosForUser(ctx context.Context, userID string, limit int32) ([]*savingsv1.Apartado, error) {
	rows, err := s.queries.ListApartados(ctx, store.ListApartadosParams{UserID: userID, Limit: normalizeLimit(limit)})
	if err != nil {
		return nil, connectx.Internal("failed to list apartados")
	}
	out := make([]*savingsv1.Apartado, 0, len(rows))
	for _, row := range rows {
		out = append(out, toApartadoProto(row))
	}
	return out, nil
}

func (s *Service) UpdateApartadoForUser(ctx context.Context, userID string, req *savingsv1.UpdateApartadoRequest) (*savingsv1.Apartado, error) {
	if req == nil {
		return nil, connectx.InvalidArgument("request is required")
	}
	id, err := parseUUID(req.GetApartadoId(), "apartado_id")
	if err != nil {
		return nil, err
	}
	name := strings.TrimSpace(req.GetName())
	if name == "" {
		return nil, connectx.InvalidArgument("apartado name is required")
	}
	currency, currentUnits, currentNanos, targetUnits, targetNanos, err := validateApartadoAmounts(req.GetCurrentAmount(), req.GetTargetAmount())
	if err != nil {
		return nil, err
	}

	goalID, err := s.resolveFinancialGoalLink(ctx, userID, req.FinancialGoalId, currency)
	if err != nil {
		return nil, err
	}

	row, err := s.queries.UpdateApartado(ctx, store.UpdateApartadoParams{
		UserID:          userID,
		ID:              id,
		FinancialGoalID: goalID,
		Name:            name,
		Description:     strings.TrimSpace(req.GetDescription()),
		CurrencyCode:    currency,
		CurrentUnits:    currentUnits,
		CurrentNanos:    currentNanos,
		TargetUnits:     targetUnits,
		TargetNanos:     targetNanos,
	})
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, connectx.NotFound("apartado not found")
		}
		return nil, connectx.Internal("failed to update apartado")
	}
	return toApartadoProto(row), nil
}

func (s *Service) DeleteApartadoForUser(ctx context.Context, userID, apartadoID string) (*savingsv1.Apartado, error) {
	id, err := parseUUID(apartadoID, "apartado_id")
	if err != nil {
		return nil, err
	}
	row, err := s.queries.DeleteApartado(ctx, store.DeleteApartadoParams{UserID: userID, ID: id})
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, connectx.NotFound("apartado not found")
		}
		return nil, connectx.Internal("failed to delete apartado")
	}
	return toApartadoProto(row), nil
}

func (s *Service) CreateFinancialGoalForUser(ctx context.Context, userID string, req *savingsv1.CreateFinancialGoalRequest) (*savingsv1.FinancialGoal, error) {
	if strings.TrimSpace(userID) == "" {
		return nil, connectx.Unauthenticated("missing user id")
	}
	if req == nil {
		return nil, connectx.InvalidArgument("request is required")
	}

	name := strings.TrimSpace(req.GetName())
	if name == "" {
		return nil, connectx.InvalidArgument("financial goal name is required")
	}
	currency, units, nanos, err := validatePositiveMoney(req.GetTargetAmount(), "target_amount")
	if err != nil {
		return nil, err
	}
	targetDate, err := timestampToPG(req.GetTargetDate(), "target_date")
	if err != nil {
		return nil, err
	}

	row, err := s.queries.CreateFinancialGoal(ctx, store.CreateFinancialGoalParams{
		UserID:             userID,
		Name:               name,
		Description:        strings.TrimSpace(req.GetDescription()),
		TargetCurrencyCode: currency,
		TargetUnits:        units,
		TargetNanos:        nanos,
		TargetDate:         targetDate,
	})
	if err != nil {
		return nil, connectx.Internal("failed to create financial goal")
	}
	progressByGoalID, err := s.listGoalProgressNanos(ctx, userID)
	if err != nil {
		return nil, err
	}
	return toFinancialGoalProto(row, progressByGoalID[row.ID.String()]), nil
}

func (s *Service) GetFinancialGoalForUser(ctx context.Context, userID, goalID string) (*savingsv1.FinancialGoal, error) {
	id, err := parseUUID(goalID, "financial_goal_id")
	if err != nil {
		return nil, err
	}
	row, err := s.queries.GetFinancialGoal(ctx, store.GetFinancialGoalParams{UserID: userID, ID: id})
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, connectx.NotFound("financial goal not found")
		}
		return nil, connectx.Internal("failed to get financial goal")
	}
	progressByGoalID, err := s.listGoalProgressNanos(ctx, userID)
	if err != nil {
		return nil, err
	}
	return toFinancialGoalProto(row, progressByGoalID[row.ID.String()]), nil
}

func (s *Service) ListFinancialGoalsForUser(ctx context.Context, userID string, limit int32) ([]*savingsv1.FinancialGoal, error) {
	rows, err := s.queries.ListFinancialGoals(ctx, store.ListFinancialGoalsParams{UserID: userID, Limit: normalizeLimit(limit)})
	if err != nil {
		return nil, connectx.Internal("failed to list financial goals")
	}
	progressByGoalID, err := s.listGoalProgressNanos(ctx, userID)
	if err != nil {
		return nil, err
	}
	out := make([]*savingsv1.FinancialGoal, 0, len(rows))
	for _, row := range rows {
		out = append(out, toFinancialGoalProto(row, progressByGoalID[row.ID.String()]))
	}
	return out, nil
}

func (s *Service) UpdateFinancialGoalForUser(ctx context.Context, userID string, req *savingsv1.UpdateFinancialGoalRequest) (*savingsv1.FinancialGoal, error) {
	if req == nil {
		return nil, connectx.InvalidArgument("request is required")
	}
	id, err := parseUUID(req.GetFinancialGoalId(), "financial_goal_id")
	if err != nil {
		return nil, err
	}
	name := strings.TrimSpace(req.GetName())
	if name == "" {
		return nil, connectx.InvalidArgument("financial goal name is required")
	}
	currency, units, nanos, err := validatePositiveMoney(req.GetTargetAmount(), "target_amount")
	if err != nil {
		return nil, err
	}
	targetDate, err := timestampToPG(req.GetTargetDate(), "target_date")
	if err != nil {
		return nil, err
	}

	row, err := s.queries.UpdateFinancialGoal(ctx, store.UpdateFinancialGoalParams{
		UserID:             userID,
		ID:                 id,
		Name:               name,
		Description:        strings.TrimSpace(req.GetDescription()),
		TargetCurrencyCode: currency,
		TargetUnits:        units,
		TargetNanos:        nanos,
		TargetDate:         targetDate,
	})
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, connectx.NotFound("financial goal not found")
		}
		return nil, connectx.Internal("failed to update financial goal")
	}
	progressByGoalID, err := s.listGoalProgressNanos(ctx, userID)
	if err != nil {
		return nil, err
	}
	return toFinancialGoalProto(row, progressByGoalID[row.ID.String()]), nil
}

func (s *Service) DeleteFinancialGoalForUser(ctx context.Context, userID, goalID string) (*savingsv1.FinancialGoal, error) {
	id, err := parseUUID(goalID, "financial_goal_id")
	if err != nil {
		return nil, err
	}
	row, err := s.queries.DeleteFinancialGoal(ctx, store.DeleteFinancialGoalParams{UserID: userID, ID: id})
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, connectx.NotFound("financial goal not found")
		}
		return nil, connectx.Internal("failed to delete financial goal")
	}
	if err := s.queries.ClearFinancialGoalLinks(ctx, store.ClearFinancialGoalLinksParams{
		UserID:          userID,
		FinancialGoalID: uuidToPG(id),
	}); err != nil {
		return nil, connectx.Internal("failed to detach apartados from deleted financial goal")
	}
	return toFinancialGoalProto(row, 0), nil
}

func (s *Service) CreateRecurringPaymentReminderForUser(ctx context.Context, userID string, req *savingsv1.CreateRecurringPaymentReminderRequest) (*savingsv1.RecurringPaymentReminder, error) {
	if strings.TrimSpace(userID) == "" {
		return nil, connectx.Unauthenticated("missing user id")
	}
	if req == nil {
		return nil, connectx.InvalidArgument("request is required")
	}
	payload, err := normalizeReminderRequest(
		req.GetTitle(),
		req.GetPayee(),
		req.GetAmount(),
		req.GetFrequency(),
		req.GetInterval(),
		req.DayOfWeek,
		req.DayOfMonth,
		req.MonthOfYear,
		req.GetLocalTime(),
		req.GetTimezone(),
		time.Now(),
	)
	if err != nil {
		return nil, err
	}

	row, err := s.queries.CreateRecurringPaymentReminder(ctx, store.CreateRecurringPaymentReminderParams{
		UserID:             userID,
		Title:              payload.title,
		Payee:              payload.payee,
		AmountCurrencyCode: payload.currency,
		AmountUnits:        payload.amountUnits,
		AmountNanos:        payload.amountNanos,
		Frequency:          payload.frequency,
		Interval:           payload.interval,
		DayOfWeek:          payload.dayOfWeek,
		DayOfMonth:         payload.dayOfMonth,
		MonthOfYear:        payload.monthOfYear,
		LocalTime:          payload.localTime,
		Timezone:           payload.timezone,
		NextDueAt:          pgtype.Timestamptz{Time: payload.nextDueAt, Valid: true},
	})
	if err != nil {
		return nil, connectx.Internal("failed to create recurring payment reminder")
	}
	return toReminderProto(row), nil
}

func (s *Service) GetRecurringPaymentReminderForUser(ctx context.Context, userID, reminderID string) (*savingsv1.RecurringPaymentReminder, error) {
	id, err := parseUUID(reminderID, "recurring_payment_reminder_id")
	if err != nil {
		return nil, err
	}
	row, err := s.queries.GetRecurringPaymentReminder(ctx, store.GetRecurringPaymentReminderParams{UserID: userID, ID: id})
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, connectx.NotFound("recurring payment reminder not found")
		}
		return nil, connectx.Internal("failed to get recurring payment reminder")
	}
	return toReminderProto(row), nil
}

func (s *Service) ListRecurringPaymentRemindersForUser(ctx context.Context, userID string, limit int32) ([]*savingsv1.RecurringPaymentReminder, error) {
	rows, err := s.queries.ListRecurringPaymentReminders(ctx, store.ListRecurringPaymentRemindersParams{UserID: userID, Limit: normalizeLimit(limit)})
	if err != nil {
		return nil, connectx.Internal("failed to list recurring payment reminders")
	}
	out := make([]*savingsv1.RecurringPaymentReminder, 0, len(rows))
	for _, row := range rows {
		out = append(out, toReminderProto(row))
	}
	return out, nil
}

func (s *Service) UpdateRecurringPaymentReminderForUser(ctx context.Context, userID string, req *savingsv1.UpdateRecurringPaymentReminderRequest) (*savingsv1.RecurringPaymentReminder, error) {
	if req == nil {
		return nil, connectx.InvalidArgument("request is required")
	}
	id, err := parseUUID(req.GetRecurringPaymentReminderId(), "recurring_payment_reminder_id")
	if err != nil {
		return nil, err
	}
	payload, err := normalizeReminderRequest(
		req.GetTitle(),
		req.GetPayee(),
		req.GetAmount(),
		req.GetFrequency(),
		req.GetInterval(),
		req.DayOfWeek,
		req.DayOfMonth,
		req.MonthOfYear,
		req.GetLocalTime(),
		req.GetTimezone(),
		time.Now(),
	)
	if err != nil {
		return nil, err
	}

	row, err := s.queries.UpdateRecurringPaymentReminder(ctx, store.UpdateRecurringPaymentReminderParams{
		UserID:             userID,
		ID:                 id,
		Title:              payload.title,
		Payee:              payload.payee,
		AmountCurrencyCode: payload.currency,
		AmountUnits:        payload.amountUnits,
		AmountNanos:        payload.amountNanos,
		Frequency:          payload.frequency,
		Interval:           payload.interval,
		DayOfWeek:          payload.dayOfWeek,
		DayOfMonth:         payload.dayOfMonth,
		MonthOfYear:        payload.monthOfYear,
		LocalTime:          payload.localTime,
		Timezone:           payload.timezone,
		NextDueAt:          pgtype.Timestamptz{Time: payload.nextDueAt, Valid: true},
	})
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, connectx.NotFound("recurring payment reminder not found")
		}
		return nil, connectx.Internal("failed to update recurring payment reminder")
	}
	return toReminderProto(row), nil
}

func (s *Service) DeleteRecurringPaymentReminderForUser(ctx context.Context, userID, reminderID string) (*savingsv1.RecurringPaymentReminder, error) {
	id, err := parseUUID(reminderID, "recurring_payment_reminder_id")
	if err != nil {
		return nil, err
	}
	row, err := s.queries.DeleteRecurringPaymentReminder(ctx, store.DeleteRecurringPaymentReminderParams{UserID: userID, ID: id})
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, connectx.NotFound("recurring payment reminder not found")
		}
		return nil, connectx.Internal("failed to delete recurring payment reminder")
	}
	return toReminderProto(row), nil
}

func (s *Service) resolveFinancialGoalLink(ctx context.Context, userID string, financialGoalID *string, currencyCode string) (pgtype.UUID, error) {
	if financialGoalID == nil {
		return pgtype.UUID{}, nil
	}
	trimmed := strings.TrimSpace(*financialGoalID)
	if trimmed == "" {
		return pgtype.UUID{}, nil
	}
	id, err := uuid.Parse(trimmed)
	if err != nil {
		return pgtype.UUID{}, connectx.InvalidArgument("financial_goal_id must be a valid UUID")
	}
	goal, err := s.queries.GetFinancialGoal(ctx, store.GetFinancialGoalParams{UserID: userID, ID: id})
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return pgtype.UUID{}, connectx.NotFound("financial goal not found")
		}
		return pgtype.UUID{}, connectx.Internal("failed to validate financial goal")
	}
	if !strings.EqualFold(goal.TargetCurrencyCode, currencyCode) {
		return pgtype.UUID{}, connectx.InvalidArgument("apartado currency must match linked financial goal currency")
	}
	return uuidToPG(id), nil
}

func (s *Service) listGoalProgressNanos(ctx context.Context, userID string) (map[string]int64, error) {
	rows, err := s.queries.ListFinancialGoalCurrentAmounts(ctx, userID)
	if err != nil {
		return nil, connectx.Internal("failed to compute financial goal progress")
	}
	out := make(map[string]int64, len(rows))
	for _, row := range rows {
		if !row.FinancialGoalID.Valid {
			continue
		}
		goalID := uuid.UUID(row.FinancialGoalID.Bytes).String()
		out[goalID] = row.TotalNanos
	}
	return out, nil
}

func toApartadoProto(row store.Apartado) *savingsv1.Apartado {
	message := &savingsv1.Apartado{
		Id:          row.ID.String(),
		Name:        row.Name,
		Description: row.Description,
		CurrentAmount: &financev1.Money{
			CurrencyCode: row.CurrencyCode,
			Units:        row.CurrentUnits,
			Nanos:        row.CurrentNanos,
		},
		TargetAmount: &financev1.Money{
			CurrencyCode: row.CurrencyCode,
			Units:        row.TargetUnits,
			Nanos:        row.TargetNanos,
		},
		IsActive:  !row.DeletedAt.Valid,
		CreatedAt: timestamppb.New(row.CreatedAt.Time),
		UpdatedAt: timestamppb.New(row.UpdatedAt.Time),
	}
	if row.FinancialGoalID.Valid {
		goalID := uuid.UUID(row.FinancialGoalID.Bytes).String()
		message.FinancialGoalId = &goalID
	}
	return message
}

func toFinancialGoalProto(row store.FinancialGoal, currentTotalNanos int64) *savingsv1.FinancialGoal {
	units, nanos := splitNanos(currentTotalNanos)
	message := &savingsv1.FinancialGoal{
		Id:          row.ID.String(),
		Name:        row.Name,
		Description: row.Description,
		TargetAmount: &financev1.Money{
			CurrencyCode: row.TargetCurrencyCode,
			Units:        row.TargetUnits,
			Nanos:        row.TargetNanos,
		},
		CurrentAmount: &financev1.Money{
			CurrencyCode: row.TargetCurrencyCode,
			Units:        units,
			Nanos:        nanos,
		},
		IsActive:  !row.DeletedAt.Valid,
		CreatedAt: timestamppb.New(row.CreatedAt.Time),
		UpdatedAt: timestamppb.New(row.UpdatedAt.Time),
	}
	if row.TargetDate.Valid {
		message.TargetDate = timestamppb.New(row.TargetDate.Time)
	}
	return message
}

func toReminderProto(row store.RecurringPaymentReminder) *savingsv1.RecurringPaymentReminder {
	message := &savingsv1.RecurringPaymentReminder{
		Id:    row.ID.String(),
		Title: row.Title,
		Payee: row.Payee,
		Amount: &financev1.Money{
			CurrencyCode: row.AmountCurrencyCode,
			Units:        row.AmountUnits,
			Nanos:        row.AmountNanos,
		},
		Frequency: recurrenceFromDB(row.Frequency),
		Interval:  row.Interval,
		LocalTime: row.LocalTime,
		Timezone:  row.Timezone,
		NextDueAt: timestamppb.New(row.NextDueAt.Time),
		IsActive:  !row.DeletedAt.Valid,
		CreatedAt: timestamppb.New(row.CreatedAt.Time),
		UpdatedAt: timestamppb.New(row.UpdatedAt.Time),
	}
	if row.DayOfWeek.Valid {
		value := row.DayOfWeek.Int32
		message.DayOfWeek = &value
	}
	if row.DayOfMonth.Valid {
		value := row.DayOfMonth.Int32
		message.DayOfMonth = &value
	}
	if row.MonthOfYear.Valid {
		value := row.MonthOfYear.Int32
		message.MonthOfYear = &value
	}
	return message
}

func parseUUID(value string, field string) (uuid.UUID, error) {
	trimmed := strings.TrimSpace(value)
	if trimmed == "" {
		return uuid.Nil, connectx.InvalidArgument(field + " is required")
	}
	id, err := uuid.Parse(trimmed)
	if err != nil {
		return uuid.Nil, connectx.InvalidArgument(field + " must be a valid UUID")
	}
	return id, nil
}

func validateApartadoAmounts(current, target *financev1.Money) (currency string, currentUnits int64, currentNanos int32, targetUnits int64, targetNanos int32, err error) {
	currencyCurrent, unitsCurrent, nanosCurrent, err := validateNonNegativeMoney(current, "current_amount")
	if err != nil {
		return "", 0, 0, 0, 0, err
	}
	currencyTarget, unitsTarget, nanosTarget, err := validatePositiveMoney(target, "target_amount")
	if err != nil {
		return "", 0, 0, 0, 0, err
	}
	currency = firstNonEmpty(currencyTarget, currencyCurrent, "MXN")
	if currencyCurrent != "" && !strings.EqualFold(currencyCurrent, currency) {
		return "", 0, 0, 0, 0, connectx.InvalidArgument("current_amount currency must match target_amount currency")
	}
	if currencyTarget != "" && !strings.EqualFold(currencyTarget, currency) {
		return "", 0, 0, 0, 0, connectx.InvalidArgument("target_amount currency must match current_amount currency")
	}
	return strings.ToUpper(currency), unitsCurrent, nanosCurrent, unitsTarget, nanosTarget, nil
}

func validatePositiveMoney(money *financev1.Money, field string) (currency string, units int64, nanos int32, err error) {
	if money == nil {
		return "", 0, 0, connectx.InvalidArgument(field + " is required")
	}
	units = money.GetUnits()
	nanos = money.GetNanos()
	if nanos < 0 || nanos >= 1_000_000_000 {
		return "", 0, 0, connectx.InvalidArgument(field + " nanos must be between 0 and 999999999")
	}
	if units <= 0 {
		return "", 0, 0, connectx.InvalidArgument(field + " units must be greater than 0")
	}
	currency = strings.ToUpper(strings.TrimSpace(money.GetCurrencyCode()))
	if currency == "" {
		currency = "MXN"
	}
	return currency, units, nanos, nil
}

func validateNonNegativeMoney(money *financev1.Money, field string) (currency string, units int64, nanos int32, err error) {
	if money == nil {
		return "", 0, 0, connectx.InvalidArgument(field + " is required")
	}
	units = money.GetUnits()
	nanos = money.GetNanos()
	if nanos < 0 || nanos >= 1_000_000_000 {
		return "", 0, 0, connectx.InvalidArgument(field + " nanos must be between 0 and 999999999")
	}
	if units < 0 {
		return "", 0, 0, connectx.InvalidArgument(field + " units must be greater than or equal to 0")
	}
	currency = strings.ToUpper(strings.TrimSpace(money.GetCurrencyCode()))
	if currency == "" {
		currency = "MXN"
	}
	return currency, units, nanos, nil
}

func timestampToPG(ts *timestamppb.Timestamp, field string) (pgtype.Timestamptz, error) {
	if ts == nil {
		return pgtype.Timestamptz{}, nil
	}
	if err := ts.CheckValid(); err != nil {
		return pgtype.Timestamptz{}, connectx.InvalidArgument(fmt.Sprintf("%s is invalid", field))
	}
	return pgtype.Timestamptz{Time: ts.AsTime(), Valid: true}, nil
}

type normalizedReminderPayload struct {
	title       string
	payee       string
	currency    string
	amountUnits int64
	amountNanos int32
	frequency   string
	interval    int32
	dayOfWeek   pgtype.Int4
	dayOfMonth  pgtype.Int4
	monthOfYear pgtype.Int4
	localTime   string
	timezone    string
	nextDueAt   time.Time
}

func normalizeReminderRequest(
	title string,
	payee string,
	amount *financev1.Money,
	frequency savingsv1.RecurrenceFrequency,
	interval int32,
	dayOfWeek *int32,
	dayOfMonth *int32,
	monthOfYear *int32,
	localTime string,
	timezone string,
	now time.Time,
) (*normalizedReminderPayload, error) {
	resolvedTitle := strings.TrimSpace(title)
	if resolvedTitle == "" {
		return nil, connectx.InvalidArgument("title is required")
	}
	currency, amountUnits, amountNanos, err := validatePositiveMoney(amount, "amount")
	if err != nil {
		return nil, err
	}

	recurrence, err := recurrenceToDB(frequency)
	if err != nil {
		return nil, err
	}
	if interval <= 0 {
		interval = 1
	}
	resolvedTime := strings.TrimSpace(localTime)
	if resolvedTime == "" {
		resolvedTime = "09:00"
	}
	if !localTimePattern.MatchString(resolvedTime) {
		return nil, connectx.InvalidArgument("local_time must use HH:MM format")
	}
	resolvedTimezone := strings.TrimSpace(timezone)
	if resolvedTimezone == "" {
		resolvedTimezone = "America/Mexico_City"
	}
	if _, err := time.LoadLocation(resolvedTimezone); err != nil {
		return nil, connectx.InvalidArgument("timezone is invalid")
	}

	dayWeekPG := int4FromOptional(dayOfWeek)
	dayMonthPG := int4FromOptional(dayOfMonth)
	monthYearPG := int4FromOptional(monthOfYear)

	if err := validateRecurrenceAnchors(recurrence, dayWeekPG, dayMonthPG, monthYearPG); err != nil {
		return nil, err
	}

	nextDue, err := computeNextDueAt(now, resolvedTimezone, resolvedTime, recurrence, interval, dayWeekPG, dayMonthPG, monthYearPG)
	if err != nil {
		return nil, err
	}

	return &normalizedReminderPayload{
		title:       resolvedTitle,
		payee:       strings.TrimSpace(payee),
		currency:    currency,
		amountUnits: amountUnits,
		amountNanos: amountNanos,
		frequency:   recurrence,
		interval:    interval,
		dayOfWeek:   dayWeekPG,
		dayOfMonth:  dayMonthPG,
		monthOfYear: monthYearPG,
		localTime:   resolvedTime,
		timezone:    resolvedTimezone,
		nextDueAt:   nextDue,
	}, nil
}

func validateRecurrenceAnchors(freq string, dayOfWeek, dayOfMonth, monthOfYear pgtype.Int4) error {
	switch freq {
	case "DAILY":
		if dayOfWeek.Valid || dayOfMonth.Valid || monthOfYear.Valid {
			return connectx.InvalidArgument("daily recurrence does not allow day anchors")
		}
	case "WEEKLY":
		if !dayOfWeek.Valid || dayOfMonth.Valid || monthOfYear.Valid {
			return connectx.InvalidArgument("weekly recurrence requires only day_of_week")
		}
	case "MONTHLY":
		if dayOfWeek.Valid || !dayOfMonth.Valid || monthOfYear.Valid {
			return connectx.InvalidArgument("monthly recurrence requires only day_of_month")
		}
	case "YEARLY":
		if dayOfWeek.Valid || !dayOfMonth.Valid || !monthOfYear.Valid {
			return connectx.InvalidArgument("yearly recurrence requires day_of_month and month_of_year")
		}
	default:
		return connectx.InvalidArgument("frequency is invalid")
	}
	return nil
}

func computeNextDueAt(
	now time.Time,
	timezone string,
	localTime string,
	frequency string,
	interval int32,
	dayOfWeek pgtype.Int4,
	dayOfMonth pgtype.Int4,
	monthOfYear pgtype.Int4,
) (time.Time, error) {
	location, err := time.LoadLocation(timezone)
	if err != nil {
		return time.Time{}, connectx.InvalidArgument("timezone is invalid")
	}
	clockParts := strings.Split(localTime, ":")
	if len(clockParts) != 2 {
		return time.Time{}, connectx.InvalidArgument("local_time must use HH:MM format")
	}
	hour := parseClockPart(clockParts[0])
	minute := parseClockPart(clockParts[1])
	if hour < 0 || minute < 0 {
		return time.Time{}, connectx.InvalidArgument("local_time must use HH:MM format")
	}

	nowLocal := now.In(location)
	candidate := time.Date(nowLocal.Year(), nowLocal.Month(), nowLocal.Day(), hour, minute, 0, 0, location)

	switch frequency {
	case "DAILY":
		for !candidate.After(nowLocal) {
			candidate = candidate.AddDate(0, 0, int(interval))
		}
	case "WEEKLY":
		targetWeekday := time.Weekday(dayOfWeek.Int32)
		delta := int(targetWeekday - nowLocal.Weekday())
		if delta < 0 {
			delta += 7
		}
		candidate = time.Date(nowLocal.Year(), nowLocal.Month(), nowLocal.Day(), hour, minute, 0, 0, location).AddDate(0, 0, delta)
		for !candidate.After(nowLocal) {
			candidate = candidate.AddDate(0, 0, int(7*interval))
		}
	case "MONTHLY":
		candidate = alignedMonthlyTime(nowLocal.Year(), nowLocal.Month(), int(dayOfMonth.Int32), hour, minute, location)
		for !candidate.After(nowLocal) {
			next := candidate.AddDate(0, int(interval), 0)
			candidate = alignedMonthlyTime(next.Year(), next.Month(), int(dayOfMonth.Int32), hour, minute, location)
		}
	case "YEARLY":
		candidate = alignedMonthlyTime(nowLocal.Year(), time.Month(monthOfYear.Int32), int(dayOfMonth.Int32), hour, minute, location)
		for !candidate.After(nowLocal) {
			nextYear := candidate.Year() + int(interval)
			candidate = alignedMonthlyTime(nextYear, time.Month(monthOfYear.Int32), int(dayOfMonth.Int32), hour, minute, location)
		}
	default:
		return time.Time{}, connectx.InvalidArgument("frequency is invalid")
	}
	return candidate.UTC(), nil
}

func alignedMonthlyTime(year int, month time.Month, desiredDay int, hour int, minute int, location *time.Location) time.Time {
	lastDay := daysInMonth(year, month)
	day := desiredDay
	if day > lastDay {
		day = lastDay
	}
	if day < 1 {
		day = 1
	}
	return time.Date(year, month, day, hour, minute, 0, 0, location)
}

func daysInMonth(year int, month time.Month) int {
	if month == time.December {
		return 31
	}
	firstOfNext := time.Date(year, month+1, 1, 0, 0, 0, 0, time.UTC)
	return firstOfNext.AddDate(0, 0, -1).Day()
}

func parseClockPart(value string) int {
	if len(value) != 2 {
		return -1
	}
	if value[0] < '0' || value[0] > '9' || value[1] < '0' || value[1] > '9' {
		return -1
	}
	return int((value[0]-'0')*10 + (value[1] - '0'))
}

func recurrenceToDB(f savingsv1.RecurrenceFrequency) (string, error) {
	switch f {
	case savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_DAILY:
		return "DAILY", nil
	case savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_WEEKLY:
		return "WEEKLY", nil
	case savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_MONTHLY:
		return "MONTHLY", nil
	case savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_YEARLY:
		return "YEARLY", nil
	default:
		return "", connectx.InvalidArgument("frequency is required")
	}
}

func recurrenceFromDB(value string) savingsv1.RecurrenceFrequency {
	switch strings.ToUpper(strings.TrimSpace(value)) {
	case "DAILY":
		return savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_DAILY
	case "WEEKLY":
		return savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_WEEKLY
	case "MONTHLY":
		return savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_MONTHLY
	case "YEARLY":
		return savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_YEARLY
	default:
		return savingsv1.RecurrenceFrequency_RECURRENCE_FREQUENCY_UNSPECIFIED
	}
}

func int4FromOptional(value *int32) pgtype.Int4 {
	if value == nil {
		return pgtype.Int4{}
	}
	return pgtype.Int4{Int32: *value, Valid: true}
}

func uuidToPG(id uuid.UUID) pgtype.UUID {
	return pgtype.UUID{Bytes: id, Valid: true}
}

func splitNanos(totalNanos int64) (int64, int32) {
	if totalNanos <= 0 {
		return 0, 0
	}
	units := totalNanos / 1_000_000_000
	nanos := totalNanos % 1_000_000_000
	return units, int32(nanos)
}

func normalizeLimit(limit int32) int32 {
	if limit <= 0 {
		return 50
	}
	if limit > 200 {
		return 200
	}
	return limit
}

func firstNonEmpty(values ...string) string {
	for _, value := range values {
		trimmed := strings.TrimSpace(value)
		if trimmed != "" {
			return trimmed
		}
	}
	return ""
}

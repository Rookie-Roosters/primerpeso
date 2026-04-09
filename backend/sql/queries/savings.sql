-- name: CreateApartado :one
INSERT INTO apartados (
    user_id,
    financial_goal_id,
    name,
    description,
    currency_code,
    current_units,
    current_nanos,
    target_units,
    target_nanos
) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
RETURNING *;

-- name: GetApartado :one
SELECT *
FROM apartados
WHERE user_id = $1
  AND id = $2
  AND deleted_at IS NULL;

-- name: ListApartados :many
SELECT *
FROM apartados
WHERE user_id = $1
  AND deleted_at IS NULL
ORDER BY created_at DESC
LIMIT $2;

-- name: UpdateApartado :one
UPDATE apartados
SET
    financial_goal_id = $3,
    name = $4,
    description = $5,
    currency_code = $6,
    current_units = $7,
    current_nanos = $8,
    target_units = $9,
    target_nanos = $10,
    updated_at = NOW()
WHERE user_id = $1
  AND id = $2
  AND deleted_at IS NULL
RETURNING *;

-- name: DeleteApartado :one
UPDATE apartados
SET
    deleted_at = NOW(),
    updated_at = NOW()
WHERE user_id = $1
  AND id = $2
  AND deleted_at IS NULL
RETURNING *;

-- name: CreateFinancialGoal :one
INSERT INTO financial_goals (
    user_id,
    name,
    description,
    target_currency_code,
    target_units,
    target_nanos,
    target_date
) VALUES ($1, $2, $3, $4, $5, $6, $7)
RETURNING *;

-- name: GetFinancialGoal :one
SELECT *
FROM financial_goals
WHERE user_id = $1
  AND id = $2
  AND deleted_at IS NULL;

-- name: ListFinancialGoals :many
SELECT *
FROM financial_goals
WHERE user_id = $1
  AND deleted_at IS NULL
ORDER BY created_at DESC
LIMIT $2;

-- name: UpdateFinancialGoal :one
UPDATE financial_goals
SET
    name = $3,
    description = $4,
    target_currency_code = $5,
    target_units = $6,
    target_nanos = $7,
    target_date = $8,
    updated_at = NOW()
WHERE user_id = $1
  AND id = $2
  AND deleted_at IS NULL
RETURNING *;

-- name: DeleteFinancialGoal :one
UPDATE financial_goals
SET
    deleted_at = NOW(),
    updated_at = NOW()
WHERE user_id = $1
  AND id = $2
  AND deleted_at IS NULL
RETURNING *;

-- name: ClearFinancialGoalLinks :exec
UPDATE apartados
SET
    financial_goal_id = NULL,
    updated_at = NOW()
WHERE user_id = $1
  AND financial_goal_id = $2
  AND deleted_at IS NULL;

-- name: ListFinancialGoalCurrentAmounts :many
SELECT
    financial_goal_id,
    COALESCE(SUM(current_units * 1000000000::bigint + current_nanos::bigint), 0)::bigint AS total_nanos
FROM apartados
WHERE user_id = $1
  AND deleted_at IS NULL
  AND financial_goal_id IS NOT NULL
GROUP BY financial_goal_id;

-- name: CreateRecurringPaymentReminder :one
INSERT INTO recurring_payment_reminders (
    user_id,
    title,
    payee,
    amount_currency_code,
    amount_units,
    amount_nanos,
    frequency,
    interval,
    day_of_week,
    day_of_month,
    month_of_year,
    local_time,
    timezone,
    next_due_at
) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)
RETURNING *;

-- name: GetRecurringPaymentReminder :one
SELECT *
FROM recurring_payment_reminders
WHERE user_id = $1
  AND id = $2
  AND deleted_at IS NULL;

-- name: ListRecurringPaymentReminders :many
SELECT *
FROM recurring_payment_reminders
WHERE user_id = $1
  AND deleted_at IS NULL
ORDER BY created_at DESC
LIMIT $2;

-- name: UpdateRecurringPaymentReminder :one
UPDATE recurring_payment_reminders
SET
    title = $3,
    payee = $4,
    amount_currency_code = $5,
    amount_units = $6,
    amount_nanos = $7,
    frequency = $8,
    interval = $9,
    day_of_week = $10,
    day_of_month = $11,
    month_of_year = $12,
    local_time = $13,
    timezone = $14,
    next_due_at = $15,
    updated_at = NOW()
WHERE user_id = $1
  AND id = $2
  AND deleted_at IS NULL
RETURNING *;

-- name: DeleteRecurringPaymentReminder :one
UPDATE recurring_payment_reminders
SET
    deleted_at = NOW(),
    updated_at = NOW()
WHERE user_id = $1
  AND id = $2
  AND deleted_at IS NULL
RETURNING *;

-- name: CreateExpense :one
INSERT INTO expenses (
    user_id,
    receipt_id,
    encrypted_merchant_name,
    merchant_hash,
    encrypted_display_title,
    category,
    currency_code,
    amount_units,
    amount_nanos,
    occurred_at
) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
RETURNING *;

-- name: ListExpenses :many
SELECT *
FROM expenses
WHERE user_id = $1
ORDER BY created_at DESC
LIMIT $2;

-- name: CountExpenses :one
SELECT COUNT(*)::bigint
FROM expenses
WHERE user_id = $1;

-- name: CountCategoryCoverage :one
SELECT COUNT(DISTINCT category)::bigint
FROM expenses
WHERE user_id = $1;

-- name: SumLatestMonthExpenseUnits :one
SELECT COALESCE(SUM(amount_units), 0)::bigint
FROM expenses
WHERE user_id = $1
  AND occurred_at >= NOW() - INTERVAL '30 days';

-- name: SumTopCategoryExpenseUnits :one
SELECT COALESCE(MAX(category_total), 0)::bigint
FROM (
    SELECT SUM(amount_units)::bigint AS category_total
    FROM expenses
    WHERE user_id = $1
      AND occurred_at >= NOW() - INTERVAL '30 days'
    GROUP BY category
) ranked;

-- name: CreateScoreSnapshot :one
INSERT INTO score_snapshots (user_id, score, factors)
VALUES ($1, $2, $3)
RETURNING *;

-- name: GetLatestScoreSnapshot :one
SELECT *
FROM score_snapshots
WHERE user_id = $1
ORDER BY created_at DESC
LIMIT 1;

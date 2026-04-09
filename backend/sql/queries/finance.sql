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
ON CONFLICT (user_id, receipt_id) WHERE receipt_id IS NOT NULL
DO UPDATE SET
    encrypted_merchant_name = EXCLUDED.encrypted_merchant_name,
    merchant_hash = EXCLUDED.merchant_hash,
    encrypted_display_title = EXCLUDED.encrypted_display_title,
    category = EXCLUDED.category,
    currency_code = EXCLUDED.currency_code,
    amount_units = EXCLUDED.amount_units,
    amount_nanos = EXCLUDED.amount_nanos,
    occurred_at = EXCLUDED.occurred_at
RETURNING *;

-- name: ListExpenses :many
SELECT *
FROM expenses
WHERE user_id = $1
ORDER BY created_at DESC
LIMIT $2;

-- name: UpdateLatestExpenseByMerchant :one
UPDATE expenses AS e
SET
    encrypted_merchant_name = $3,
    merchant_hash = $2,
    encrypted_display_title = $4,
    category = $5,
    currency_code = $6,
    amount_units = $7,
    amount_nanos = $8,
    occurred_at = $9
WHERE e.id = (
    SELECT e2.id
    FROM expenses AS e2
    WHERE e2.user_id = $1
      AND e2.merchant_hash = $2
    ORDER BY e2.created_at DESC
    LIMIT 1
)
RETURNING e.*;

-- name: UpdateExpenseByID :one
UPDATE expenses AS e
SET
    encrypted_merchant_name = $3,
    merchant_hash = $4,
    encrypted_display_title = $5,
    category = $6,
    currency_code = $7,
    amount_units = $8,
    amount_nanos = $9,
    occurred_at = $10
WHERE e.id = $1
  AND e.user_id = $2
RETURNING e.*;

-- name: DeleteLatestExpense :one
DELETE FROM expenses AS e
WHERE e.id = (
    SELECT e2.id
    FROM expenses AS e2
    WHERE e2.user_id = $1
    ORDER BY e2.created_at DESC
    LIMIT 1
)
RETURNING e.*;

-- name: DeleteExpenseByID :one
DELETE FROM expenses AS e
WHERE e.user_id = $1
  AND e.id = $2
RETURNING e.*;

-- name: CountExpenses :one
SELECT COUNT(*)::bigint
FROM expenses
WHERE user_id = $1
  AND amount_units > 0;

-- name: CountCategoryCoverage :one
SELECT COUNT(DISTINCT category)::bigint
FROM expenses
WHERE user_id = $1
  AND amount_units > 0;

-- name: SumLatestMonthExpenseUnits :one
SELECT COALESCE(SUM(amount_units), 0)::bigint
FROM expenses
WHERE user_id = $1
  AND amount_units > 0
  AND occurred_at >= NOW() - INTERVAL '30 days';

-- name: SumTopCategoryExpenseUnits :one
SELECT COALESCE(MAX(category_total), 0)::bigint
FROM (
    SELECT SUM(amount_units)::bigint AS category_total
    FROM expenses
    WHERE user_id = $1
      AND amount_units > 0
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

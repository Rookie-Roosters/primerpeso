-- name: CreateMobileOAuthExchange :one
INSERT INTO mobile_oauth_exchanges (
    code,
    user_id,
    encrypted_payload,
    expires_at
) VALUES ($1, $2, $3, $4)
RETURNING *;

-- name: ConsumeMobileOAuthExchange :one
UPDATE mobile_oauth_exchanges
SET consumed_at = NOW()
WHERE code = $1
  AND consumed_at IS NULL
  AND expires_at > NOW()
RETURNING *;

-- name: DeleteExpiredMobileOAuthExchanges :exec
DELETE FROM mobile_oauth_exchanges
WHERE expires_at <= NOW();

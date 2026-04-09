-- name: CreateReceiptUpload :one
INSERT INTO receipt_uploads (
    user_id,
    object_key,
    filename,
    mime_type,
    encrypted_data_key,
    key_nonce,
    content_sha256
) VALUES ($1, $2, $3, $4, $5, $6, $7)
RETURNING *;

-- name: UpsertReceiptExtraction :one
INSERT INTO receipt_extractions (
    receipt_id,
    status,
    encrypted_merchant_name,
    merchant_hash,
    encrypted_redacted_text,
    document_fingerprint,
    suggested_category,
    purchased_at,
    total_currency,
    total_units,
    total_nanos,
    line_items
) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)
ON CONFLICT (receipt_id) DO UPDATE
SET
    status = EXCLUDED.status,
    encrypted_merchant_name = EXCLUDED.encrypted_merchant_name,
    merchant_hash = EXCLUDED.merchant_hash,
    encrypted_redacted_text = EXCLUDED.encrypted_redacted_text,
    document_fingerprint = EXCLUDED.document_fingerprint,
    suggested_category = EXCLUDED.suggested_category,
    purchased_at = EXCLUDED.purchased_at,
    total_currency = EXCLUDED.total_currency,
    total_units = EXCLUDED.total_units,
    total_nanos = EXCLUDED.total_nanos,
    line_items = EXCLUDED.line_items,
    updated_at = NOW()
RETURNING *;

-- name: GetReceiptDraft :one
SELECT
    sqlc.embed(receipt_uploads),
    sqlc.embed(receipt_extractions)
FROM receipt_uploads
JOIN receipt_extractions ON receipt_extractions.receipt_id = receipt_uploads.id
WHERE receipt_uploads.user_id = $1
  AND receipt_uploads.id = $2;

-- name: ListReceiptDrafts :many
SELECT
    sqlc.embed(receipt_uploads),
    sqlc.embed(receipt_extractions)
FROM receipt_uploads
JOIN receipt_extractions ON receipt_extractions.receipt_id = receipt_uploads.id
WHERE receipt_uploads.user_id = $1
ORDER BY receipt_uploads.created_at DESC
LIMIT $2;

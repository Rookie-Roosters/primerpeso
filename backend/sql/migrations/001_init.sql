CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE receipt_uploads (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL,
    object_key TEXT NOT NULL UNIQUE,
    filename TEXT NOT NULL,
    mime_type TEXT NOT NULL,
    encrypted_data_key BYTEA NOT NULL,
    key_nonce BYTEA NOT NULL,
    content_sha256 TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX receipt_uploads_user_created_idx
    ON receipt_uploads (user_id, created_at DESC);

CREATE TABLE receipt_extractions (
    receipt_id UUID PRIMARY KEY REFERENCES receipt_uploads(id) ON DELETE CASCADE,
    status TEXT NOT NULL,
    encrypted_merchant_name BYTEA NOT NULL,
    merchant_hash TEXT NOT NULL,
    encrypted_redacted_text BYTEA NOT NULL,
    document_fingerprint TEXT NOT NULL,
    suggested_category TEXT NOT NULL DEFAULT '',
    purchased_at TIMESTAMPTZ,
    total_currency TEXT NOT NULL DEFAULT 'MXN',
    total_units BIGINT NOT NULL DEFAULT 0,
    total_nanos INTEGER NOT NULL DEFAULT 0,
    line_items JSONB NOT NULL DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX receipt_extractions_merchant_hash_idx
    ON receipt_extractions (merchant_hash);

CREATE INDEX receipt_extractions_fingerprint_idx
    ON receipt_extractions (document_fingerprint);

CREATE TABLE expenses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL,
    receipt_id UUID REFERENCES receipt_uploads(id) ON DELETE SET NULL,
    encrypted_merchant_name BYTEA NOT NULL,
    merchant_hash TEXT NOT NULL,
    encrypted_display_title BYTEA NOT NULL,
    category TEXT NOT NULL,
    currency_code TEXT NOT NULL DEFAULT 'MXN',
    amount_units BIGINT NOT NULL,
    amount_nanos INTEGER NOT NULL DEFAULT 0,
    occurred_at TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX expenses_user_created_idx
    ON expenses (user_id, created_at DESC);

CREATE TABLE score_snapshots (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL,
    score INTEGER NOT NULL,
    factors JSONB NOT NULL DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX score_snapshots_user_created_idx
    ON score_snapshots (user_id, created_at DESC);

CREATE TABLE mobile_oauth_exchanges (
    code TEXT PRIMARY KEY,
    user_id TEXT NOT NULL,
    encrypted_payload BYTEA NOT NULL,
    expires_at TIMESTAMPTZ NOT NULL,
    consumed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX mobile_oauth_exchanges_expires_idx
    ON mobile_oauth_exchanges (expires_at);

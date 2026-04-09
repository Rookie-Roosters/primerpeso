CREATE TABLE financial_goals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT NOT NULL DEFAULT '',
    target_currency_code TEXT NOT NULL DEFAULT 'MXN',
    target_units BIGINT NOT NULL,
    target_nanos INTEGER NOT NULL DEFAULT 0,
    target_date TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    CHECK (target_units > 0),
    CHECK (target_nanos >= 0 AND target_nanos < 1000000000)
);

CREATE INDEX financial_goals_user_created_idx
    ON financial_goals (user_id, created_at DESC);

CREATE INDEX financial_goals_user_active_idx
    ON financial_goals (user_id, updated_at DESC)
    WHERE deleted_at IS NULL;

CREATE TABLE apartados (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL,
    financial_goal_id UUID REFERENCES financial_goals(id) ON DELETE SET NULL,
    name TEXT NOT NULL,
    description TEXT NOT NULL DEFAULT '',
    currency_code TEXT NOT NULL DEFAULT 'MXN',
    current_units BIGINT NOT NULL DEFAULT 0,
    current_nanos INTEGER NOT NULL DEFAULT 0,
    target_units BIGINT NOT NULL,
    target_nanos INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    CHECK (current_units >= 0),
    CHECK (target_units > 0),
    CHECK (current_nanos >= 0 AND current_nanos < 1000000000),
    CHECK (target_nanos >= 0 AND target_nanos < 1000000000)
);

CREATE INDEX apartados_user_created_idx
    ON apartados (user_id, created_at DESC);

CREATE INDEX apartados_user_goal_idx
    ON apartados (user_id, financial_goal_id)
    WHERE deleted_at IS NULL;

CREATE INDEX apartados_user_active_idx
    ON apartados (user_id, updated_at DESC)
    WHERE deleted_at IS NULL;

CREATE TABLE recurring_payment_reminders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL,
    title TEXT NOT NULL,
    payee TEXT NOT NULL DEFAULT '',
    amount_currency_code TEXT NOT NULL DEFAULT 'MXN',
    amount_units BIGINT NOT NULL,
    amount_nanos INTEGER NOT NULL DEFAULT 0,
    frequency TEXT NOT NULL,
    interval INTEGER NOT NULL DEFAULT 1,
    day_of_week INTEGER,
    day_of_month INTEGER,
    month_of_year INTEGER,
    local_time TEXT NOT NULL,
    timezone TEXT NOT NULL DEFAULT 'America/Mexico_City',
    next_due_at TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    CHECK (amount_units > 0),
    CHECK (amount_nanos >= 0 AND amount_nanos < 1000000000),
    CHECK (interval > 0),
    CHECK (frequency IN ('DAILY', 'WEEKLY', 'MONTHLY', 'YEARLY')),
    CHECK (local_time ~ '^(?:[01]\\d|2[0-3]):[0-5]\\d$'),
    CHECK (day_of_week IS NULL OR (day_of_week >= 0 AND day_of_week <= 6)),
    CHECK (day_of_month IS NULL OR (day_of_month >= 1 AND day_of_month <= 31)),
    CHECK (month_of_year IS NULL OR (month_of_year >= 1 AND month_of_year <= 12)),
    CHECK (
        (frequency = 'DAILY' AND day_of_week IS NULL AND day_of_month IS NULL AND month_of_year IS NULL) OR
        (frequency = 'WEEKLY' AND day_of_week IS NOT NULL AND day_of_month IS NULL AND month_of_year IS NULL) OR
        (frequency = 'MONTHLY' AND day_of_week IS NULL AND day_of_month IS NOT NULL AND month_of_year IS NULL) OR
        (frequency = 'YEARLY' AND day_of_week IS NULL AND day_of_month IS NOT NULL AND month_of_year IS NOT NULL)
    )
);

CREATE INDEX recurring_payment_reminders_user_created_idx
    ON recurring_payment_reminders (user_id, created_at DESC);

CREATE INDEX recurring_payment_reminders_user_active_idx
    ON recurring_payment_reminders (user_id, next_due_at ASC)
    WHERE deleted_at IS NULL;

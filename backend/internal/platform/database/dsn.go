package database

import (
	"context"
	"fmt"
	"net/url"
	"regexp"
	"strings"

	"github.com/jackc/pgx/v5/pgxpool"
)

var safeSchemaName = regexp.MustCompile(`^[a-z][a-z0-9_]{0,62}$`)

// WithSearchPath appends libpq options so every client (pgx, Authula, etc.) uses the schema first.
// Use for PostgreSQL 15+ / managed DBs where CREATE on schema public is revoked for the app role.
func WithSearchPath(databaseURL, schema string) (string, error) {
	schema = strings.TrimSpace(schema)
	if schema == "" {
		return databaseURL, nil
	}
	if !safeSchemaName.MatchString(schema) {
		return "", fmt.Errorf("invalid DATABASE_SCHEMA %q (use lowercase letters, digits, underscore)", schema)
	}
	u, err := url.Parse(databaseURL)
	if err != nil {
		return "", fmt.Errorf("parse database url: %w", err)
	}
	q := u.Query()
	opt := fmt.Sprintf("-csearch_path=%s,public", schema)
	if prev := q.Get("options"); prev != "" {
		q.Set("options", prev+" "+opt)
	} else {
		q.Set("options", opt)
	}
	u.RawQuery = q.Encode()
	return u.String(), nil
}

// EnsureSchema creates a dedicated schema if missing (requires CREATE on the database).
func EnsureSchema(ctx context.Context, databaseURL, schema string) error {
	schema = strings.TrimSpace(schema)
	if schema == "" {
		return nil
	}
	if !safeSchemaName.MatchString(schema) {
		return fmt.Errorf("invalid DATABASE_SCHEMA %q", schema)
	}
	cfg, err := pgxpool.ParseConfig(databaseURL)
	if err != nil {
		return fmt.Errorf("parse database url: %w", err)
	}
	cfg.MaxConns = 1
	pool, err := pgxpool.NewWithConfig(ctx, cfg)
	if err != nil {
		return fmt.Errorf("open db for ensure schema: %w", err)
	}
	defer pool.Close()

	_, err = pool.Exec(ctx, fmt.Sprintf(
		`CREATE SCHEMA IF NOT EXISTS %s`, quoteIdent(schema)))
	if err != nil {
		return fmt.Errorf(`create schema %s: %w (if permission denied, run as DB admin: GRANT CREATE ON DATABASE "<db>" TO "<app_user>"; see scripts/digitalocean/grant-public-fallback.sql)`, schema, err)
	}
	return nil
}

func quoteIdent(ident string) string {
	return `"` + strings.ReplaceAll(ident, `"`, `""`) + `"`
}

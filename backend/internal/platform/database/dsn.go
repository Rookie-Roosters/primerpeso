package database

import (
	"fmt"
	"net/url"
	"regexp"
	"strings"
)

var safeSchemaName = regexp.MustCompile(`^[a-z][a-z0-9_]{0,62}$`)

// WithSearchPath appends libpq options so every client (pgx, Authula, etc.) uses the schema first.
// The schema must already exist (run migrations / CREATE SCHEMA as a DB admin). Not used for DO App Platform dev DBs.
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

func quoteIdent(ident string) string {
	return `"` + strings.ReplaceAll(ident, `"`, `""`) + `"`
}

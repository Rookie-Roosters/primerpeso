package database

import (
	"context"
	"errors"
	"fmt"
	"os"
	"path/filepath"
	"sort"
	"strings"

	"github.com/jackc/pgx/v5/pgxpool"
)

func Open(ctx context.Context, databaseURL string) (*pgxpool.Pool, error) {
	cfg, err := pgxpool.ParseConfig(databaseURL)
	if err != nil {
		return nil, fmt.Errorf("parse database url: %w", err)
	}

	pool, err := pgxpool.NewWithConfig(ctx, cfg)
	if err != nil {
		return nil, fmt.Errorf("open database pool: %w", err)
	}

	if err := pool.Ping(ctx); err != nil {
		pool.Close()
		return nil, fmt.Errorf("ping database: %w", err)
	}

	return pool, nil
}

func RunMigrations(ctx context.Context, pool *pgxpool.Pool) error {
	appRoot, err := locateAppRoot()
	if err != nil {
		return err
	}

	migrationsDir := filepath.Join(appRoot, "sql", "migrations")
	entries, err := os.ReadDir(migrationsDir)
	if err != nil {
		return fmt.Errorf("read migrations dir: %w", err)
	}

	if _, err := pool.Exec(ctx, `
		CREATE TABLE IF NOT EXISTS app_schema_migrations (
			version TEXT PRIMARY KEY,
			applied_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
		)
	`); err != nil {
		return fmt.Errorf("ensure migration table: %w", err)
	}

	rows, err := pool.Query(ctx, `SELECT version FROM app_schema_migrations`)
	if err != nil {
		return fmt.Errorf("read applied migrations: %w", err)
	}
	defer rows.Close()

	applied := map[string]struct{}{}
	for rows.Next() {
		var version string
		if err := rows.Scan(&version); err != nil {
			return fmt.Errorf("scan migration version: %w", err)
		}
		applied[version] = struct{}{}
	}
	if err := rows.Err(); err != nil {
		return fmt.Errorf("iterate applied migrations: %w", err)
	}

	var files []string
	for _, entry := range entries {
		if entry.IsDir() || !strings.HasSuffix(entry.Name(), ".sql") {
			continue
		}
		files = append(files, entry.Name())
	}
	sort.Strings(files)

	for _, file := range files {
		if _, ok := applied[file]; ok {
			continue
		}

		content, err := os.ReadFile(filepath.Join(migrationsDir, file))
		if err != nil {
			return fmt.Errorf("read migration %s: %w", file, err)
		}

		tx, err := pool.Begin(ctx)
		if err != nil {
			return fmt.Errorf("begin migration tx %s: %w", file, err)
		}

		if _, err := tx.Exec(ctx, string(content)); err != nil {
			_ = tx.Rollback(ctx)
			return fmt.Errorf("apply migration %s: %w", file, err)
		}

		if _, err := tx.Exec(ctx, `INSERT INTO app_schema_migrations (version) VALUES ($1)`, file); err != nil {
			_ = tx.Rollback(ctx)
			return fmt.Errorf("record migration %s: %w", file, err)
		}

		if err := tx.Commit(ctx); err != nil {
			return fmt.Errorf("commit migration %s: %w", file, err)
		}
	}

	return nil
}

func locateAppRoot() (string, error) {
	wd, err := os.Getwd()
	if err != nil {
		return "", fmt.Errorf("get working dir: %w", err)
	}

	candidates := []string{wd}
	current := wd
	for range 6 {
		parent := filepath.Dir(current)
		if parent == current {
			break
		}
		candidates = append(candidates, parent)
		current = parent
	}

	for _, candidate := range candidates {
		if stat, err := os.Stat(filepath.Join(candidate, "sql", "migrations")); err == nil && stat.IsDir() {
			return candidate, nil
		}
		if stat, err := os.Stat(filepath.Join(candidate, "backend", "sql", "migrations")); err == nil && stat.IsDir() {
			return filepath.Join(candidate, "backend"), nil
		}
	}

	return "", errors.New("could not locate app root containing sql/migrations")
}

package main

import (
	"context"
	"errors"
	"log/slog"
	"net/http"
	"os"
	"os/signal"
	"strings"
	"syscall"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/joho/godotenv"

	agentv1connect "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/agent/v1/agentv1connect"
	documentsv1connect "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/documents/v1/documentsv1connect"
	financev1connect "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/finance/v1/financev1connect"
	identityv1connect "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/identity/v1/identityv1connect"
	savingsv1connect "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/savings/v1/savingsv1connect"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/agent"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/documents"
	documentsstore "github.com/Rookie-Roosters/primerpeso/backend/internal/documents/store"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/finance"
	financestore "github.com/Rookie-Roosters/primerpeso/backend/internal/finance/store"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/identity"
	identitystore "github.com/Rookie-Roosters/primerpeso/backend/internal/identity/store"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/blob"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/config"
	cryptox "github.com/Rookie-Roosters/primerpeso/backend/internal/platform/crypto"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/database"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/httpx"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/savings"
	savingsstore "github.com/Rookie-Roosters/primerpeso/backend/internal/savings/store"
)

func main() {
	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
	defer stop()

	// Load .env when present (gitignored). Try cwd, then backend/ when running from repo root.
	_ = godotenv.Load(".env")
	_ = godotenv.Load("backend/.env")

	cfg, err := config.Load()
	if err != nil {
		panic(err)
	}

	logger := slog.New(slog.NewTextHandler(os.Stdout, &slog.HandlerOptions{}))

	// Optional dedicated schema (e.g. self-hosted Postgres, or DO App Platform dev DB when the
	// role cannot CREATE in public). RunMigrations creates the schema if missing.
	if strings.TrimSpace(cfg.DatabaseSchema) != "" {
		u, err := database.WithSearchPath(cfg.DatabaseURL, cfg.DatabaseSchema)
		if err != nil {
			logger.Error("database search path", "error", err)
			os.Exit(1)
		}
		cfg.DatabaseURL = u
	}

	pool, err := database.Open(ctx, cfg.DatabaseURL, cfg.DatabaseSchema)
	if err != nil {
		logger.Error("failed to open postgres", "error", err)
		os.Exit(1)
	}
	defer pool.Close()

	if cfg.AutoMigrateApp {
		if err := database.RunMigrations(ctx, pool, cfg.DatabaseSchema); err != nil {
			logger.Error("failed to apply app migrations", "error", err)
			os.Exit(1)
		}
	}

	cryptoService, err := cryptox.New(cfg.MasterKey, cfg.HashKey)
	if err != nil {
		logger.Error("failed to initialize crypto", "error", err)
		os.Exit(1)
	}

	blobStore, err := blob.NewMinIO(cfg)
	if err != nil {
		logger.Error("failed to initialize minio client", "error", err)
		os.Exit(1)
	}
	if err := blobStore.EnsureBucket(ctx); err != nil {
		logger.Error("failed to ensure minio bucket", "error", err)
		os.Exit(1)
	}

	identityModule, err := identity.NewModule(cfg, logger)
	if err != nil {
		logger.Error("failed to initialize authula", "error", err)
		os.Exit(1)
	}
	defer identityModule.Auth.ClosePlugins()

	identityService := identity.NewService(cfg, logger, identityModule, identitystore.New(pool), cryptoService)
	documentsService := documents.NewService(logger, documentsstore.New(pool), cryptoService, blobStore, documents.NewExtractor(cfg))
	financeService := finance.NewService(logger, financestore.New(pool), cryptoService, documentsService)
	savingsService := savings.NewService(logger, savingsstore.New(pool))
	documentsService.SetExpenseRegistrar(financeService)
	agentService := agent.NewService(ctx, cfg, logger, financeService, documentsService, savingsService)

	router := chi.NewRouter()
	router.Use(middleware.RequestID)
	router.Use(middleware.RealIP)
	router.Use(middleware.Recoverer)
	router.Use(httpx.CORS(cfg.AllowedOrigins))
	router.Use(identityService.AuthMiddleware(publicConnectPaths()))

	router.Get("/healthz", func(w http.ResponseWriter, r *http.Request) {
		httpx.JSON(w, http.StatusOK, map[string]any{"ok": true})
	})
	router.Get("/readyz", func(w http.ResponseWriter, r *http.Request) {
		if err := pool.Ping(r.Context()); err != nil {
			httpx.JSON(w, http.StatusServiceUnavailable, map[string]any{"ok": false, "error": err.Error()})
			return
		}
		httpx.JSON(w, http.StatusOK, map[string]any{"ok": true})
	})

	router.Handle("/auth/mobile/google/callback", identityService.GoogleCallbackHandler())
	router.Handle("/auth", identityModule.Auth.Handler())
	router.Handle("/auth/*", identityModule.Auth.Handler())

	identityPath, identityHandler := identityv1connect.NewIdentityServiceHandler(identityService)
	financePath, financeHandler := financev1connect.NewFinanceServiceHandler(financeService)
	documentsPath, documentsHandler := documentsv1connect.NewReceiptServiceHandler(documentsService)
	savingsPath, savingsHandler := savingsv1connect.NewSavingsServiceHandler(savingsService)
	agentPath, agentHandler := agentv1connect.NewAgentServiceHandler(agentService)

	router.Handle(identityPath+"*", identityHandler)
	router.Handle(financePath+"*", financeHandler)
	router.Handle(documentsPath+"*", documentsHandler)
	router.Handle(savingsPath+"*", savingsHandler)
	router.Handle(agentPath+"*", agentHandler)

	server := &http.Server{
		Addr:              cfg.HTTPAddr,
		Handler:           router,
		ReadHeaderTimeout: 10 * time.Second,
	}

	go func() {
		<-ctx.Done()

		shutdownCtx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()
		_ = server.Shutdown(shutdownCtx)
	}()

	logger.Info("primerpeso backend listening", "addr", cfg.HTTPAddr)
	if err := server.ListenAndServe(); err != nil && !errors.Is(err, http.ErrServerClosed) {
		logger.Error("server exited with error", "error", err)
		os.Exit(1)
	}
}

func publicConnectPaths() map[string]struct{} {
	return map[string]struct{}{
		identityv1connect.IdentityServiceRegisterProcedure:                {},
		identityv1connect.IdentityServiceLoginProcedure:                   {},
		identityv1connect.IdentityServiceRefreshProcedure:                 {},
		identityv1connect.IdentityServiceLogoutProcedure:                  {},
		identityv1connect.IdentityServiceBeginGoogleAuthProcedure:         {},
		identityv1connect.IdentityServiceExchangeGoogleAuthCodeProcedure:  {},
		identityv1connect.IdentityServiceVerifyEmailProcedure:             {},
		identityv1connect.IdentityServiceResendVerificationEmailProcedure: {},
		identityv1connect.IdentityServiceRequestPasswordResetProcedure:    {},
		identityv1connect.IdentityServiceResetPasswordProcedure:           {},
	}
}

package identity

import (
	"context"
	"fmt"
	"log/slog"
	"time"

	authula "github.com/Authula/authula"
	authcfg "github.com/Authula/authula/config"
	authmodels "github.com/Authula/authula/models"
	emailpassword "github.com/Authula/authula/plugins/email-password"
	emailpasswordtypes "github.com/Authula/authula/plugins/email-password/types"
	emailplugin "github.com/Authula/authula/plugins/email"
	emailtypes "github.com/Authula/authula/plugins/email/types"
	authjwt "github.com/Authula/authula/plugins/jwt"
	authjwtrepo "github.com/Authula/authula/plugins/jwt/repositories"
	authjwtservices "github.com/Authula/authula/plugins/jwt/services"
	authjwttypes "github.com/Authula/authula/plugins/jwt/types"
	authoauth "github.com/Authula/authula/plugins/oauth2"
	authoauthtypes "github.com/Authula/authula/plugins/oauth2/types"
	sessionplugin "github.com/Authula/authula/plugins/session"
	"golang.org/x/oauth2"
	"golang.org/x/oauth2/google"

	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/config"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/logx"
)

type Module struct {
	cfg               config.Config
	logger            *slog.Logger
	Auth              *authula.Auth
	EmailPasswordAPI  *emailpassword.API
	OAuthAPI          *authoauth.API
	JWTService        *authjwtservices.JWTServiceImpl
	RefreshService    authjwtservices.RefreshTokenService
	RefreshRepository authjwtrepo.RefreshTokenRepository
	GoogleOAuthConfig *oauth2.Config
}

func NewModule(cfg config.Config, logger *slog.Logger) (*Module, error) {
	authLogger := logx.NewAuthula(logger)
	authConfig := authcfg.NewConfig(
		authcfg.WithAppName("PrimerPeso"),
		authcfg.WithBaseURL(cfg.PublicBaseURL),
		authcfg.WithBasePath("/auth"),
		authcfg.WithSecret(cfg.AuthSecret),
		authcfg.WithDatabase(authmodels.DatabaseConfig{
			Provider: "postgres",
			URL:      cfg.DatabaseURL,
		}),
		authcfg.WithSession(authmodels.SessionConfig{
			CookieName: "primerpeso.session",
			ExpiresIn:  cfg.JWTRefreshTTL,
			HttpOnly:   true,
			Secure:     cfg.AppEnv == "production",
			SameSite:   "lax",
		}),
		authcfg.WithSecurity(authmodels.SecurityConfig{
			TrustedOrigins: cfg.AllowedOrigins,
			CORS: authmodels.CORSConfig{
				AllowCredentials: true,
				AllowedOrigins:   cfg.AllowedOrigins,
				AllowedMethods:   []string{"GET", "POST", "OPTIONS"},
				AllowedHeaders: []string{
					"Authorization",
					"Content-Type",
					"Connect-Protocol-Version",
					"Connect-Timeout-Ms",
					"X-User-Agent",
				},
			},
		}),
	)
	authConfig.Logger.Level = "debug"

	emailPlugin := emailplugin.New(emailtypes.EmailPluginConfig{
		Enabled:     true,
		Provider:    emailtypes.ProviderSMTP,
		FromAddress: cfg.SMTPFrom,
		TLSMode:     emailtypes.SMTPTLSModeOff,
		SMTP: &emailtypes.SMTPConfig{
			Host:     cfg.SMTPHost,
			Port:     cfg.SMTPPort,
			Username: cfg.SMTPUser,
			Password: cfg.SMTPPass,
		},
	})

	emailPasswordPlugin := emailpassword.New(emailpasswordtypes.EmailPasswordPluginConfig{
		Enabled:                  true,
		AutoSignIn:               true,
		SendEmailOnSignUp:        true,
		RequireEmailVerification: true,
	})

	jwtPlugin := authjwt.New(authjwttypes.JWTPluginConfig{
		Enabled:          true,
		ExpiresIn:        cfg.JWTAccessTTL,
		RefreshExpiresIn: cfg.JWTRefreshTTL,
	})

	oauthConfig := authoauthtypes.OAuth2PluginConfig{
		Enabled: cfg.GoogleClientID != "" && cfg.GoogleClientSecret != "",
		Providers: map[string]authoauthtypes.ProviderConfig{
			"google": {
				Enabled:      cfg.GoogleClientID != "" && cfg.GoogleClientSecret != "",
				ClientID:     cfg.GoogleClientID,
				ClientSecret: cfg.GoogleClientSecret,
				RedirectURL:  cfg.GoogleCallbackURL(),
			},
		},
	}
	oauthPlugin := authoauth.New(oauthConfig)

	auth := authula.New(&authula.AuthConfig{
		Config: authConfig,
		Plugins: []authmodels.Plugin{
			emailPlugin,
			emailPasswordPlugin,
			sessionplugin.New(sessionplugin.SessionPluginConfig{Enabled: true}),
			jwtPlugin,
			oauthPlugin,
		},
	})

	jwtService, ok := auth.ServiceRegistry.Get(authmodels.ServiceJWT.String()).(*authjwtservices.JWTServiceImpl)
	if !ok {
		return nil, fmt.Errorf("authula jwt service not available")
	}

	refreshRepository := authjwtrepo.NewRefreshTokenRepository(auth.DB())
	refreshService := authjwtservices.NewRefreshTokenService(
		authLogger,
		nil,
		auth.CoreServices().SessionService,
		jwtService,
		refreshRepository,
		10*time.Second,
		cfg.JWTRefreshTTL,
	)

	var googleOAuthConfig *oauth2.Config
	if cfg.GoogleClientID != "" && cfg.GoogleClientSecret != "" {
		googleOAuthConfig = &oauth2.Config{
			ClientID:     cfg.GoogleClientID,
			ClientSecret: cfg.GoogleClientSecret,
			RedirectURL:  cfg.GoogleCallbackURL(),
			Scopes: []string{
				"openid",
				"https://www.googleapis.com/auth/userinfo.email",
				"https://www.googleapis.com/auth/userinfo.profile",
			},
			Endpoint: google.Endpoint,
		}
	}

	return &Module{
		cfg:               cfg,
		logger:            logger,
		Auth:              auth,
		EmailPasswordAPI:  emailpassword.BuildAPI(emailPasswordPlugin),
		OAuthAPI:          authoauth.BuildAPI(oauthPlugin),
		JWTService:        jwtService,
		RefreshService:    refreshService,
		RefreshRepository: refreshRepository,
		GoogleOAuthConfig: googleOAuthConfig,
	}, nil
}

func (m *Module) IssueInitialTokens(ctx context.Context, userID, sessionID string) (*authjwttypes.TokenPair, error) {
	tokenPair, err := m.JWTService.GenerateTokens(ctx, userID, sessionID)
	if err != nil {
		return nil, err
	}

	if err := m.RefreshService.StoreInitialRefreshToken(
		ctx,
		tokenPair.RefreshToken,
		sessionID,
		time.Now().Add(m.cfg.JWTRefreshTTL),
	); err != nil {
		return nil, err
	}

	return tokenPair, nil
}

func (m *Module) GoogleEnabled() bool {
	return m.GoogleOAuthConfig != nil
}

func (m *Module) NewGoogleAuthorizationURL(state string) (string, error) {
	if m.GoogleOAuthConfig == nil {
		return "", fmt.Errorf("google oauth is not configured")
	}

	return m.GoogleOAuthConfig.AuthCodeURL(
		state,
		oauth2.AccessTypeOffline,
		oauth2.SetAuthURLParam("prompt", "consent"),
	), nil
}

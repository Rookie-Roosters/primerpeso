package config

import (
	"fmt"
	"strings"
	"time"

	"github.com/caarlos0/env/v11"
)

type Config struct {
	AppEnv        string `env:"APP_ENV" envDefault:"development"`
	HTTPAddr      string `env:"HTTP_ADDR" envDefault:":8080"`
	PublicBaseURL string `env:"PUBLIC_BASE_URL" envDefault:"http://localhost:8080"`

	DatabaseURL    string `env:"DATABASE_URL,required"`
	AutoMigrateApp bool   `env:"AUTO_MIGRATE_APP" envDefault:"true"`

	AllowedOrigins []string `env:"ALLOWED_ORIGINS" envSeparator:"," envDefault:"http://localhost:3000,http://localhost:8080"`

	AuthSecret           string `env:"AUTH_SECRET" envDefault:"primerpeso-auth-secret-change-me"`
	MobileDeepLinkScheme string `env:"MOBILE_DEEP_LINK_SCHEME" envDefault:"primerpeso"`

	SMTPHost string `env:"SMTP_HOST" envDefault:"localhost"`
	SMTPPort int    `env:"SMTP_PORT" envDefault:"1025"`
	SMTPUser string `env:"SMTP_USER"`
	SMTPPass string `env:"SMTP_PASS"`
	SMTPFrom string `env:"SMTP_FROM" envDefault:"hola@primerpeso.local"`

	GoogleClientID     string `env:"GOOGLE_CLIENT_ID"`
	GoogleClientSecret string `env:"GOOGLE_CLIENT_SECRET"`

	MasterKey string `env:"MASTER_KEY" envDefault:"primerpeso-master-key-change-me"`
	HashKey   string `env:"HASH_KEY" envDefault:"primerpeso-hash-key-change-me"`

	MinIOEndpoint  string `env:"MINIO_ENDPOINT" envDefault:"localhost:9000"`
	MinIOAccessKey string `env:"MINIO_ACCESS_KEY" envDefault:"minioadmin"`
	MinIOSecretKey string `env:"MINIO_SECRET_KEY" envDefault:"minioadmin"`
	MinIOBucket    string `env:"MINIO_BUCKET" envDefault:"primerpeso-receipts"`
	MinIOUseSSL    bool   `env:"MINIO_USE_SSL" envDefault:"false"`

	XAIAPIKey             string `env:"XAI_API_KEY"`
	XAIBaseURL            string `env:"XAI_BASE_URL" envDefault:"https://api.x.ai/v1"`
	XAIModel              string `env:"XAI_MODEL" envDefault:"grok-4-1-fast-reasoning"`
	AgentSystemPromptPath string `env:"AGENT_SYSTEM_PROMPT_PATH" envDefault:"internal/agent/context/system_prompt.md"`

	JWTAccessTTL  time.Duration `env:"JWT_ACCESS_TTL" envDefault:"15m"`
	JWTRefreshTTL time.Duration `env:"JWT_REFRESH_TTL" envDefault:"168h"`

	OCRBackend  string `env:"OCR_BACKEND" envDefault:"tesseract"`
	OCRLanguage string `env:"OCR_LANGUAGE" envDefault:"spa+eng"`
}

func Load() (Config, error) {
	var cfg Config
	if err := env.Parse(&cfg); err != nil {
		return Config{}, err
	}

	cfg.PublicBaseURL = strings.TrimRight(cfg.PublicBaseURL, "/")
	return cfg, nil
}

func (c Config) GoogleCallbackURL() string {
	return c.PublicBaseURL + "/auth/mobile/google/callback"
}

func (c Config) VerifyEmailCallbackURL() string {
	return fmt.Sprintf("%s://auth/callback?mode=verify-email", c.MobileDeepLinkScheme)
}

func (c Config) PasswordResetCallbackURL() string {
	return fmt.Sprintf("%s://auth/callback?mode=reset-password", c.MobileDeepLinkScheme)
}

func (c Config) MobileExchangeRedirect(exchangeCode string) string {
	return fmt.Sprintf("%s://auth/callback?exchange_code=%s", c.MobileDeepLinkScheme, exchangeCode)
}

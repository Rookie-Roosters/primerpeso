package identity

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"log/slog"
	"net"
	"net/http"
	"net/url"
	"regexp"
	"strings"
	"time"

	"connectrpc.com/connect"
	authmodels "github.com/Authula/authula/models"
	authjwtservices "github.com/Authula/authula/plugins/jwt/services"
	authoauthtypes "github.com/Authula/authula/plugins/oauth2/types"
	"github.com/jackc/pgx/v5/pgtype"
	"google.golang.org/protobuf/types/known/timestamppb"

	identityv1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/identity/v1"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/identity/store"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/authn"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/config"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/connectx"
	cryptox "github.com/Rookie-Roosters/primerpeso/backend/internal/platform/crypto"
)

type Service struct {
	cfg     config.Config
	logger  *slog.Logger
	module  *Module
	queries *store.Queries
	crypto  *cryptox.Service
}

type googleStatePayload struct {
	Platform string `json:"platform"`
}

type authExchangePayload struct {
	UserID        string    `json:"user_id"`
	Email         string    `json:"email"`
	DisplayName   string    `json:"display_name"`
	EmailVerified bool      `json:"email_verified"`
	CreatedAt     time.Time `json:"created_at"`
	AccessToken   string    `json:"access_token"`
	RefreshToken  string    `json:"refresh_token"`
	ExpiresAt     time.Time `json:"expires_at"`
}

var deviceIDPattern = regexp.MustCompile(`^[a-zA-Z0-9._:-]{8,128}$`)

func NewService(cfg config.Config, logger *slog.Logger, module *Module, queries *store.Queries, crypto *cryptox.Service) *Service {
	return &Service{
		cfg:     cfg,
		logger:  logger,
		module:  module,
		queries: queries,
		crypto:  crypto,
	}
}

func (s *Service) AuthMiddleware(publicPaths map[string]struct{}) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			if r.Method == http.MethodOptions {
				next.ServeHTTP(w, r)
				return
			}

			if _, ok := publicPaths[r.URL.Path]; ok || strings.HasPrefix(r.URL.Path, "/auth/") || r.URL.Path == "/auth" || r.URL.Path == "/healthz" || r.URL.Path == "/readyz" {
				next.ServeHTTP(w, r)
				return
			}

			authHeader := r.Header.Get("Authorization")
			if strings.HasPrefix(strings.ToLower(authHeader), "bearer ") {
				token := strings.TrimSpace(authHeader[len("Bearer "):])
				userID, err := s.module.JWTService.ValidateToken(token)
				if err != nil {
					http.Error(w, "invalid bearer token", http.StatusUnauthorized)
					return
				}
				next.ServeHTTP(w, r.WithContext(authn.WithUserID(r.Context(), userID)))
				return
			}

			deviceID := strings.TrimSpace(r.Header.Get("X-Device-ID"))
			if deviceID == "" {
				http.Error(w, "missing identity headers", http.StatusUnauthorized)
				return
			}
			if !deviceIDPattern.MatchString(deviceID) {
				http.Error(w, "invalid X-Device-ID", http.StatusUnauthorized)
				return
			}

			next.ServeHTTP(
				w,
				r.WithContext(authn.WithUserID(r.Context(), "device:"+deviceID)),
			)
		})
	}
}

func (s *Service) Register(ctx context.Context, req *connect.Request[identityv1.RegisterRequest]) (*connect.Response[identityv1.AuthSessionResponse], error) {
	callbackURL := s.cfg.VerifyEmailCallbackURL()
	displayName := strings.TrimSpace(req.Msg.GetDisplayName())
	if displayName == "" {
		displayName = req.Msg.GetEmail()
	}

	result, err := s.module.EmailPasswordAPI.SignUp(
		ctx,
		displayName,
		strings.TrimSpace(req.Msg.GetEmail()),
		req.Msg.GetPassword(),
		nil,
		nil,
		&callbackURL,
		nil,
		nil,
	)
	if err != nil {
		return nil, connectx.InvalidArgument(err.Error())
	}

	response, err := s.sessionResponseForUser(ctx, result.User, result.Session.ID)
	if err != nil {
		return nil, connectx.Internal(err.Error())
	}

	return connect.NewResponse(response), nil
}

func (s *Service) Login(ctx context.Context, req *connect.Request[identityv1.LoginRequest]) (*connect.Response[identityv1.AuthSessionResponse], error) {
	result, err := s.module.EmailPasswordAPI.SignIn(
		ctx,
		strings.TrimSpace(req.Msg.GetEmail()),
		req.Msg.GetPassword(),
		nil,
		nil,
		nil,
	)
	if err != nil {
		return nil, connectx.Unauthenticated(err.Error())
	}

	response, err := s.sessionResponseForUser(ctx, result.User, result.Session.ID)
	if err != nil {
		return nil, connectx.Internal(err.Error())
	}

	return connect.NewResponse(response), nil
}

func (s *Service) Refresh(ctx context.Context, req *connect.Request[identityv1.RefreshRequest]) (*connect.Response[identityv1.AuthSessionResponse], error) {
	result, err := s.module.RefreshService.RefreshTokens(ctx, req.Msg.GetRefreshToken())
	if err != nil {
		return nil, connectx.Unauthenticated(err.Error())
	}

	userID, err := s.module.JWTService.ValidateToken(result.AccessToken)
	if err != nil {
		return nil, connectx.Unauthenticated(err.Error())
	}

	user, err := s.module.Auth.CoreServices().UserService.GetByID(ctx, userID)
	if err != nil || user == nil {
		return nil, connectx.Unauthenticated("user not found")
	}

	return connect.NewResponse(&identityv1.AuthSessionResponse{
		Profile: s.profileFromUser(user),
		Tokens: &identityv1.AuthTokens{
			AccessToken:  result.AccessToken,
			RefreshToken: result.RefreshToken,
			ExpiresAt:    timestamppb.New(time.Now().Add(s.cfg.JWTAccessTTL)),
		},
	}), nil
}

func (s *Service) Logout(ctx context.Context, req *connect.Request[identityv1.LogoutRequest]) (*connect.Response[identityv1.LogoutResponse], error) {
	refreshToken := strings.TrimSpace(req.Msg.GetRefreshToken())
	if refreshToken == "" {
		return connect.NewResponse(&identityv1.LogoutResponse{Ok: true}), nil
	}

	tokenHash := authjwtservices.HashRefreshToken(refreshToken)
	record, err := s.module.RefreshRepository.GetRefreshToken(ctx, tokenHash)
	if err == nil && record != nil {
		_ = s.module.RefreshRepository.RevokeAllSessionTokens(ctx, record.SessionID)
		_ = s.module.Auth.CoreServices().SessionService.Delete(ctx, record.SessionID)
	}

	return connect.NewResponse(&identityv1.LogoutResponse{Ok: true}), nil
}

func (s *Service) GetMe(ctx context.Context, _ *connect.Request[identityv1.GetMeRequest]) (*connect.Response[identityv1.GetMeResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	user, err := s.module.Auth.CoreServices().UserService.GetByID(ctx, userID)
	if err != nil || user == nil {
		return nil, connectx.NotFound("user not found")
	}

	return connect.NewResponse(&identityv1.GetMeResponse{
		Profile: s.profileFromUser(user),
	}), nil
}

func (s *Service) BeginGoogleAuth(ctx context.Context, req *connect.Request[identityv1.BeginGoogleAuthRequest]) (*connect.Response[identityv1.BeginGoogleAuthResponse], error) {
	if !s.module.GoogleEnabled() {
		return nil, connectx.InvalidArgument("google oauth is not configured")
	}

	_ = s.queries.DeleteExpiredMobileOAuthExchanges(ctx)

	state, err := s.module.Auth.CoreServices().TokenService.Generate()
	if err != nil {
		return nil, connectx.Internal("failed to generate oauth state")
	}

	if err := s.createExchange(ctx, state, "", googleStatePayload{
		Platform: req.Msg.GetPlatform(),
	}, 10*time.Minute); err != nil {
		return nil, connectx.Internal(err.Error())
	}

	authorizationURL, err := s.module.NewGoogleAuthorizationURL(state)
	if err != nil {
		return nil, connectx.Internal(err.Error())
	}

	return connect.NewResponse(&identityv1.BeginGoogleAuthResponse{
		AuthorizationUrl: authorizationURL,
		State:            state,
	}), nil
}

func (s *Service) ExchangeGoogleAuthCode(ctx context.Context, req *connect.Request[identityv1.ExchangeGoogleAuthCodeRequest]) (*connect.Response[identityv1.AuthSessionResponse], error) {
	var payload authExchangePayload
	if _, err := s.consumeExchange(ctx, req.Msg.GetExchangeCode(), &payload); err != nil {
		return nil, connectx.Unauthenticated("invalid exchange code")
	}

	return connect.NewResponse(&identityv1.AuthSessionResponse{
		Profile: &identityv1.UserProfile{
			UserId:        payload.UserID,
			Email:         payload.Email,
			DisplayName:   payload.DisplayName,
			EmailVerified: payload.EmailVerified,
			CreatedAt:     timestamppb.New(payload.CreatedAt),
		},
		Tokens: &identityv1.AuthTokens{
			AccessToken:  payload.AccessToken,
			RefreshToken: payload.RefreshToken,
			ExpiresAt:    timestamppb.New(payload.ExpiresAt),
		},
	}), nil
}

func (s *Service) VerifyEmail(ctx context.Context, req *connect.Request[identityv1.VerifyEmailRequest]) (*connect.Response[identityv1.GetMeResponse], error) {
	hashedToken := s.module.Auth.CoreServices().TokenService.Hash(req.Msg.GetVerificationToken())
	verification, err := s.module.Auth.CoreServices().VerificationService.GetByToken(ctx, hashedToken)
	if err != nil || verification == nil || verification.UserID == nil {
		return nil, connectx.InvalidArgument("invalid verification token")
	}

	if _, err := s.module.EmailPasswordAPI.VerifyEmail(ctx, req.Msg.GetVerificationToken()); err != nil {
		return nil, connectx.InvalidArgument(err.Error())
	}

	user, err := s.module.Auth.CoreServices().UserService.GetByID(ctx, *verification.UserID)
	if err != nil || user == nil {
		return nil, connectx.NotFound("user not found")
	}

	return connect.NewResponse(&identityv1.GetMeResponse{
		Profile: s.profileFromUser(user),
	}), nil
}

func (s *Service) ResendVerificationEmail(ctx context.Context, req *connect.Request[identityv1.ResendVerificationEmailRequest]) (*connect.Response[identityv1.ResendVerificationEmailResponse], error) {
	callbackURL := s.cfg.VerifyEmailCallbackURL()
	if err := s.module.EmailPasswordAPI.SendEmailVerification(ctx, strings.TrimSpace(req.Msg.GetEmail()), &callbackURL); err != nil {
		return nil, connectx.InvalidArgument(err.Error())
	}

	return connect.NewResponse(&identityv1.ResendVerificationEmailResponse{Ok: true}), nil
}

func (s *Service) RequestPasswordReset(ctx context.Context, req *connect.Request[identityv1.RequestPasswordResetRequest]) (*connect.Response[identityv1.RequestPasswordResetResponse], error) {
	callbackURL := s.cfg.PasswordResetCallbackURL()
	if err := s.module.EmailPasswordAPI.RequestPasswordReset(ctx, strings.TrimSpace(req.Msg.GetEmail()), &callbackURL); err != nil {
		return nil, connectx.InvalidArgument(err.Error())
	}

	return connect.NewResponse(&identityv1.RequestPasswordResetResponse{Ok: true}), nil
}

func (s *Service) ResetPassword(ctx context.Context, req *connect.Request[identityv1.ResetPasswordRequest]) (*connect.Response[identityv1.ResetPasswordResponse], error) {
	if err := s.module.EmailPasswordAPI.ChangePassword(ctx, req.Msg.GetResetToken(), req.Msg.GetNewPassword()); err != nil {
		return nil, connectx.InvalidArgument(err.Error())
	}

	return connect.NewResponse(&identityv1.ResetPasswordResponse{Ok: true}), nil
}

func (s *Service) GoogleCallbackHandler() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if !s.module.GoogleEnabled() || s.module.OAuthAPI == nil {
			http.Error(w, "google oauth is not configured", http.StatusNotFound)
			return
		}

		ctx := r.Context()
		_ = s.queries.DeleteExpiredMobileOAuthExchanges(ctx)

		state := r.URL.Query().Get("state")
		code := r.URL.Query().Get("code")
		providerError := r.URL.Query().Get("error")
		if state == "" {
			s.redirectMobileError(w, r, "missing_state")
			return
		}

		if _, err := s.consumeExchange(ctx, state, &googleStatePayload{}); err != nil {
			s.redirectMobileError(w, r, "invalid_state")
			return
		}

		result, err := s.module.OAuthAPI.Callback(ctx, &authoauthtypes.CallbackRequest{
			ProviderID: "google",
			Code:       code,
			State:      state,
			Error:      providerError,
		}, requestIP(r), requestUserAgent(r))
		if err != nil {
			s.logger.Warn("google oauth callback failed", "error", err)
			s.redirectMobileError(w, r, "oauth_callback_failed")
			return
		}

		tokenPair, err := s.module.IssueInitialTokens(ctx, result.User.ID, result.Session.ID)
		if err != nil {
			s.logger.Error("failed to issue initial tokens for oauth login", "error", err)
			s.redirectMobileError(w, r, "token_issue_failed")
			return
		}

		exchangeCode, err := s.module.Auth.CoreServices().TokenService.Generate()
		if err != nil {
			s.redirectMobileError(w, r, "exchange_generation_failed")
			return
		}

		payload := authExchangePayload{
			UserID:        result.User.ID,
			Email:         result.User.Email,
			DisplayName:   result.User.Name,
			EmailVerified: result.User.EmailVerified,
			CreatedAt:     result.User.CreatedAt,
			AccessToken:   tokenPair.AccessToken,
			RefreshToken:  tokenPair.RefreshToken,
			ExpiresAt:     time.Now().Add(s.cfg.JWTAccessTTL),
		}

		if err := s.createExchange(ctx, exchangeCode, result.User.ID, payload, 5*time.Minute); err != nil {
			s.logger.Error("failed to persist mobile exchange code", "error", err)
			s.redirectMobileError(w, r, "exchange_store_failed")
			return
		}

		http.Redirect(w, r, s.cfg.MobileExchangeRedirect(url.QueryEscape(exchangeCode)), http.StatusFound)
	})
}

func (s *Service) sessionResponseForUser(ctx context.Context, user *authmodels.User, sessionID string) (*identityv1.AuthSessionResponse, error) {
	tokenPair, err := s.module.IssueInitialTokens(ctx, user.ID, sessionID)
	if err != nil {
		return nil, err
	}

	return &identityv1.AuthSessionResponse{
		Profile: s.profileFromUser(user),
		Tokens: &identityv1.AuthTokens{
			AccessToken:  tokenPair.AccessToken,
			RefreshToken: tokenPair.RefreshToken,
			ExpiresAt:    timestamppb.New(time.Now().Add(s.cfg.JWTAccessTTL)),
		},
	}, nil
}

func (s *Service) profileFromUser(user *authmodels.User) *identityv1.UserProfile {
	if user == nil {
		return nil
	}

	return &identityv1.UserProfile{
		UserId:        user.ID,
		Email:         user.Email,
		DisplayName:   user.Name,
		EmailVerified: user.EmailVerified,
		CreatedAt:     timestamppb.New(user.CreatedAt),
	}
}

func (s *Service) createExchange(ctx context.Context, code, userID string, payload any, ttl time.Duration) error {
	body, err := json.Marshal(payload)
	if err != nil {
		return fmt.Errorf("marshal exchange payload: %w", err)
	}

	encrypted, err := s.crypto.EncryptBytes(body)
	if err != nil {
		return fmt.Errorf("encrypt exchange payload: %w", err)
	}

	_, err = s.queries.CreateMobileOAuthExchange(ctx, store.CreateMobileOAuthExchangeParams{
		Code:             code,
		UserID:           userID,
		EncryptedPayload: encrypted,
		ExpiresAt: pgtype.Timestamptz{
			Time:  time.Now().Add(ttl),
			Valid: true,
		},
	})
	if err != nil {
		return fmt.Errorf("create mobile oauth exchange: %w", err)
	}

	return nil
}

func (s *Service) consumeExchange(ctx context.Context, code string, target any) (*store.MobileOauthExchange, error) {
	record, err := s.queries.ConsumeMobileOAuthExchange(ctx, code)
	if err != nil {
		return nil, err
	}

	plaintext, err := s.crypto.DecryptBytes(record.EncryptedPayload)
	if err != nil {
		return nil, err
	}

	if err := json.Unmarshal(plaintext, target); err != nil {
		return nil, err
	}

	return &record, nil
}

func (s *Service) redirectMobileError(w http.ResponseWriter, r *http.Request, errorCode string) {
	target := fmt.Sprintf("%s://auth/callback?error=%s", s.cfg.MobileDeepLinkScheme, url.QueryEscape(errorCode))
	http.Redirect(w, r, target, http.StatusFound)
}

func requestIP(r *http.Request) *string {
	host, _, err := net.SplitHostPort(r.RemoteAddr)
	if err != nil {
		if strings.TrimSpace(r.RemoteAddr) == "" {
			return nil
		}
		value := r.RemoteAddr
		return &value
	}
	return &host
}

func requestUserAgent(r *http.Request) *string {
	ua := strings.TrimSpace(r.UserAgent())
	if ua == "" {
		return nil
	}
	return &ua
}

var (
	_ interface {
		Register(context.Context, *connect.Request[identityv1.RegisterRequest]) (*connect.Response[identityv1.AuthSessionResponse], error)
	} = (*Service)(nil)
	_ = errors.New
)

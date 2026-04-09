package identity

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/authn"
)

func TestAuthMiddleware_RejectsMissingIdentity(t *testing.T) {
	service := &Service{}
	middleware := service.AuthMiddleware(map[string]struct{}{})

	var called bool
	handler := middleware(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		called = true
		w.WriteHeader(http.StatusOK)
	}))

	request := httptest.NewRequest(http.MethodGet, "/private", nil)
	recorder := httptest.NewRecorder()
	handler.ServeHTTP(recorder, request)

	if called {
		t.Fatalf("handler should not be called")
	}
	if recorder.Code != http.StatusUnauthorized {
		t.Fatalf("expected 401, got %d", recorder.Code)
	}
}

func TestAuthMiddleware_AcceptsDeviceID(t *testing.T) {
	service := &Service{}
	middleware := service.AuthMiddleware(map[string]struct{}{})

	var userID string
	handler := middleware(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		resolved, ok := authn.UserID(r.Context())
		if !ok {
			t.Fatalf("user id missing in context")
		}
		userID = resolved
		w.WriteHeader(http.StatusOK)
	}))

	request := httptest.NewRequest(http.MethodGet, "/private", nil)
	request.Header.Set("X-Device-ID", "dev-abc12345-foo")
	recorder := httptest.NewRecorder()
	handler.ServeHTTP(recorder, request)

	if recorder.Code != http.StatusOK {
		t.Fatalf("expected 200, got %d", recorder.Code)
	}
	if userID != "device:dev-abc12345-foo" {
		t.Fatalf("unexpected user id: %s", userID)
	}
}

func TestAuthMiddleware_RejectsInvalidDeviceID(t *testing.T) {
	service := &Service{}
	middleware := service.AuthMiddleware(map[string]struct{}{})

	handler := middleware(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
	}))

	request := httptest.NewRequest(http.MethodGet, "/private", nil)
	request.Header.Set("X-Device-ID", "bad id")
	recorder := httptest.NewRecorder()
	handler.ServeHTTP(recorder, request)

	if recorder.Code != http.StatusUnauthorized {
		t.Fatalf("expected 401, got %d", recorder.Code)
	}
}

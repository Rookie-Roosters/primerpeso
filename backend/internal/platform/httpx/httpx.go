package httpx

import (
	"encoding/json"
	"net/http"
	"strings"
)

func JSON(w http.ResponseWriter, status int, payload any) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	_ = json.NewEncoder(w).Encode(payload)
}

func CORS(allowedOrigins []string) func(http.Handler) http.Handler {
	origins := make(map[string]struct{}, len(allowedOrigins))
	allowAll := false
	for _, origin := range allowedOrigins {
		trimmed := strings.TrimSpace(origin)
		if trimmed == "" {
			continue
		}
		if trimmed == "*" {
			allowAll = true
		}
		origins[trimmed] = struct{}{}
	}

	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			origin := r.Header.Get("Origin")
			allowedOrigin := ""
			if allowAll {
				// Credentialed browser requests cannot use wildcard origin.
				if origin != "" {
					allowedOrigin = origin
				} else {
					allowedOrigin = "*"
				}
			} else if _, ok := origins[origin]; ok {
				allowedOrigin = origin
			}

			if allowedOrigin != "" {
				w.Header().Set("Access-Control-Allow-Origin", allowedOrigin)
			}
			if origin != "" {
				w.Header().Set("Access-Control-Allow-Credentials", "true")
			}
			if allowedOrigin != "*" && origin != "" {
				w.Header().Add("Vary", "Origin")
			}

			w.Header().Set(
				"Access-Control-Allow-Headers",
				"Authorization, Content-Type, Connect-Protocol-Version, Connect-Timeout-Ms, X-Device-ID, X-User-Agent",
			)
			w.Header().Set("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
			w.Header().Set("Access-Control-Expose-Headers", "Grpc-Status, Grpc-Message, Grpc-Status-Details-Bin")

			if r.Method == http.MethodOptions {
				w.WriteHeader(http.StatusNoContent)
				return
			}

			next.ServeHTTP(w, r)
		})
	}
}

package authn

import "context"

type contextKey string

const userIDContextKey contextKey = "primerpeso.user_id"

func WithUserID(ctx context.Context, userID string) context.Context {
	return context.WithValue(ctx, userIDContextKey, userID)
}

func UserID(ctx context.Context) (string, bool) {
	userID, ok := ctx.Value(userIDContextKey).(string)
	return userID, ok && userID != ""
}

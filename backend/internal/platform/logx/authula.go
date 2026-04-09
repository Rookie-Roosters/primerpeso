package logx

import "log/slog"

type AuthulaLogger struct {
	logger *slog.Logger
}

func NewAuthula(logger *slog.Logger) *AuthulaLogger {
	return &AuthulaLogger{logger: logger}
}

func (l *AuthulaLogger) Debug(msg string, args ...any) {
	l.logger.Debug(msg, args...)
}

func (l *AuthulaLogger) Info(msg string, args ...any) {
	l.logger.Info(msg, args...)
}

func (l *AuthulaLogger) Warn(msg string, args ...any) {
	l.logger.Warn(msg, args...)
}

func (l *AuthulaLogger) Error(msg string, args ...any) {
	l.logger.Error(msg, args...)
}

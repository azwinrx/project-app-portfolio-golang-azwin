package middleware

import (
	"net/http"
	"time"

	"go.uber.org/zap"
)

// Logging middleware untuk log request dengan zap
func Logging(logger *zap.Logger) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			start := time.Now()

			// Log incoming request
			logger.Info("Incoming request",
				zap.String("method", r.Method),
				zap.String("url", r.URL.String()),
				zap.String("remote_addr", r.RemoteAddr),
				zap.String("user_agent", r.UserAgent()),
			)

			next.ServeHTTP(w, r)

			// Log response
			duration := time.Since(start)
			logger.Info("Request completed",
				zap.String("method", r.Method),
				zap.String("url", r.URL.String()),
				zap.Duration("duration", duration),
			)
		})
	}
}

func NewMiddlewareCostume(log *zap.Logger) *MiddlewareCostume {
	return &MiddlewareCostume{Log: log}
}

func (m *MiddlewareCostume) Logging(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()

		next.ServeHTTP(w, r)

		duration := time.Since(start)
		m.Log.Info("Activity route",
			zap.String("method", r.Method),
			zap.String("url", r.URL.String()),
			zap.Duration("duration", duration),
		)
	})
}

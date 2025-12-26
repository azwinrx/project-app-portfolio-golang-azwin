package middleware

import (
	"net/http"
	"regexp"
	"strings"
)

// ValidateContactForm middleware untuk validasi form contact
func ValidateContactForm(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Method == http.MethodPost && strings.HasSuffix(r.URL.Path, "/send") {
			// Parse form
			if err := r.ParseForm(); err != nil {
				http.Error(w, "Invalid form data", http.StatusBadRequest)
				return
			}

			// Validasi name
			name := strings.TrimSpace(r.FormValue("name"))
			if name == "" || len(name) < 2 || len(name) > 100 {
				http.Error(w, "Name must be between 2-100 characters", http.StatusBadRequest)
				return
			}

			// Validasi email
			email := strings.TrimSpace(r.FormValue("email"))
			emailRegex := regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`)
			if !emailRegex.MatchString(email) {
				http.Error(w, "Invalid email format", http.StatusBadRequest)
				return
			}

			// Validasi subject (optional)
			subject := r.FormValue("subject")
			if len(subject) > 200 {
				http.Error(w, "Subject too long (max 200 characters)", http.StatusBadRequest)
				return
			}

			// Validasi message
			message := strings.TrimSpace(r.FormValue("message"))
			if message == "" || len(message) < 10 || len(message) > 1000 {
				http.Error(w, "Message must be between 10-1000 characters", http.StatusBadRequest)
				return
			}

			// Validasi phone (optional)
			phone := r.FormValue("phone")
			if phone != "" && len(phone) > 20 {
				http.Error(w, "Phone number too long (max 20 characters)", http.StatusBadRequest)
				return
			}

			// Sanitasi input (basic)
			r.Form.Set("name", name)
			r.Form.Set("email", email)
			r.Form.Set("subject", subject)
			r.Form.Set("message", message)
			r.Form.Set("phone", phone)
		}

		next.ServeHTTP(w, r)
	})
}

// RateLimitContactForm middleware untuk rate limiting contact form
func RateLimitContactForm(maxRequests int, windowSeconds int) func(http.Handler) http.Handler {
	// Simple in-memory rate limiter (untuk demo)
	// Dalam production, gunakan Redis atau database
	requests := make(map[string][]int64)

	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			if r.Method == http.MethodPost && strings.HasSuffix(r.URL.Path, "/send") {
				ip := r.RemoteAddr

				// Cek rate limit (simplified)
				// Dalam implementasi nyata, gunakan time-based window
				if len(requests[ip]) >= maxRequests {
					http.Error(w, "Too many requests. Please try again later.", http.StatusTooManyRequests)
					return
				}

				// Track request
				requests[ip] = append(requests[ip], 1) // Simplified
			}

			next.ServeHTTP(w, r)
		})
	}
}
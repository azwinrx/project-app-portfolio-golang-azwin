package model

import (
	"time"
)

type ContactMessage struct {
	ID         int        `json:"id" db:"id"`
	Name       string     `json:"name" db:"name"`
	Email      string     `json:"email" db:"email"`
	Subject    *string    `json:"subject" db:"subject"`
	Message    string     `json:"message" db:"message"`
	Phone      *string    `json:"phone" db:"phone"`
	IsRead     bool       `json:"is_read" db:"is_read"`
	IsReplied  bool       `json:"is_replied" db:"is_replied"`
	IPAddress  *string    `json:"ip_address" db:"ip_address"`
	UserAgent  *string    `json:"user_agent" db:"user_agent"`
	CreatedAt  time.Time  `json:"created_at" db:"created_at"`
}
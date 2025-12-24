package model

import (
	"database/sql"
	"time"
)

type ContactMessage struct {
	ID        int            `json:"id" db:"id"`
	Name      string         `json:"name" db:"name"`
	Email     string         `json:"email" db:"email"`
	Subject   sql.NullString `json:"subject" db:"subject"`
	Message   string         `json:"message" db:"message"`
	Phone     sql.NullString `json:"phone" db:"phone"`
	IsRead    bool           `json:"is_read" db:"is_read"`
	IsReplied bool           `json:"is_replied" db:"is_replied"`
	IPAddress sql.NullString `json:"ip_address" db:"ip_address"`
	UserAgent sql.NullString `json:"user_agent" db:"user_agent"`
	CreatedAt time.Time      `json:"created_at" db:"created_at"`
}

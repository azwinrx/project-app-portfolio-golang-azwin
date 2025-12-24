package model

import (
	"database/sql"
	"time"
)

type SocialMedia struct {
	ID           int            `json:"id" db:"id"`
	ProfileID    int            `json:"profile_id" db:"profile_id"`
	Platform     string         `json:"platform" db:"platform"`
	URL          string         `json:"url" db:"url"`
	IconClass    sql.NullString `json:"icon_class" db:"icon_class"`
	DisplayOrder int            `json:"display_order" db:"display_order"`
	IsActive     bool           `json:"is_active" db:"is_active"`
	CreatedAt    time.Time      `json:"created_at" db:"created_at"`
}

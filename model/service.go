package model

import (
	"database/sql"
	"time"
)

type Service struct {
	ID           int            `json:"id" db:"id"`
	Title        string         `json:"title" db:"title"`
	Description  string         `json:"description" db:"description"`
	IconClass    sql.NullString `json:"icon_class" db:"icon_class"`
	ImageURL     sql.NullString `json:"image_url" db:"image_url"`
	PriceRange   sql.NullString `json:"price_range" db:"price_range"`
	IsActive     bool           `json:"is_active" db:"is_active"`
	DisplayOrder int            `json:"display_order" db:"display_order"`
	CreatedAt    time.Time      `json:"created_at" db:"created_at"`
	UpdatedAt    time.Time      `json:"updated_at" db:"updated_at"`
}

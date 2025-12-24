package model

import (
	"database/sql"
	"time"
)

type ProjectImage struct {
	ID           int            `json:"id" db:"id"`
	ProjectID    int            `json:"project_id" db:"project_id"`
	ImageURL     string         `json:"image_url" db:"image_url"`
	Caption      sql.NullString `json:"caption" db:"caption"`
	DisplayOrder int            `json:"display_order" db:"display_order"`
	CreatedAt    time.Time      `json:"created_at" db:"created_at"`
}

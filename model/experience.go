package model

import (
	"database/sql"
	"time"

	"github.com/lib/pq"
)

type Experience struct {
	ID               int            `json:"id" db:"id"`
	ProfileID        int            `json:"profile_id" db:"profile_id"`
	CompanyName      string         `json:"company_name" db:"company_name"`
	Position         string         `json:"position" db:"position"`
	Location         sql.NullString `json:"location" db:"location"`
	StartDate        time.Time      `json:"start_date" db:"start_date"`
	EndDate          sql.NullTime   `json:"end_date" db:"end_date"`
	IsCurrent        bool           `json:"is_current" db:"is_current"`
	Description      sql.NullString `json:"description" db:"description"`
	Responsibilities pq.StringArray `json:"responsibilities" db:"responsibilities"`
	CreatedAt        time.Time      `json:"created_at" db:"created_at"`
	UpdatedAt        time.Time      `json:"updated_at" db:"updated_at"`
}

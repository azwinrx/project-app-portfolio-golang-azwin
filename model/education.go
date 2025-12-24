package model

import (
	"database/sql"
	"time"
)

type Education struct {
	ID           int            `json:"id" db:"id"`
	ProfileID    int            `json:"profile_id" db:"profile_id"`
	Institution  string         `json:"institution" db:"institution"`
	Degree       string         `json:"degree" db:"degree"`
	FieldOfStudy sql.NullString `json:"field_of_study" db:"field_of_study"`
	StartDate    time.Time      `json:"start_date" db:"start_date"`
	EndDate      sql.NullTime   `json:"end_date" db:"end_date"`
	Grade        sql.NullString `json:"grade" db:"grade"`
	Description  sql.NullString `json:"description" db:"description"`
	CreatedAt    time.Time      `json:"created_at" db:"created_at"`
	UpdatedAt    time.Time      `json:"updated_at" db:"updated_at"`
}

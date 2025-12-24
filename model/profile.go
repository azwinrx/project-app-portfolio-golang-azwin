package model

import (
	"database/sql"
	"time"
)

type Profile struct {
	ID           int            `json:"id" db:"id"`
	FullName     string         `json:"full_name" db:"full_name"`
	Title        string         `json:"title" db:"title"`
	Bio          string         `json:"bio" db:"bio"`
	ProfileImage sql.NullString `json:"profile_image" db:"profile_image"`
	Email        string         `json:"email" db:"email"`
	Phone        sql.NullString `json:"phone" db:"phone"`
	Address      sql.NullString `json:"address" db:"address"`
	DateOfBirth  sql.NullTime   `json:"date_of_birth" db:"date_of_birth"`
	Website      sql.NullString `json:"website" db:"website"`
	ResumeURL    sql.NullString `json:"resume_url" db:"resume_url"`
	CreatedAt    time.Time      `json:"created_at" db:"created_at"`
	UpdatedAt    time.Time      `json:"updated_at" db:"updated_at"`
}

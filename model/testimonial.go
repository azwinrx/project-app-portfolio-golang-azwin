package model

import (
	"database/sql"
	"time"
)

type Testimonial struct {
	ID              int            `json:"id" db:"id"`
	ClientName      string         `json:"client_name" db:"client_name"`
	ClientPosition  sql.NullString `json:"client_position" db:"client_position"`
	ClientCompany   sql.NullString `json:"client_company" db:"client_company"`
	ClientImage     sql.NullString `json:"client_image" db:"client_image"`
	TestimonialText string         `json:"testimonial_text" db:"testimonial_text"`
	Rating          sql.NullInt32  `json:"rating" db:"rating"`
	IsApproved      bool           `json:"is_approved" db:"is_approved"`
	DisplayOrder    int            `json:"display_order" db:"display_order"`
	CreatedAt       time.Time      `json:"created_at" db:"created_at"`
	UpdatedAt       time.Time      `json:"updated_at" db:"updated_at"`
}

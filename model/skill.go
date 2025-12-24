package model

import (
	"database/sql"
	"time"
)

type Skill struct {
	ID                int            `json:"id" db:"id"`
	ProfileID         int            `json:"profile_id" db:"profile_id"`
	SkillName         string         `json:"skill_name" db:"skill_name"`
	Category          sql.NullString `json:"category" db:"category"`
	ProficiencyLevel  sql.NullInt32  `json:"proficiency_level" db:"proficiency_level"`
	YearsOfExperience sql.NullInt32  `json:"years_of_experience" db:"years_of_experience"`
	DisplayOrder      int            `json:"display_order" db:"display_order"`
	CreatedAt         time.Time      `json:"created_at" db:"created_at"`
	UpdatedAt         time.Time      `json:"updated_at" db:"updated_at"`
}

package model

import (
	"time"
)

type Project struct {
	ID                  int            `json:"id" db:"id"`
	Title               string         `json:"title" db:"title"`
	Description         string         `json:"description" db:"description"`
	DetailedDescription string `json:"detailed_description" db:"detailed_description"`
	Category            string         `json:"category" db:"category"`
	ClientName          *string `json:"client_name" db:"client_name"`
	ProjectURL          *string `json:"project_url" db:"project_url"`
	GithubURL           *string `json:"github_url" db:"github_url"`
	ThumbnailImage      *string `json:"thumbnail_image" db:"thumbnail_image"`
	StartDate           *time.Time   `json:"start_date" db:"start_date"`
	EndDate             *time.Time   `json:"end_date" db:"end_date"`
	Status              string         `json:"status" db:"status"`
	Technologies        []string `json:"technologies" db:"technologies"`
	IsFeatured          bool           `json:"is_featured" db:"is_featured"`
	ViewCount           int            `json:"view_count" db:"view_count"`
	CreatedAt           time.Time      `json:"created_at" db:"created_at"`
	UpdatedAt           time.Time      `json:"updated_at" db:"updated_at"`
}

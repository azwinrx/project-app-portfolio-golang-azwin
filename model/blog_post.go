package model

import (
	"database/sql"
	"time"

	"github.com/lib/pq"
)

type BlogPost struct {
	ID             int            `json:"id" db:"id"`
	Title          string         `json:"title" db:"title"`
	Slug           string         `json:"slug" db:"slug"`
	Content        string         `json:"content" db:"content"`
	Excerpt        sql.NullString `json:"excerpt" db:"excerpt"`
	FeaturedImage  sql.NullString `json:"featured_image" db:"featured_image"`
	AuthorName     string         `json:"author_name" db:"author_name"`
	Category       sql.NullString `json:"category" db:"category"`
	Tags           pq.StringArray `json:"tags" db:"tags"`
	IsPublished    bool           `json:"is_published" db:"is_published"`
	PublishedAt    sql.NullTime   `json:"published_at" db:"published_at"`
	ViewCount      int            `json:"view_count" db:"view_count"`
	ReadingTime    sql.NullInt32  `json:"reading_time" db:"reading_time"`
	CreatedAt      time.Time      `json:"created_at" db:"created_at"`
	UpdatedAt      time.Time      `json:"updated_at" db:"updated_at"`
}

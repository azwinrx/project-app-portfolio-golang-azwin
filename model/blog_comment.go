package model

import (
	"database/sql"
	"time"
)

type BlogComment struct {
	ID               int            `json:"id" db:"id"`
	BlogPostID       int            `json:"blog_post_id" db:"blog_post_id"`
	CommenterName    string         `json:"commenter_name" db:"commenter_name"`
	CommenterEmail   string         `json:"commenter_email" db:"commenter_email"`
	CommenterWebsite sql.NullString `json:"commenter_website" db:"commenter_website"`
	CommentText      string         `json:"comment_text" db:"comment_text"`
	IsApproved       bool           `json:"is_approved" db:"is_approved"`
	CreatedAt        time.Time      `json:"created_at" db:"created_at"`
}

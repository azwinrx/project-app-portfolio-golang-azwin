package repository

import (
	"context"
	"project-app-portfolio-golang-azwin/database"
	"project-app-portfolio-golang-azwin/model"
)

type ContactRepoInterface interface {
	CreateContactMessage(ctx context.Context, contact *model.ContactMessage) error
	GetAllContactMessages(ctx context.Context) ([]model.ContactMessage, error)
	GetContactMessageByID(ctx context.Context, id int) (*model.ContactMessage, error)
	MarkAsRead(ctx context.Context, id int) error
	MarkAsReplied(ctx context.Context, id int) error
}

type ContactRepository struct {
	db database.PgxIface
}

func NewContactRepository(db database.PgxIface) *ContactRepository {
	return &ContactRepository{db: db}
}

func (r *ContactRepository) CreateContactMessage(ctx context.Context, contact *model.ContactMessage) error {
	query := `INSERT INTO contact_messages (name, email, subject, message, phone, ip_address, user_agent) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id, created_at`
	err := r.db.QueryRow(ctx, query, contact.Name, contact.Email, contact.Subject, contact.Message, contact.Phone, contact.IPAddress, contact.UserAgent).Scan(&contact.ID, &contact.CreatedAt)
	return err
}

func (r *ContactRepository) GetAllContactMessages(ctx context.Context) ([]model.ContactMessage, error) {
	query := `SELECT id, name, email, subject, message, phone, is_read, is_replied, ip_address, user_agent, created_at FROM contact_messages ORDER BY created_at DESC`
	rows, err := r.db.Query(ctx, query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var messages []model.ContactMessage
	for rows.Next() {
		var m model.ContactMessage
		err := rows.Scan(&m.ID, &m.Name, &m.Email, &m.Subject, &m.Message, &m.Phone, &m.IsRead, &m.IsReplied, &m.IPAddress, &m.UserAgent, &m.CreatedAt)
		if err != nil {
			return nil, err
		}
		messages = append(messages, m)
	}
	if err = rows.Err(); err != nil {
		return nil, err
	}
	return messages, nil
}

func (r *ContactRepository) GetContactMessageByID(ctx context.Context, id int) (*model.ContactMessage, error) {
	query := `SELECT id, name, email, subject, message, phone, is_read, is_replied, ip_address, user_agent, created_at FROM contact_messages WHERE id = $1`
	var m model.ContactMessage
	err := r.db.QueryRow(ctx, query, id).Scan(&m.ID, &m.Name, &m.Email, &m.Subject, &m.Message, &m.Phone, &m.IsRead, &m.IsReplied, &m.IPAddress, &m.UserAgent, &m.CreatedAt)
	if err != nil {
		return nil, err
	}
	return &m, nil
}

func (r *ContactRepository) MarkAsRead(ctx context.Context, id int) error {
	query := `UPDATE contact_messages SET is_read = TRUE WHERE id = $1`
	_, err := r.db.Exec(ctx, query, id)
	return err
}

func (r *ContactRepository) MarkAsReplied(ctx context.Context, id int) error {
	query := `UPDATE contact_messages SET is_replied = TRUE WHERE id = $1`
	_, err := r.db.Exec(ctx, query, id)
	return err
}
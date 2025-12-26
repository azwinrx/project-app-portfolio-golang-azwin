package service

import (
	"context"
	"project-app-portfolio-golang-azwin/model"
	"project-app-portfolio-golang-azwin/repository"
)

// ContactService interface untuk dependency injection dan testing
type ContactService interface {
	CreateContactMessage(ctx context.Context, contact *model.ContactMessage) error
	GetAllContactMessages(ctx context.Context) ([]model.ContactMessage, error)
	GetContactMessageByID(ctx context.Context, id int) (*model.ContactMessage, error)
	MarkAsRead(ctx context.Context, id int) error
	MarkAsReplied(ctx context.Context, id int) error
}

// contactService implementasi dari ContactService
type contactService struct {
	repo repository.ContactRepoInterface
}

// NewContactService constructor untuk contactService
func NewContactService(repo repository.ContactRepoInterface) ContactService {
	return &contactService{repo: repo}
}

// CreateContactMessage method bisnis untuk membuat pesan contact baru
func (s *contactService) CreateContactMessage(ctx context.Context, contact *model.ContactMessage) error {
	return s.repo.CreateContactMessage(ctx, contact)
}

// GetAllContactMessages method bisnis untuk mendapatkan semua pesan contact
func (s *contactService) GetAllContactMessages(ctx context.Context) ([]model.ContactMessage, error) {
	return s.repo.GetAllContactMessages(ctx)
}

// GetContactMessageByID method bisnis untuk mendapatkan pesan contact by ID
func (s *contactService) GetContactMessageByID(ctx context.Context, id int) (*model.ContactMessage, error) {
	return s.repo.GetContactMessageByID(ctx, id)
}

// MarkAsRead method bisnis untuk menandai pesan sebagai sudah dibaca
func (s *contactService) MarkAsRead(ctx context.Context, id int) error {
	return s.repo.MarkAsRead(ctx, id)
}

// MarkAsReplied method bisnis untuk menandai pesan sebagai sudah direply
func (s *contactService) MarkAsReplied(ctx context.Context, id int) error {
	return s.repo.MarkAsReplied(ctx, id)
}
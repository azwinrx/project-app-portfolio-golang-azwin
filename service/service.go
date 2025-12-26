package service

import (
	"project-app-portfolio-golang-azwin/repository"
)

// Service struct utama yang menampung semua service
type Service struct {
	ProjectService ProjectService
	ContactService ContactService
	// Tambahkan service lain di sini jika perlu
}

// NewService constructor untuk Service utama
func NewService(repo repository.ProjectRepoInterface, contactRepo repository.ContactRepoInterface) *Service {
	return &Service{
		ProjectService: NewProjectService(repo),
		ContactService: NewContactService(contactRepo),
	}
}
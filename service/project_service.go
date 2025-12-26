package service

import (
	"context"
	"project-app-portfolio-golang-azwin/model"
	"project-app-portfolio-golang-azwin/repository"
)

// ProjectService interface untuk dependency injection dan testing
type ProjectService interface {
	GetAllProjects(ctx context.Context) ([]model.Project, error)
	// Tambahkan method lain jika perlu
}

// projectService implementasi dari ProjectService
type projectService struct {
	repo repository.ProjectRepoInterface
}

// NewProjectService constructor untuk projectService
func NewProjectService(repo repository.ProjectRepoInterface) ProjectService {
	return &projectService{repo: repo}
}

// GetAllProjects method bisnis untuk mendapatkan semua project
func (s *projectService) GetAllProjects(ctx context.Context) ([]model.Project, error) {
	return s.repo.GetAllProject(ctx)
}
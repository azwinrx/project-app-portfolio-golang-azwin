package service

import "project-app-portfolio-golang-azwin/repository"

type ProjectService interface {
	GetProjects() ([]repository.ProjectRepository, error)
}

type projectService struct {
	Repo repository.ProjectRepository
}

func NewProjectService(repo repository.ProjectRepository) ProjectService {
	return &projectService{Repo: repo}
}

func (s *projectService) GetProjects() ([]repository.Project, error) {
	return s.Repo.GetProjects()
}
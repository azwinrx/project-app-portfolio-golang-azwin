package repository

import (
	"context"
	"project-app-portfolio-golang-azwin/database"
	"project-app-portfolio-golang-azwin/model"
)

type ProjectRepository interface {
	GetProjects() ([]model.Project, error)
}

type projectRepository struct {
	db database.PgxIface
}

func NewProjectRepository(db database.PgxIface) ProjectRepository {
	return &projectRepository{db: db}
}

func (r *projectRepository) GetProjects() ([]model.Project, error){
	query := `SELECT id, title, description, category, thumbnail_image, technologies, github_url, project_url, status FROM projects ORDER BY id ASC;`
	
	rows, err := r.db.Query(context.Background(), query)

	if err != nil {
		return nil, err
	}

	defer rows.Close()

	var	projects []model.Project
	for rows.Next() {
		var a model.Project
		err := rows.Scan(
			&a.ID,
			&a.Title,
			&a.Description,
			&a.Category,
			&a.ThumbnailImage,
			&a.Technologies,
			&a.GithubURL,
			&a.ProjectURL,
			&a.Status,
		)
		if err != nil {
			return nil, err
		}
		projects = append(projects, a)
	}
	return projects, nil
}



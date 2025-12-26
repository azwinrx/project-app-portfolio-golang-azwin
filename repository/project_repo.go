package repository

import (
	"context"
	"project-app-portfolio-golang-azwin/database"
	"project-app-portfolio-golang-azwin/model"
)

type ProjectRepoInterface interface {
	GetAllProject(ctx context.Context) ([]model.Project, error)
}

type ProjectRepository struct {
	db database.PgxIface
}

func NewProjectRepository(db database.PgxIface) *ProjectRepository {
	return &ProjectRepository{db: db}
}

func (r *ProjectRepository) GetAllProject(ctx context.Context) ([]model.Project, error) {
	query := `SELECT id, title, description, detailed_description, category, client_name, project_url, github_url, thumbnail_image, start_date, end_date, status, technologies, is_featured, view_count, created_at, updated_at FROM projects ORDER BY is_featured DESC, created_at DESC;`
	rows, err := r.db.Query(ctx, query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var projects []model.Project
	for rows.Next() {
		var p model.Project
		err := rows.Scan(&p.ID, &p.Title, &p.Description, &p.DetailedDescription, &p.Category, &p.ClientName, &p.ProjectURL, &p.GithubURL, &p.ThumbnailImage, &p.StartDate, &p.EndDate, &p.Status, &p.Technologies, &p.IsFeatured, &p.ViewCount, &p.CreatedAt, &p.UpdatedAt)
		if err != nil {
			return nil, err
		}
		projects = append(projects, p)
	}
	if err = rows.Err(); err != nil {
		return nil, err
	}
	return projects, nil
}

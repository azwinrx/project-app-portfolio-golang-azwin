package repository

import (
	"go.uber.org/zap"
)

type Repository struct {

}

func NewRepository(db db.PgxIface, log *zap.Logger) *Repository {
	
}
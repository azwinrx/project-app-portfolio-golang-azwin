package database

import (
	"context"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgconn"
)

type PgxIface interface {
	QueryRow(ctx context.Context, sql string, args ...any) pgx.Row
	Query(ctx context.Context, sql string, args ...any) (pgx.Rows, error)
	Exec(ctx context.Context, sql string, args ...any) (pgconn.CommandTag, error)
}

func NewDatabase() (PgxIface, error) {
	connStr := "user=postgres password=8824001 dbname=portofolio-db sslmode=disable host=localhost"
	conn, err := pgx.Connect(context.Background(), connStr)
	return conn, err
}
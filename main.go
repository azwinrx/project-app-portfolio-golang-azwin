package main

import (
	"log"
	"net/http"
	"os"
	"project-app-portfolio-golang-azwin/database"
	"project-app-portfolio-golang-azwin/handler"
	"project-app-portfolio-golang-azwin/repository"
	"project-app-portfolio-golang-azwin/router"
	"project-app-portfolio-golang-azwin/service"

	"go.uber.org/zap"
)

func main() {
	// Create logs directory if not exists
	if err := os.MkdirAll("logs", 0755); err != nil {
		log.Fatal("Failed to create logs directory:", err)
	}

	// Initialize logger with file output
	config := zap.NewProductionConfig()
	config.OutputPaths = []string{"logs/app.log"}
	config.ErrorOutputPaths = []string{"logs/app.log"}
	logger, err := config.Build()
	if err != nil {
		log.Fatal("Failed to initialize logger:", err)
	}
	defer logger.Sync()

	// Initialize database
	db, err := database.NewDatabase()
	if err != nil {
		logger.Fatal("Failed to connect to database", zap.Error(err))
	}

	// Initialize repository
	repo := repository.NewProjectRepository(db)
	contactRepo := repository.NewContactRepository(db)

	// Initialize service
	svc := service.NewService(repo, contactRepo)

	// Initialize handler
	handl := handler.NewHandler(svc)

	// Initialize router
	r := router.NewRouter(svc, handl, logger)

	// public folder permission
	fs := http.FileServer(http.Dir("public"))
	r.Handle("/public/*", http.StripPrefix("/public/", fs))


	// Start server
	logger.Info("Server starting on port 8080")
	if err := http.ListenAndServe(":8080", r); err != nil {
		logger.Fatal("Server failed to start", zap.Error(err))
	}
}

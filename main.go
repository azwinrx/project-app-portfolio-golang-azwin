package main

import (
	"context"
	"log"
	"project-app-portfolio-golang-azwin/database"
)

func main() {
	// Inisialisasi database
	db , err := database.InitDB()
	// Validasi connection
	if err != nil {
		log.Fatalf("Failed connect to database: %v", err)
	}else{
		log.Println("Successfully connected to the database")
	}

	defer db.Close(context.Background())

	// Ping database
	err= db.Ping(context.Background())
	// Validasi ping
	if err != nil {
		log.Fatalf("Failed ping to database: %v", err)
	}else{
		log.Println("Successfully ping to the database")
	}
}
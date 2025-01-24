package database

import (
	"context"
	"log"
	"os"

	"github.com/jackc/pgx/v5/pgxpool"
)

var DB *pgxpool.Pool

// Connect initializes a PostgreSQL connection pool.
func Connect() {
	dsn := os.Getenv("DATABASE_URL")
	if dsn == "" {
		log.Fatal("DATABASE_URL environment variable is not set")
	}

	var err error
	DB, err = pgxpool.New(context.Background(), dsn)
	if err != nil {
		log.Fatalf("Unable to connect to database: %v\n", err)
	}
	log.Println("Connected to PostgreSQL database!")
}

// InitializeTables creates all required tables in the database.
func InitializeTables() {
	// Check if DB is initialized
	if DB == nil {
		log.Fatal("Database connection is not initialized")
	}

	createUuidExtension := `
	CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
	`

	createUsersTable := `
	CREATE TABLE IF NOT EXISTS users (
		id UUID PRIMARY KEY,
		name VARCHAR(100) NOT NULL,
		email VARCHAR(100) UNIQUE NOT NULL,
		password VARCHAR(255) NOT NULL,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);
	`
	createTodosTable := `
	CREATE TABLE IF NOT EXISTS todos (
		id UUID PRIMARY KEY,
		name VARCHAR(255) NOT NULL,
		completed BOOLEAN DEFAULT FALSE,
		author_id UUID REFERENCES users(id) ON DELETE CASCADE,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);`

	queries := []string{createUuidExtension, createUsersTable, createTodosTable}

	for _, query := range queries {
		_, err := DB.Exec(context.Background(), query)
		if err != nil {
			log.Fatalf("Failed to execute query: %v\n", err)
		}
	}

	log.Println("All tables initialized successfully!")
}

package main

import (
	"time"
	"todo-api/database"
	"todo-api/handlers"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func main() {
	// Connect to the database
	database.Connect()
	defer database.DB.Close()

	// initialize tables
	database.InitializeTables()

	// Initialize Gin
	router := gin.Default()

	router.Use(cors.New(cors.Config{
		AllowOrigins:     []string{"http://localhost:5173", "http://localhost:3000"}, // Allowed origins
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},        // Allowed methods
		AllowHeaders:     []string{"Origin", "Content-Type", "Authorization"},        // Allowed headers
		ExposeHeaders:    []string{"Content-Length"},                                 // Exposed headers
		AllowCredentials: true,                                                       // Allow credentials like cookies
		MaxAge:           12 * time.Hour,
	}))

	// Auth Routes
	authGroup := router.Group("/auth")
	{
		authGroup.POST("/login", handlers.Login)
		authGroup.POST("/register", handlers.Register)
	}

	// Todo Routes
	todoGroup := router.Group("/posts")
	{
		todoGroup.POST("/", handlers.CreateTodo)      // Create Post
		todoGroup.GET("/", handlers.GetAllTodos)      // Get All Posts
		todoGroup.GET("/:id", handlers.GetTodoByID)   // Get Post by ID
		todoGroup.PUT("/:id", handlers.UpdateTodo)    // Update Post
		todoGroup.DELETE("/:id", handlers.DeleteTodo) // Delete Post
	}

	// Start the server
	router.Run(":8080")
}

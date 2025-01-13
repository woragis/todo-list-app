package handlers

import (
	"net/http"

	"todo-backend/database"
	"todo-backend/models"

	"github.com/gin-gonic/gin"
)


func CreateTodo(c *gin.Context) {
	var todo models.Todo

	if err := c.ShouldBindJSON(&todo); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	query := `INSERT INTO todos (title, content, author_id) VALUES ($1, $2, $3) RETURNING id, created_at, updated_at`
	err := database.DB.QueryRow(
		c.Request.Context(),
		query,
		todo.Title,
		todo.Content,
		todo.AuthorID,
	).Scan(&todo.ID, &todo.CreatedAt, &todo.UpdatedAt)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create post"})
		return
	}

	c.JSON(http.StatusCreated, todo)
}


func GetAllTodos(c *gin.Context) {
	query := `SELECT id, title, content, author_id, created_at, updated_at FROM todos`
	rows, err := database.DB.Query(c.Request.Context(), query)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve todos"})
		return
	}
	defer rows.Close()

	var todos []models.Todo
	for rows.Next() {
		var todo models.Todo
		if err := rows.Scan(&todo.ID, &todo.Title, &todo.Content, &todo.AuthorID, &todo.CreatedAt, &todo.UpdatedAt); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to process todo data"})
			return
		}
		todos = append(todos, todo)
	}

	c.JSON(http.StatusOK, gin.H{"todos": todos})
}


func GetTodoByID(c *gin.Context) {
	id := c.Param("id")

	query := `SELECT id, title, content, author_id, created_at, updated_at FROM todos WHERE id=$1`
	row := database.DB.QueryRow(c.Request.Context(), query, id)

	var todo models.Todo
	err := row.Scan(&todo.ID, &todo.Title, &todo.Content, &todo.AuthorID, &todo.CreatedAt, &todo.UpdatedAt)

	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Todo not found"})
		return
	}

	c.JSON(http.StatusOK, todo)
}


func UpdateTodo(c *gin.Context) {
	id := c.Param("id")
	var todo models.Todo

	if err := c.ShouldBindJSON(&todo); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	query := `UPDATE todos SET title=$1, content=$2, author_id=$3, updated_at=CURRENT_TIMESTAMP WHERE id=$4 RETURNING id, created_at, updated_at`
	err := database.DB.QueryRow(
		c.Request.Context(),
		query,
		todo.Title,
		todo.Content,
		todo.AuthorID,
		id,
	).Scan(&todo.ID, &todo.CreatedAt, &todo.UpdatedAt)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update todo"})
		return
	}

	c.JSON(http.StatusOK, todo)
}


func DeleteTodo(c *gin.Context) {
	id := c.Param("id")

	query := `DELETE FROM todos WHERE id=$1`
	_, err := database.DB.Exec(c.Request.Context(), query, id)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete todo"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Todo deleted successfully"})
}

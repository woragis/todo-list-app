package handlers

import (
	"net/http"

	"todo-backend/database"
	"todo-backend/models"

	"github.com/gin-gonic/gin"
)


func GetAllTodos(c *gin.Context) {
	query := `SELECT id, name, author_id, created_at FROM todos`
	rows, err := database.DB.Query(c.Request.Context(), query)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve todos"})
		return
	}
	defer rows.Close()

	var todos []models.Todo
	for rows.Next() {
		var todo models.Todo
		if err := rows.Scan(&todo.ID, &todo.Name, &todo.AuthorID, &todo.CreatedAt); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to process todo data"})
			return
		}
		todos = append(todos, todo)
	}

	var response = gin.H{"todos": todos}

	c.JSON(http.StatusOK, response)
}


func GetTodoByID(c *gin.Context) {
	id := c.Param("id")

	query := `SELECT id, name, author_id, created_at FROM todos WHERE id=$1;`
	row := database.DB.QueryRow(c.Request.Context(), query, id)

	var todo models.Todo
	err := row.Scan(&todo.ID, &todo.Name, &todo.AuthorID, &todo.CreatedAt)

	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Todo not found"})
		return
	}

	var response = gin.H{"todo": todo}

	c.JSON(http.StatusOK, response)
}

func CreateTodo(c *gin.Context) {
	var todo models.Todo

	if err := c.ShouldBindJSON(&todo); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	query := `INSERT INTO todos (name, author_id) VALUES ($1, $2) RETURNING id, created_at;`
	err := database.DB.QueryRow(
		c.Request.Context(),
		query,
		todo.Name,
		todo.AuthorID,
	).Scan(&todo.ID, &todo.CreatedAt)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create post"})
		return
	}

	var response = gin.H{"todo": todo}

	c.JSON(http.StatusCreated, response)
}


func UpdateTodo(c *gin.Context) {
	id := c.Param("id")
	var todo models.Todo

	if err := c.ShouldBindJSON(&todo); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	query := `UPDATE todos SET name=$1, author_id=$2 WHERE id=$3 RETURNING id, created_at;`
	err := database.DB.QueryRow(
		c.Request.Context(),
		query,
		todo.Name,
		todo.AuthorID,
		id,
	).Scan(&todo.ID, &todo.CreatedAt)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update todo"})
		return
	}
	
	var response = gin.H{"todo": todo}

	c.JSON(http.StatusOK, response)
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

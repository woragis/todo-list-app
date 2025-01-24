package handlers

import (
	"net/http"

	"todo-backend/database"
	"todo-backend/models"
	"todo-backend/utils"

	"github.com/gin-gonic/gin"
)


func GetAllTodos(c *gin.Context) {
	query := `SELECT id, title, description, completed, author_id, created_at FROM todos;`
	rows, err := database.DB.Query(c.Request.Context(), query)

	if err != nil {
		utils.SendResponse(
			c,
			http.StatusInternalServerError,
			"Failed to retrieve todos",
			err,
			nil,
		)
		return
	}
	defer rows.Close()

	var todos []models.Todo
	for rows.Next() {
		var todo models.Todo
		if err := rows.Scan(&todo.ID, &todo.Title, &todo.Description, &todo.Completed, &todo.AuthorID, &todo.CreatedAt); err != nil {
			utils.SendResponse(
				c,
				http.StatusInternalServerError,
				"Failed to process todo data",
				err,
				nil,
			)
			return
		}
		todos = append(todos, todo)
	}

	// Ensure that if `todos` is nil, you send an empty array
	if todos == nil {
		todos = []models.Todo{}
	}

	utils.SendResponse(
		c,
		http.StatusOK,
		"Successfully retrieved todo",
		nil,
		todos,
	)
}


func GetTodoByID(c *gin.Context) {
	id := c.Param("id")

	query := `SELECT id, title, description, completed, author_id, created_at FROM todos WHERE id=$1;`
	row := database.DB.QueryRow(c.Request.Context(), query, id)

	var todo models.Todo

	err := row.Scan(&todo.ID, &todo.Title, &todo.Description, &todo.Completed, &todo.AuthorID, &todo.CreatedAt)

	if err != nil {
		utils.SendResponse(
			c,
			http.StatusNotFound,
			"Failed to retrieve todo: todo not found",
			err,
			nil,
		)
		return
	}

	utils.SendResponse(
		c,
		http.StatusOK,
		"Successfully retrieved todo",
		nil,
		todo,
	)
}

func CreateTodo(c *gin.Context) {
	var todo models.Todo

	if err := c.ShouldBindJSON(&todo); err != nil {
		utils.SendResponse(
			c,
			http.StatusBadRequest,
			"Failed to create todo: invalid input",
			err,
			nil,
		)
		return
	}

	query := `INSERT INTO todos (title, description, author_id) VALUES ($1, $2, $3) RETURNING id, completed, created_at;`
	err := database.DB.QueryRow(
		c.Request.Context(),
		query,
		todo.Title,
		todo.Description,
		todo.AuthorID,
	).Scan(&todo.ID, &todo.Completed, &todo.CreatedAt)

	if err != nil {
		utils.SendResponse(
			c,
			http.StatusInternalServerError,
			"Failed to create todo",
			err,
			nil,
		)
		return
	}

	utils.SendResponse(
		c,
		http.StatusCreated,
		"Successfully created todo",
		nil,
		todo,
	)
}


func UpdateTodo(c *gin.Context) {
	id := c.Param("id")
	var todo models.Todo

	if err := c.ShouldBindJSON(&todo); err != nil {
		utils.SendResponse(
			c,
			http.StatusBadRequest,
			"Could not update todo: invalid input",
			err,
			nil,
		)
		return
	}

	query := `UPDATE todos SET title=$1, description=$2, completed=$3, author_id=$4 WHERE id=$5 RETURNING created_at;`
	err := database.DB.QueryRow(
		c.Request.Context(),
		query,
		todo.Title,
		todo.Description,
		todo.Completed,
		todo.AuthorID,
		id,
	).Scan(&todo.ID, &todo.CreatedAt)

	if err != nil {
		utils.SendResponse(
			c,
			http.StatusInternalServerError,
			"Could not update todo",
			err,
			nil,
		)
		return
	}
	
	utils.SendResponse(
		c,
		http.StatusOK,
		"Successfully updated todo",
		nil,
		todo,
	)
}


func DeleteTodo(c *gin.Context) {
	id := c.Param("id")

	query := `DELETE FROM todos WHERE id=$1;`
	_, err := database.DB.Exec(c.Request.Context(), query, id)

	if err != nil {
		utils.SendResponse(c,
			http.StatusInternalServerError,
			"Could not delete todo",
			err,
			false,
		)
		return
	}

	utils.SendResponse(
		c,
		http.StatusOK,
		"Successfully deleted todo",
		nil,
		true,
	)
}

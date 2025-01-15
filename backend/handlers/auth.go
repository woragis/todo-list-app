package handlers

import (
	"context"
	"net/http"
	"time"

	"todo-backend/database"
	"todo-backend/models"
	"todo-backend/utils"

	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
)

func Login(c *gin.Context) {
	var user models.User

	var input struct {
		Email    string `json:"email" binding:"required,email"`
		Password string `json:"password" binding:"required"`
	}

	if err := c.ShouldBindJSON(&input); err != nil {
		utils.SendResponse(
			c,
			http.StatusBadRequest,
			"Failed to login: invalid input",
			err,
			nil,
		)
		return
	}

	query := `SELECT id, name, email, password, created_at, updated_at FROM users WHERE email = $1`
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	err := database.DB.QueryRow(ctx, query, input.Email).Scan(&user.ID, &user.Name, &user.Email, &user.Password, &user.CreatedAt, &user.UpdatedAt)
	if err != nil {
		utils.SendResponse(
			c,
			http.StatusUnauthorized,
			"Failed to login: invalid credentials",
			err,
			nil,
		)
		return
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(input.Password)); err != nil {
		utils.SendResponse(
			c,
			http.StatusUnauthorized,
			"Failed to login: invalid credentials",
			err,
			nil,
		)
		return
	}

	token, err := utils.GenerateJWT(int64(user.ID))
	if err != nil {
		utils.SendResponse(
			c,
			http.StatusInternalServerError,
			"Failed to login: failed to generate token",
			err,
			nil,
		)
		return
	}

	utils.SendResponse(
		c,
		http.StatusOK,
		"Successfully logged in",
		nil,
		map[string]interface{}{
			"token": token,
			"user": user,
		},
	)
}

func Register(c *gin.Context) {
	var user models.User
	var input struct {
		Name     string `json:"name" binding:"required"`
		Email    string `json:"email" binding:"required,email"`
		Password string `json:"password" binding:"required"`
	}
	user.Name = input.Name
	user.Email = input.Email
	user.Password = input.Password

	if err := c.ShouldBindJSON(&input); err != nil {
		utils.SendResponse(
			c,
			http.StatusBadRequest,
			"Failed to register: invalid input",
			err,
			nil,
		)
		return
	}

	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(input.Password), bcrypt.DefaultCost)
	if err != nil {
		utils.SendResponse(
			c,
			http.StatusInternalServerError,
			"Failed to register: failed to hash password",
			err,
			nil,
		)
		return
	}

	query := `INSERT INTO users (name, email, password) VALUES ($1, $2, $3) RETURNING id, created_at, updated_at`

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	err = database.DB.QueryRow(ctx, query, input.Name, input.Email, string(hashedPassword)).Scan(&user.ID, &user.CreatedAt, &user.UpdatedAt)
	if err != nil {
		utils.SendResponse(
			c,
			http.StatusInternalServerError,
			"Failed to register: failed to create user",
			err,
			nil,
		)
		return
	}
	token, err := utils.GenerateJWT(int64(user.ID))
	if err != nil {
		utils.SendResponse(
			c,
			http.StatusInternalServerError,
			"Failed to register: failed to generate token",
			err,
			nil,
		)
		return
	}

	utils.SendResponse(
		c,
		http.StatusCreated,
		"Successfully registered",
		nil,
		map[string]interface{}{
			"user": user,
			"token": token,
		},
	)
}

package tests

import (
	"bytes"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"todo-backend/handlers"
	"todo-backend/models"

	"github.com/gin-gonic/gin"
	"github.com/stretchr/testify/assert"
)

func setupAuthRouter() *gin.Engine {
	r := gin.Default()
	r.POST("/auth/login", handlers.Login)
	r.POST("/auth/register", handlers.Register)
	return r
}

func TestLogin(t *testing.T) {
	router := setupAuthRouter()

	loginRequest := models.User{
		Email: "jezreel@gmail.com",
		Password: "jezreel",
	}

	requestBody, _ := json.Marshal(loginRequest)

	w := httptest.NewRecorder()
	req, _ := http.NewRequest("POST", "/auth/login", bytes.NewBuffer(requestBody))
	req.Header.Set("Content-Type", "application/json")

	// Perform Request
	router.ServeHTTP(w, req)

	// assertions
	assert.Equal(t, http.StatusOK, w.Code)

	var response map[string]interface{}
	json.Unmarshal(w.Body.Bytes(), &response)

	assert.Equal(t, "Successfully logged in", response["message"])
	assert.NotEmpty(t, response["data"].(map[string]interface{})["token"])
}

func TestRegister(t *testing.T) {
	router := setupAuthRouter()

	loginRequest := models.User{
		Name: "jezreel",
		Email: "jezreel@gmail.com",
		Password: "jezreel",
	}

	requestBody, _ := json.Marshal(loginRequest)

	w := httptest.NewRecorder()
	req, _ := http.NewRequest("POST", "/auth/register", bytes.NewBuffer(requestBody))
	req.Header.Set("Content-Type", "application/json")

	// Perform Request
	router.ServeHTTP(w, req)

	// assertions
	assert.Equal(t, http.StatusOK, w.Code)

	var response map[string]interface{}
	json.Unmarshal(w.Body.Bytes(), &response)

	assert.Equal(t, "Successfully logged in", response["message"])
	assert.NotEmpty(t, response["data"].(map[string]interface{})["token"])
}
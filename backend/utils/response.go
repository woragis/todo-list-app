package utils

import (
	"todo-backend/models"

	"github.com/gin-gonic/gin"
)

func SendResponse(c *gin.Context, status int, message string, error interface{}, data interface{}) {
    c.JSON(status, models.Response{
        Status:  status,
        Message: message,
        Error:   error,
        Data:    data,
    })
}

package models

import (
	"time"

	"github.com/google/uuid"
)

type Todo struct {
	ID          uuid.UUID `json:"id"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
	Completed   bool      `json:"completed"`
	AuthorID    uuid.UUID `json:"author_id"`
	CreatedAt   time.Time `json:"created_at"`
}

package models

import (
	"time"

	"github.com/google/uuid"
)

type Todo struct {
	ID         uuid.UUID `json:"id"`
	Name       string    `json:"name"`
	Completed  bool      `json:"completed"`
	AuthorID   uuid.UUID `json:"author_id"`
	CreatedAt  time.Time `json:"created_at"`
}

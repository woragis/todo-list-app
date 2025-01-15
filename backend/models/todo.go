package models

import "time"

type Todo struct {
	ID         int       `json:"id"`
	Name       string    `json:"name"`
	Completed  bool      `json:"completed"`
	AuthorID   int       `json:"author_id"`
	CreatedAt  time.Time `json:"created_at"`
}

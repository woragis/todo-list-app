package models

import "time"

type Todo struct {
	ID         int       `json:"id"`
	Name       string    `json:"name"`
	AuthorID   int       `json:"author_id"`
	CreatedAt  time.Time `json:"created_at"`
}

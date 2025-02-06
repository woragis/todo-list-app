package tests

import (
	"container/list"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"testing"
	"todo-backend/constants"
	"todo-backend/models"

	"github.com/stretchr/testify/assert"
)

var realTodoList = list.New()
var testTodoList = list.New()
var baseUrl = constants.GetUrl()

func TestGetAllTodos(t *testing.T) {
	todosUrl := fmt.Sprintf("%s/todos/", baseUrl)
	resp, err := http.Get(todosUrl)
	if err != nil {
		t.Fatal("Error making GET request -- Get ALL Todos: ",err)
	}
	defer resp.Body.Close()

	assert.Equal(t, http.StatusOK, resp.StatusCode)

	body, err := io.ReadAll(resp.Body)
	assert.NoError(t, err)

	var response models.Response
	err = json.Unmarshal(body, &response)
	assert.NoError(t, err)

	todosBytes, err:=json.Marshal(response.Data)
	assert.NoError(t, err)

	var todosSlice []models.Todo
	err = json.Unmarshal(todosBytes, &todosSlice)
	assert.NoError(t, err)

	for _, todo := range todosSlice {
		realTodoList.PushBack(todo)
	}

	assert.Greater(t, realTodoList.Len(), 0, "Todos list should not be empty")
}

func TestGetTodoByID(t *testing.T) {
	// Iterando sobre os todos armazenados na lista global
	for e := realTodoList.Front(); e != nil; e = e.Next() {
		todo := e.Value.(models.Todo)
		url := fmt.Sprintf("%s/todos/%s", baseUrl, todo.ID)

		// Fazendo a requisição para buscar o todo por ID
		resp, err := http.Get(url)
		if err != nil {
			t.Fatalf("Error making GET request for ID %s: %v", todo.ID, err)
		}
		defer resp.Body.Close()

		// Verificando o status da resposta
		assert.Equal(t, http.StatusOK, resp.StatusCode)

		// Lendo o corpo da resposta
		body, err := io.ReadAll(resp.Body)
		assert.NoError(t, err)

		// Desserializando a resposta para `models.Response`
		var response models.Response
		err = json.Unmarshal(body, &response)
		assert.NoError(t, err)

		// Convertendo `response.Data` para `models.Todo`
		todoBytes, err := json.Marshal(response.Data)
		assert.NoError(t, err)

		var retrievedTodo models.Todo
		err = json.Unmarshal(todoBytes, &retrievedTodo)
		assert.NoError(t, err)

		// Verificando se o todo retornado é o mesmo que foi buscado
		assert.Equal(t, todo.ID, retrievedTodo.ID, "IDs do todo devem ser iguais")
		assert.Equal(t, todo.Title, retrievedTodo.Title, "Titles do todo devem ser iguais")
		assert.Equal(t, todo.Description, retrievedTodo.Description, "Descriptions do todo devem ser iguais")
		assert.Equal(t, todo.Completed, retrievedTodo.Completed, "Completed status do todo deve ser igual")
		assert.Equal(t, todo.AuthorID, retrievedTodo.AuthorID, "Author IDs do todo devem ser iguais")
	}
}

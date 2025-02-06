package tests

import (
	"bytes"
	"container/list"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"testing"
	"todo-backend/constants"
	"todo-backend/models"

	"github.com/google/uuid"
	"github.com/stretchr/testify/assert"
)

var baseUrl = constants.GetUrl()
var realTodoList = list.New()
var tempTodosList = list.New()

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



func TestCreateTodo(t *testing.T) {
	baseURL := constants.GetUrl()

	// Criando um novo todo fictício
	newTodo := models.Todo{
		Title:       "New Test Todo",
		Description: "This is a test todo",
		Completed:   false,
		AuthorID:    uuid.New(),
	}

	// Convertendo o todo para JSON
	todoJSON, err := json.Marshal(newTodo)
	assert.NoError(t, err)

	// Enviando a requisição POST
	resp, err := http.Post(baseURL, "application/json", bytes.NewBuffer(todoJSON))
	assert.NoError(t, err)
	defer resp.Body.Close()

	// Verificando o status da resposta
	assert.Equal(t, http.StatusCreated, resp.StatusCode)

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

	var createdTodo models.Todo
	err = json.Unmarshal(todoBytes, &createdTodo)
	assert.NoError(t, err)

	// Adicionando o todo criado à lista global
	tempTodosList.PushBack(createdTodo)
	fmt.Println("Created Todo:", createdTodo)
}

func TestUpdateTodo(t *testing.T) {
	baseURL := constants.GetUrl()

	// Pegando um todo salvo na lista global
	front := tempTodosList.Front()
	if front == nil {
		t.Skip("Skipping test: No todos available to update")
	}
	todo := front.Value.(models.Todo)

	// Modificando os valores do todo
	updatedTodo := todo
	updatedTodo.Title = "Updated Title"
	updatedTodo.Completed = true

	// Convertendo para JSON
	todoJSON, err := json.Marshal(updatedTodo)
	assert.NoError(t, err)

	// Criando a requisição PUT
	req, err := http.NewRequest(http.MethodPut, fmt.Sprintf("%s/%s", baseURL, todo.ID), bytes.NewBuffer(todoJSON))
	assert.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	// Enviando a requisição
	client := &http.Client{}
	resp, err := client.Do(req)
	assert.NoError(t, err)
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

	var updatedResponseTodo models.Todo
	err = json.Unmarshal(todoBytes, &updatedResponseTodo)
	assert.NoError(t, err)

	// Verificando se os valores foram atualizados corretamente
	assert.Equal(t, updatedTodo.Title, updatedResponseTodo.Title)
	assert.Equal(t, updatedTodo.Completed, updatedResponseTodo.Completed)
}

func TestDeleteTodo(t *testing.T) {
	baseURL := constants.GetUrl()

	// Pegando um todo salvo na lista global
	front := tempTodosList.Front()
	if front == nil {
		t.Skip("Skipping test: No todos available to delete")
	}
	todo := front.Value.(models.Todo)

	// Criando a requisição DELETE
	req, err := http.NewRequest(http.MethodDelete, fmt.Sprintf("%s/%s", baseURL, todo.ID), nil)
	assert.NoError(t, err)

	// Enviando a requisição
	client := &http.Client{}
	resp, err := client.Do(req)
	assert.NoError(t, err)
	defer resp.Body.Close()

	// Verificando o status da resposta
	assert.Equal(t, http.StatusNoContent, resp.StatusCode)

	// Removendo o todo da lista global
	tempTodosList.Remove(front)
}

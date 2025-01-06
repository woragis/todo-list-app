import { ChangeEvent, FormEvent, useState } from "react";
import "./App.css";

function App() {
  interface Todo {
    id: number;
    title: string;
    description: string;
    completed: boolean;
  }
  const [todos, setTodos] = useState<Todo[]>([]);
  const completeTodo = (id: Todo["id"]) => {
    setTodos((prevState) =>
      prevState.map((todo) =>
        todo.id === id ? { ...todo, completed: true } : todo
      )
    );
  };
  const deleteTodo = (id: Todo["id"]) => {
    setTodos((prevState) => prevState.filter((items) => items.id != id));
  };

  const completedTodosComponent = todos
    .filter((items) => items.completed === true)
    .map(({ id, title, description }) => {
      return (
        <div>
          <p>todo_id: {id}</p>
          <p>{title}</p>
          <p>{description}</p>
          <button className="complete" onClick={() => completeTodo(id)}>
            Complete todo
          </button>
          <button className="remove" onClick={() => deleteTodo(id)}>
            Remove todo
          </button>
        </div>
      );
    });
  const uncompletedTodosComponent = todos
    .filter((items) => items.completed === false)
    .map(({ id, title, description }) => {
      return (
        <div>
          <p>todo_id: {id}</p>
          <p>{title}</p>
          <p>{description}</p>
          <button className="complete" onClick={() => completeTodo(id)}>
            Complete todo
          </button>
          <button className="remove" onClick={() => deleteTodo(id)}>
            Remove todo
          </button>
        </div>
      );
    });

  const [newTodo, setNewTodo] = useState<Todo>({} as Todo);
  const handleNewTodoChange = (event: ChangeEvent<HTMLInputElement>) => {
    setNewTodo(
      (prevState) =>
        (prevState = { ...prevState, [event.target.name]: event.target.value })
    );
  };
  const addTodo = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    let new_todo_id = todos.length + 1;
    setTodos((prevState) => [
      ...prevState,
      { ...newTodo, id: new_todo_id, completed: false },
    ]);
    console.log(todos);
  };

  return (
    <>
      <div className="container">
        <h1>Todo App</h1>
        <div className="todo">
          <h2>Todo</h2>
          {uncompletedTodosComponent}
        </div>
        <div className="done">
          <h2>Done</h2>
          {completedTodosComponent}
        </div>
        <form className="add-todo" onSubmit={addTodo}>
          <label htmlFor="title">
            Title:
            <input
              type="text"
              name="title"
              id="title"
              value={newTodo.title}
              onChange={handleNewTodoChange}
            />
          </label>
          <br />
          <label htmlFor="description">
            Description:
            <input
              type="text"
              name="description"
              id="description"
              value={newTodo.description}
              onChange={handleNewTodoChange}
            />
          </label>
          <br />
          <button>Salvar</button>
        </form>
      </div>
    </>
  );
}

export default App;

import { ReduxStatus } from "./redux.types";

export interface Todo {
  id: number;
  title: string;
  content: string;
  author_id: string;
  created_at: string;
  updated_at: string;
}

interface DefaultResponse {}

export interface TodoResponse extends DefaultResponse {
  todo: Todo;
}

export interface TodosResponse extends DefaultResponse {
  todos: Todo[];
}

export interface TodosState {
  data: TodosResponse;
  currentTodo: Todo | undefined;
  status: ReduxStatus;
  error: string | null;
}

export interface PostTodoRequest {
  title: Todo["title"];
  content: Todo["content"];
  author_id: Todo["author_id"];
}

export interface PutTodoRequest extends PostTodoRequest {
  id: Todo["id"];
}

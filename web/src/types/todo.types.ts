export interface Todo {
  id: number;
  title: string;
  content: string;
  author_id: number;
  created_at: string;
  updated_at: string;
}

export interface TodosResponse {
  todos: Todo[];
}

export interface CreateTodo {
  title: string;
  content: string;
  author_id: number;
}

export interface UpdateTodo {
  id: number;
  title: string;
  content: string;
  author_id: number;
}

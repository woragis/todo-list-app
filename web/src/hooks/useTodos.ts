// src/hooks/useProducts.ts
import { useQuery } from "@tanstack/react-query";

// src/hooks/useProductMutations.ts
import { useMutation, useQueryClient } from "@tanstack/react-query";

import api from "../api/axiosInstance";
import {
  UpdateTodo,
  Todo,
  CreateTodo,
  TodosResponse,
  TodoResponse,
} from "../types/todo.types";

export const useTodos = () => {
  console.log("Starting to fetch todos");
  const { isLoading, error, data } = useQuery<TodosResponse>({
    queryKey: ["todos"],
    queryFn: async () => {
      console.log("Fetching todos/");
      const { data } = await api.get<TodosResponse>("todos/");
      console.log(data);
      return data;
    },
  });
  return { isLoading, error, data };
};

export const useTodoMutations = () => {
  const queryClient = useQueryClient();

  const addTodo = useMutation<
    TodoResponse,
    Error,
    Omit<Todo, "id" | "created_at" | "updated_at">
  >({
    mutationFn: async (newTodo: CreateTodo) => {
      const { data } = await api.post<TodoResponse>("/todos", newTodo);
      return data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: "todos" });
    },
  });

  const updateTodo = useMutation<TodoResponse, Error, Todo>({
    mutationFn: async (updatedTodo: UpdateTodo) => {
      const { data } = await api.put<TodoResponse>(
        `/todos/${updatedTodo.id}`,
        updatedTodo
      );
      return data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: "todos" });
    },
  });

  const deleteTodo = useMutation({
    mutationFn: async (id: number) => {
      const deleted = await api.delete<boolean>(`/todos/${id}`);
      return deleted;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: "todos" });
    },
  });

  return { addTodo, updateTodo, deleteTodo };
};

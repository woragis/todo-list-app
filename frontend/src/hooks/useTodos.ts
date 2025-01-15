// src/hooks/useProducts.ts
import { useQuery } from "@tanstack/react-query";

// src/hooks/useProductMutations.ts
import { useMutation, useQueryClient } from "@tanstack/react-query";

import api from "../api/axiosInstance";
import { PutTodoRequest, Todo, PostTodoRequest } from "../types/todos.types";
import {
  DeleteTodoResponseInterface,
  TodoResponseInterface,
  TodosResponseInterface,
} from "../types/axios.types";

export const useTodos = () => {
  console.log("Starting to fetch todos");
  const { isLoading, error, data } = useQuery<TodosResponseInterface>({
    queryKey: ["todos"],
    queryFn: async () => {
      console.log("Fetching todos/");
      const { data } = await api.get<TodosResponseInterface>("todos/");
      console.log(data);
      return data;
    },
  });
  return { isLoading, error, data };
};

export const useTodoMutations = () => {
  const queryClient = useQueryClient();

  const addTodo = useMutation<
    TodoResponseInterface,
    Error,
    Omit<Todo, "id" | "created_at" | "updated_at">
  >({
    mutationFn: async (newTodo: PostTodoRequest) => {
      const { data } = await api.post<TodoResponseInterface>("/todos", newTodo);
      return data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: "todos" });
    },
  });

  const updateTodo = useMutation<TodosResponseInterface, Error, Todo>({
    mutationFn: async (updatedTodo: PutTodoRequest) => {
      const { data } = await api.put<TodosResponseInterface>(
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
      const deleted = await api.delete<DeleteTodoResponseInterface>(
        `/todos/${id}`
      );
      return deleted;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: "todos" });
    },
  });

  return { addTodo, updateTodo, deleteTodo };
};

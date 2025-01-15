import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import Cookies from "js-cookie";
import { PostTodoRequest, Todo, TodosState } from "../../types/todos.types";
import { useTodoMutations, useTodos } from "../../hooks/useTodos";
import {
  TodoResponseInterface,
  TodosResponseInterface,
} from "../../types/axios.types";

const getInitialTodosState = (): TodosState => {
  const data = Cookies.get("todos_data") || JSON.stringify([]);

  return {
    data: JSON.parse(data),
    currentTodo: undefined,
    status: "idle",
    error: null,
  };
};

const initialState: TodosState = getInitialTodosState();

export const getTodos = createAsyncThunk(
  "todos/get",
  async (_, { rejectWithValue }) => {
    try {
      const { data, error, isLoading } = useTodos();
      localStorage.setItem("todos_data", JSON.stringify(data));
      return { data, error, isLoading };
    } catch (error: any) {
      return rejectWithValue(
        error.response?.data?.message || "Register failed"
      );
    }
  }
);

export const postTodo = createAsyncThunk(
  "todos/post",
  async (action: PostTodoRequest, { rejectWithValue }) => {
    try {
      const response = useTodoMutations().addTodo.mutate({
        name: action.name,
        author_id: action.author_id,
      });
      console.log("add todo resonse:", response);
      return response as TodoResponseInterface;
    } catch (error: any) {
      return rejectWithValue(
        error.response?.data?.message || "Register failed"
      );
    }
  }
);

const todosSlice = createSlice({
  name: "todos",
  initialState,
  reducers: {
    getTodo: (state, action) => {
      state.currentTodo = state.data.find((todo) => {
        return todo.id === (action.payload as Todo["id"]) ? todo : null;
      });
    },
  },
  extraReducers: (builder) => {
    builder
      // Get Todos cases
      .addCase(getTodos.pending, (state) => {
        state.status = "loading";
        state.error = null;
      })
      .addCase(getTodos.fulfilled, (state, action) => {
        state.status = "succeeded";
        state.data = action.payload.data
          ?.data as TodosResponseInterface["data"];
      })
      .addCase(getTodos.rejected, (state, action) => {
        state.data = {} as TodosResponseInterface["data"];
        state.status = "failed";
        state.error = (action.payload as string) || null;
      })

      // Post Todo cases
      .addCase(postTodo.pending, (state) => {
        state.status = "loading";
        state.error = null;
      })
      .addCase(postTodo.fulfilled, (state, action) => {
        state.status = "succeeded";
        state.data.push(action.payload.data);
        state.error = action.payload.error;
      })
      .addCase(postTodo.rejected, (state, action) => {
        state.status = "failed";
        state.error = (action.payload as string) || null;
      });
  },
});

export const { getTodo } = todosSlice.actions;
export default todosSlice.reducer;

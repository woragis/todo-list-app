import { useParams } from "react-router-dom";
import { useTodos } from "../../hooks/useTodos";

export const useTodoModel = () => {
  const { id } = useParams();
  const todos = useTodos().data?.todos;
  const todo = todos?.find((todo) => {
    return todo.id === Number(id) ? todo : {};
  });
  return { todo };
};

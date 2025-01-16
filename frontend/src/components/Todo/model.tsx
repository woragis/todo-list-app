import { useParams } from "react-router-dom";
import { useAppDispatch } from "../../features/hooks";
import { getTodo } from "../../features/slices/todosSlice";
import { RootState } from "../../features/store";
import { useSelector } from "react-redux";

export const useTodoModel = () => {
  const { id } = useParams();

  const dispatch = useAppDispatch();
  dispatch(getTodo(id));

  const todo = useSelector((state: RootState) => state.todos.currentTodo);

  return { todo };
};

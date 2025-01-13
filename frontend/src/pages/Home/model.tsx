import { useSelector } from "react-redux";
import { RootState } from "../../features/store";
import { useTodos } from "../../hooks/useTodos";

export const useHomeModel = () => {
  const todos = useTodos();

  const themeColors = useSelector((state: RootState) => state.theme.colors);
  const dividerColor = themeColors.background.contrast;

  return { todos, dividerColor };
};

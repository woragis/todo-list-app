import { useAppDispatch } from "../../features/hooks";
import { toggleTheme } from "../../features/slices/themeSlice";

export const useToggleThemeButtonModel = () => {
  const dispatch = useAppDispatch();
  const toggleCurrentTheme = () => dispatch(toggleTheme());

  return { toggleCurrentTheme };
};

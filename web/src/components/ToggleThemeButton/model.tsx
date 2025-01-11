import { useSelector } from "react-redux";
import { useAppDispatch } from "../../features/hooks";
import { toggleTheme } from "../../features/slices/themeSlice";
import { RootState } from "../../features/store";
import { ThemeButtonProps } from "../../types/themeButton.types";

export const useToggleThemeButtonModel = ({
  navbarColor,
  navbarBackgroundColor,
}: ThemeButtonProps) => {
  const dispatch = useAppDispatch();
  const toggleCurrentTheme = () => dispatch(toggleTheme());
  const isDarkMode = useSelector((state: RootState) => state.theme.isDarkMode);

  return { toggleCurrentTheme, isDarkMode, navbarColor, navbarBackgroundColor };
};

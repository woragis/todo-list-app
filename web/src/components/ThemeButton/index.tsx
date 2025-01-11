import { ThemeButtonProps } from "../../types/themeButton.types";
import { useThemeButtonModel } from "./model";
import { ThemeButtonView } from "./view";

const ThemeButton = (props: ThemeButtonProps) => {
  const model = useThemeButtonModel(props);

  return <ThemeButtonView {...model} />;
};

export default ThemeButton;

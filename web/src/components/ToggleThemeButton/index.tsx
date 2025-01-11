import { ThemeButtonProps } from "../../types/themeButton.types";
import { useToggleThemeButtonModel } from "./model";
import { ToggleThemeButtonView } from "./view";

const ToggleThemeButton = (props: ThemeButtonProps) => {
  const model = useToggleThemeButtonModel(props);

  return <ToggleThemeButtonView {...model} />;
};

export default ToggleThemeButton;

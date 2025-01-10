import { useToggleThemeButtonModel } from "./model";
import { ToggleThemeButtonView } from "./view";

const ToggleThemeButton = () => {
  const model = useToggleThemeButtonModel();

  return <ToggleThemeButtonView {...model} />;
};

export default ToggleThemeButton;

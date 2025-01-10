import { useToggleThemeButtonModel } from "./model";

export const ToggleThemeButtonView = ({
  toggleCurrentTheme,
}: ReturnType<typeof useToggleThemeButtonModel>) => {
  return <button onClick={toggleCurrentTheme}>Trocar de Tema</button>;
};

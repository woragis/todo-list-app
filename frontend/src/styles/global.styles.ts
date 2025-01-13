import { css } from "@emotion/react";
import { useSelector } from "react-redux";
import { RootState } from "../features/store";

export const GlobalStyles = () => {
  const theme = useSelector((state: RootState) => state.theme);

  return css`
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      text-decoration: none;
      list-style-type: none;
      font-family: "Roboto", sans-serif;
      font-style: normal;
      color: ${theme.colors.background.contrast};
      transition: background-color 500ms;
      transition: color 500ms;
      transition: fill 500ms;
      transition: border 500ms;
    }

    body {
      background-color: ${theme.colors.background.default};
    }
    nav {
      max-height: 130px;
    }

    a {
      color: white;
    }
  `;
};

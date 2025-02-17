import { useAppSelector } from '@/features/hooks'
import { css } from '@emotion/react'

const styles = () => {
  const theme = useAppSelector((state) => state.theme)

  return css`
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      text-decoration: none;
      list-style-type: none;
      font-family: 'Roboto', sans-serif;
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

    main {
      min-height: 100vh;
      padding-top: 100px;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    nav {
      max-height: 130px;
    }

    a {
      color: white;
    }
  `
}

export default styles

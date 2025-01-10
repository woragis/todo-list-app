import styled from "@emotion/styled";

export const StyledRegisterPage = styled.main`
  min-height: calc(100vh - 400px);
  display: flex;
  justify-content: center;
  align-items: center;
  margin: -20px auto 50px;
`;

export const RegisterForm = styled.form`
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  row-gap: 10px;
  padding: 20px;

  h1 {
    margin: -80px 0 25px;
  }

  input,
  button {
    width: 100%;
    border-radius: 5px;
    font-size: 1rem;
    padding: 8px 5px;
    border: none;
    outline: none;
  }

  input {
    background-color: white;
  }

  button {
    background-color: #dedede;
    font-weight: 500;
    padding: 10px 20px;
    &:hover {
      background-color: #ddd;
    }
    &:active {
      box-shadow: inset 5px 5px 10px gray, inset -5px -5px 10px white;
    }
  }
`;

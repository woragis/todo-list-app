import { ChangeEvent, FormEvent, useState } from "react";
import { LoginRequest } from "../../types/auth.types";
import { login } from "../../features/slices/authSlice";
import { useAppDispatch } from "../../features/hooks";
import { useSelector } from "react-redux";
import { RootState } from "../../features/store";
import { useNavigate } from "react-router-dom";
import { useTranslation } from "react-i18next";

export const useLoginModel = () => {
  const { t } = useTranslation();
  const dispatch = useAppDispatch();
  const navigate = useNavigate();
  const auth = useSelector((state: RootState) => state.auth);

  const [loginData, setLoginData] = useState<LoginRequest>({} as LoginRequest);

  const handleLoginChange = (event: ChangeEvent<HTMLInputElement>) => {
    setLoginData(
      (prevState) =>
        (prevState = { ...prevState, [event.target.name]: event.target.value })
    );
  };

  const handleLoginSubmit = (event: FormEvent) => {
    event.preventDefault();
    dispatch(login(loginData));
    navigate("/profile");
  };

  const textData = {
    title: t("login.title"),
    emailInput: t("login.inputs.email"),
    passwordInput: t("login.inputs.password"),
    formButton: t("login.inputs.button"),
  };

  return { textData, auth, loginData, handleLoginChange, handleLoginSubmit };
};

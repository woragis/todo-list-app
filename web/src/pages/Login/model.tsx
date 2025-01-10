import { ChangeEvent, FormEvent, useState } from "react";
import { LoginInterface } from "../../types/auth.types";
import { login } from "../../features/slices/authSlice";
import { useAppDispatch } from "../../features/hooks";
import { useSelector } from "react-redux";
import { RootState } from "../../features/store";

export const useLoginModel = () => {
  const dispatch = useAppDispatch();
  const auth = useSelector((state: RootState) => state.auth);

  const [loginData, setLoginData] = useState<LoginInterface>(
    {} as LoginInterface
  );

  const handleLoginChange = (event: ChangeEvent<HTMLInputElement>) => {
    setLoginData(
      (prevState) =>
        (prevState = { ...prevState, [event.target.name]: event.target.value })
    );
  };

  const handleLoginSubmit = (event: FormEvent) => {
    event.preventDefault();
    dispatch(login(loginData));
  };

  return { auth, loginData, handleLoginChange, handleLoginSubmit };
};

import { ChangeEvent, FormEvent, useState } from "react";
import { useAppDispatch } from "../../features/hooks";
import { useSelector } from "react-redux";
import { RootState } from "../../features/store";
import { register } from "../../features/slices/authSlice";
import { RegisterInterface } from "../../types/auth.types";

export const useRegisterModel = () => {
  const dispatch = useAppDispatch();
  const auth = useSelector((state: RootState) => state.auth);

  const [registerData, setRegisterData] = useState<RegisterInterface>(
    {} as RegisterInterface
  );

  const handleRegisterChange = (event: ChangeEvent<HTMLInputElement>) => {
    setRegisterData((prevState) => ({
      ...prevState,
      [event.target.name]: event.target.value,
    }));
  };

  const handleRegisterSubmit = (event: FormEvent) => {
    event.preventDefault();
    dispatch(register(registerData));
  };

  return { auth, registerData, handleRegisterChange, handleRegisterSubmit };
};

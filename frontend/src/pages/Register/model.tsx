import { ChangeEvent, FormEvent, useState } from "react";
import { useAppDispatch } from "../../features/hooks";
import { useSelector } from "react-redux";
import { RootState } from "../../features/store";
import { register } from "../../features/slices/authSlice";
import { RegisterRequest } from "../../types/auth.types";
import { useNavigate } from "react-router-dom";

export const useRegisterModel = () => {
  const dispatch = useAppDispatch();
  const navigate = useNavigate();
  const auth = useSelector((state: RootState) => state.auth);

  const [registerData, setRegisterData] = useState<RegisterRequest>(
    {} as RegisterRequest
  );

  const handleRegisterChange = (event: ChangeEvent<HTMLInputElement>) => {
    setRegisterData((prevState) => ({
      ...prevState,
      [event.target.name]: event.target.value,
    }));
  };

  const handleRegisterSubmit = (event: FormEvent) => {
    event.preventDefault();
    console.log("Register data:", registerData);
    dispatch(register(registerData));
    navigate("/profile");
  };

  return { auth, registerData, handleRegisterChange, handleRegisterSubmit };
};

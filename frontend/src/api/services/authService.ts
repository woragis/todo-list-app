import axiosInstance from "../../api/axiosInstance";
import {
  AuthResponseInterface,
  LoginRequestInterface,
  RegisterRequestInterface,
} from "../../types/axios.types";
import { API_ENDPOINTS } from "../endpoints";

export const loginService = async (user: LoginRequestInterface) => {
  const response = await axiosInstance.post<AuthResponseInterface>(
    API_ENDPOINTS.AUTH.LOGIN,
    user
  );
  return response.data as AuthResponseInterface;
};

export const registerService = async (user: RegisterRequestInterface) => {
  const response = await axiosInstance.post<AuthResponseInterface>(
    API_ENDPOINTS.AUTH.REGISTER,
    user
  );
  return response.data as AuthResponseInterface;
};

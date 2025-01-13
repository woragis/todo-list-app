import axiosInstance from "../../api/axiosInstance";
import {
  AuthResponse,
  LoginRequest,
  RegisterRequest,
} from "../../types/auth.types";
import { API_ENDPOINTS } from "../endpoints";

export const loginService = async (user: LoginRequest) => {
  const response = await axiosInstance.post(API_ENDPOINTS.AUTH.LOGIN, user);
  return response.data as AuthResponse;
};

export const registerService = async (user: RegisterRequest) => {
  const response = await axiosInstance.post(API_ENDPOINTS.AUTH.REGISTER, user);
  return response.data as AuthResponse;
};

import { API_ENDPOINTS_INTERFACE } from "../types/axios.types";

export const API_ENDPOINTS: API_ENDPOINTS_INTERFACE = {
  USERS: "users/",
  POSTS: "posts/",
  AUTH: {
    LOGIN: "auth/login",
    REGISTER: "auth/register",
    RECOVER_PASSWORD: "auth/recover-password",
    VERIFY: "auth/verify",
  },
};

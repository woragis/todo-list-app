import { ReduxStatus } from "./redux.types";

export interface AuthUser {
  id: number;
  first_name: string;
  last_name: string;
  email: string;
  role: string;
  blog_role: string;
  store_role: string;
  youtube_role: string;
  fanfic_role: string;
  profile_picture?: string;
  phone_number?: string;
  is_verified: boolean;
  last_login?: string;
  created_at: string;
  updated_at: string;
}

export interface AuthState {
  user: AuthUser | null;
  loggedIn: boolean;
  token: string;
  status: ReduxStatus;
  error: string | null;
}

export interface RegisterInterface {
  name: string;
  email: string;
  password: string;
}

export interface LoginInterface {
  email: string;
  password: string;
}

export interface AuthResponse {
  token: string;
  user: AuthUser;
}

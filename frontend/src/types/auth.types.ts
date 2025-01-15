import { ReduxStatus } from "./redux.types";

export interface AuthUser {
  id: number;
  name: string;
  email: string;
  password: string;
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

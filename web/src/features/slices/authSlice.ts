import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import {
  AuthState,
  LoginInterface,
  RegisterInterface,
} from "../../types/auth.types";
import { loginService, registerService } from "../../api/services/authService";
import Cookies from "js-cookie";

const getInitialAuthState = (): AuthState => {
  const token = Cookies.get("auth_token") || "";
  const user = localStorage.getItem("auth_user");

  return {
    user: user ? JSON.parse(user) : null,
    token,
    loggedIn: !token,
    status: "idle",
    error: null,
  };
};

const initialState: AuthState = getInitialAuthState();

export const login = createAsyncThunk(
  "auth/login",
  async (credentials: LoginInterface, { rejectWithValue }) => {
    try {
      const { token, user } = await loginService(credentials);
      Cookies.set("auth_token", token, { expires: 7 });
      localStorage.setItem("auth_user", JSON.stringify(user));
      return { token, user };
    } catch (error: any) {
      return rejectWithValue(error.response?.data?.message || "Login failed");
    }
  }
);

export const register = createAsyncThunk(
  "auth/register",
  async (details: RegisterInterface, { rejectWithValue }) => {
    try {
      const { token, user } = await registerService(details);
      Cookies.set("auth_token", token, { expires: 7 });
      localStorage.setItem("auth_user", JSON.stringify(user));
      return { token, user };
    } catch (error: any) {
      return rejectWithValue(
        error.response?.data?.message || "Register failed"
      );
    }
  }
);

const authSlice = createSlice({
  name: "auth",
  initialState,
  reducers: {
    logout: (state) => {
      Cookies.remove("auth_token");
      localStorage.removeItem("auth_user");

      state.user = null;
      state.token = "";
      state.loggedIn = false;
    },
  },
  extraReducers: (builder) => {
    builder

      // Login cases
      .addCase(login.pending, (state) => {
        state.status = "loading";
        state.error = null;
      })
      .addCase(login.fulfilled, (state, action) => {
        state.status = "succeeded";
        state.user = action.payload.user;
        state.token = action.payload.token;
        state.loggedIn = true;
      })
      .addCase(login.rejected, (state, action) => {
        state.status = "failed";
        state.error = (action.payload as string) || null;
      })

      // Register cases
      .addCase(register.pending, (state) => {
        state.status = "loading";
        state.error = null;
      })
      .addCase(register.fulfilled, (state, action) => {
        state.status = "succeeded";
        state.user = action.payload.user;
        state.token = action.payload.token;
        state.loggedIn = true;
      })
      .addCase(register.rejected, (state, action) => {
        state.status = "failed";
        state.error = (action.payload as string) || null;
      });
  },
});

export const { logout } = authSlice.actions;
export default authSlice.reducer;

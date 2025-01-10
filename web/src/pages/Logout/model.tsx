import { useNavigate } from "react-router-dom";
import { useAppDispatch } from "../../features/hooks";
import { logout } from "../../features/slices/authSlice";

export const useLogoutModel = () => {
  const dispatch = useAppDispatch();
  const navigate = useNavigate();
  const useLogout = () => {
    dispatch(logout());
    navigate("/");
  };

  return { useLogout };
};

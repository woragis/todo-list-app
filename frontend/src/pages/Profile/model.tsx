import { useSelector } from "react-redux";
import { RootState } from "../../features/store";

export const useProfileModel = () => {
  const user = useSelector((state: RootState) => state.auth.user);

  return { user };
};

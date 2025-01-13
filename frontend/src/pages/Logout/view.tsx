import { useEffect } from "react";
import { useLogoutModel } from "./model";

export const LogoutView = ({
  useLogout,
}: ReturnType<typeof useLogoutModel>) => {
  useEffect(() => {
    useLogout();
  }, []);

  return <div>Logging out</div>;
};

import { useLogoutModel } from "./model";
import { LogoutView } from "./view";

const Logout = () => {
  const model = useLogoutModel();

  return <LogoutView {...model} />;
};

export default Logout;

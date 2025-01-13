import { useNavbarModel } from "./model";
import { NavbarView } from "./view";

const Navbar = () => {
  const model = useNavbarModel();

  return <NavbarView {...model} />;
};

export default Navbar;

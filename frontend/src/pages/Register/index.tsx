import HeroSection from "../../components/HeroSection";
import { useRegisterModel } from "./model";
import { RegisterView } from "./view";

const Register = () => {
  const model = useRegisterModel();

  return <HeroSection children={<RegisterView {...model} />} />;
};

export default Register;

import HeroSection from "../../components/HeroSection";
import { useLoginModel } from "./model";
import { LoginView } from "./view";

const Login = () => {
  const model = useLoginModel();

  return <HeroSection children={<LoginView {...model} />} />;
};

export default Login;

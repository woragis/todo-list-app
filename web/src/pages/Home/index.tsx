import HeroSection from "../../components/HeroSection";
import { useHomeModel } from "./model";
import { HomeView } from "./view";

const Home = () => {
  const model = useHomeModel();

  return <HeroSection children={<HomeView {...model} />} />;
};

export default Home;

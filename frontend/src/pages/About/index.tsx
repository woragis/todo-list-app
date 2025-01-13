import HeroSection from "../../components/HeroSection";
import { useAboutModel } from "./model";
import { AboutView } from "./view";

const About = () => {
  const model = useAboutModel();

  return <HeroSection children={<AboutView {...model} />} />;
};

export default About;

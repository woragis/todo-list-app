import { useHeroSectionContainerModel } from "./model";
import { HeroSectionView } from "./view";

const HeroSection = ({ children }: { children: JSX.Element }) => {
  const model = useHeroSectionContainerModel(children);

  return <HeroSectionView {...model} />;
};

export default HeroSection;

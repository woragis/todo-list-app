import { useHeroSectionContainerModel } from "./model";
import { StyledHeroSection } from "./styles";

export const HeroSectionView = ({
  children,
}: ReturnType<typeof useHeroSectionContainerModel>) => {
  return <StyledHeroSection>{children}</StyledHeroSection>;
};

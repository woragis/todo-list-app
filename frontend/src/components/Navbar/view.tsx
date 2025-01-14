import LanguageSwitcher from "../LanguageSwitcher";
import ThemeButton from "../ThemeButton";
import { useNavbarModel } from "./model";
import {
  NavbarInvisibleContainer,
  NavbarLogo,
  NavLink,
  NavLinkItem,
  NavLinksContainer,
  StyledNavbar,
} from "./styles";

export const NavbarView = ({
  navLinks,
  authLinks,
  themeColors,
  navLogo,
}: ReturnType<typeof useNavbarModel>) => {
  const navLinksComponent = navLinks.map(({ title, path }) => {
    return (
      <NavLinkItem key={title + "_nav_link"}>
        <NavLink to={path}>{title}</NavLink>
      </NavLinkItem>
    );
  });
  const authLinksComponent = authLinks.map(({ title, path }) => {
    return (
      <NavLinkItem key={title + "_nav_link"}>
        <NavLink to={path}>{title}</NavLink>
      </NavLinkItem>
    );
  });

  window.addEventListener("scroll", () => {
    let header = document.querySelector(".navbar");
    header?.classList.toggle("sticky", window.scrollY > 0);
  });

  return (
    <NavbarInvisibleContainer>
      <StyledNavbar
        className="navbar"
        color={themeColors.navbar.background}
        backgroundColor={themeColors.navbar.contrast}
        invertedColor={themeColors.navbar.contrast}
        invertedBackgroundColor={themeColors.navbar.background}
      >
        <NavbarLogo src={navLogo} />
        <NavLinksContainer>
          {navLinksComponent}
          {authLinksComponent}
          <LanguageSwitcher />
          <ThemeButton
            navbarColor={themeColors.navbar.background}
            navbarBackgroundColor={themeColors.navbar.contrast}
          />
        </NavLinksContainer>
      </StyledNavbar>
    </NavbarInvisibleContainer>
  );
};

import LanguageSwitcher from "../LanguageSwitcher";
import ToggleThemeButton from "../ToggleThemeButton";
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
        color={themeColors.secondary.main}
        backgroundColor={themeColors.background.default}
        invertedColor={themeColors.background.default}
        invertedBackgroundColor={themeColors.secondary.main}
      >
        <NavbarLogo src={navLogo} />
        <NavLinksContainer>
          {navLinksComponent}
          {authLinksComponent}
          <LanguageSwitcher />
          <details>
            <summary>Theme</summary>
            <ToggleThemeButton />
          </details>
        </NavLinksContainer>
      </StyledNavbar>
    </NavbarInvisibleContainer>
  );
};

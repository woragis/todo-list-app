import { useSelector } from "react-redux";
import { NavPages, Pages } from "../../types/router.types";
import { RootState } from "../../features/store";
import { useTranslation } from "react-i18next";

export const useNavbarModel = () => {
  const { t } = useTranslation();

  const auth = useSelector((state: RootState) => state.auth);
  const themeColors = useSelector((state: RootState) => state.theme.colors);

  const navLinks: NavPages[] = [
    { title: t(Pages.Home), path: "" as Pages },
    { title: t(Pages.About), path: Pages.About },
  ];

  const unloggedLinks: NavPages[] = [
    { title: t(Pages.Login), path: Pages.Login },
    { title: t(Pages.Register), path: Pages.Register },
  ];
  const loggedLinks: NavPages[] = [
    { title: t(Pages.Profile), path: Pages.Profile },
    { title: t(Pages.Logout), path: Pages.Logout },
  ];
  const authLinks = auth.loggedIn ? loggedLinks : unloggedLinks;

  const navLogo = "";

  return { navLinks, authLinks, themeColors, navLogo };
};

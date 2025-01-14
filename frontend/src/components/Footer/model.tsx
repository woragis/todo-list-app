import { useSelector } from "react-redux";
import { RootState } from "../../features/store";
import { useTranslation } from "react-i18next";
import {
  FaFacebook,
  FaGithub,
  FaInstagram,
  FaLinkedin,
  FaTwitter,
  FaYoutube,
} from "react-icons/fa6";
import { FooterLinks, socialMediaLinks } from "../../types/footer.types";

export const useFooterModel = () => {
  const footerColors = useSelector(
    (state: RootState) => state.theme.colors.footer
  );

  const { t } = useTranslation();

  const brandName: string = t("brand");

  const menuLinks: FooterLinks[] = [
    { title: t("home"), path: "/" },
    { title: t("about.title"), path: "about/" },
    { title: t("contact.title"), path: "contact/" },
    { title: t("blog"), path: "blog/" },
    { title: t("pricing"), path: "pricing/" },
  ];

  const mediaLinks: socialMediaLinks[] = [
    { element: <FaFacebook />, path: "http://facebook.com/" },
    { element: <FaTwitter />, path: "http://twitter.com/" },
    {
      element: <FaInstagram />,
      path: "http://instagram.com/y.jezreel.andrade",
    },
    { element: <FaYoutube />, path: "http://youtube.com/subscriptions" },
    { element: <FaLinkedin />, path: "http://linkedin.com/in/jezreel-andrade" },
    { element: <FaGithub />, path: "http://github.com/woragis" },
  ];

  return {
    footerColors,
    brandName,
    menuLinks,
    mediaLinks,
  };
};

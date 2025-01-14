import { useTranslation } from "react-i18next";

export const useAboutModel = () => {
  const { t } = useTranslation();

  const aboutMainTitle = t("about.title");
  const aboutMainText = t("about.about");

  return { aboutMainTitle, aboutMainText };
};

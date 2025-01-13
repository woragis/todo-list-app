import i18n from "i18next";
import { initReactI18next } from "react-i18next";
import LanguageDetector from "i18next-browser-languagedetector";
import en from "./en.json"; // English translations
import es from "./es.json"; // Spanish translations
import pt from "./pt.json"; // Portuguese translations
// import de from "./de.json"; // German translations
// import ru from "./ru.json"; // Russiantranslations

i18n
  .use(LanguageDetector) // Automatically detects the user's language
  .use(initReactI18next) // Initializes react-i18next
  .init({
    resources: {
      en: { translation: en },
      es: { translation: es },
      pt: { translation: pt },
      //   de: { translation: de },
      //   ru: { translation: ru },
    },
    fallbackLng: "en", // Fallback language if the detected language is not available
    interpolation: {
      escapeValue: false, // React already escapes values
    },
    react: {
      useSuspense: false, // Disable Suspense for loading translations
    },
  });

export default i18n;

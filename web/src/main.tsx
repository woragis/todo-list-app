import { createRoot } from "react-dom/client";
import App from "./App.tsx";
import { Provider } from "react-redux";
import { store } from "./features/store.ts";
import { I18nextProvider } from "react-i18next";
import i18n from "./locales/i18n.ts";

createRoot(document.getElementById("root")!).render(
  <Provider store={store}>
    <I18nextProvider i18n={i18n}>
      <App />
    </I18nextProvider>
  </Provider>
);

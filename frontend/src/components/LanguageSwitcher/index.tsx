import { useLanguageSwitcherModel } from "./model";
import { LanguageSwitcherView } from "./view";

const LanguageSwitcher = () => {
  const model = useLanguageSwitcherModel();

  return <LanguageSwitcherView {...model} />;
};

export default LanguageSwitcher;

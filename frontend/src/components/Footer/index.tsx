import { useFooterModel } from "./model";
import { FooterView } from "./view";

const Footer = () => {
  const model = useFooterModel();

  return <FooterView {...model} />;
};

export default Footer;

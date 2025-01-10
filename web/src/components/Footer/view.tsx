import { useFooterModel } from "./model";
import {
  FooterContact,
  FooterContent,
  FooterCopyright,
  FooterLanguages,
  FooterLinks,
  FooterPolicy,
  StyledFooter,
} from "./styles";

export const FooterView = ({
  contactData,
  handleContactChange,
  handleContactSubmit,
}: ReturnType<typeof useFooterModel>) => {
  return (
    <StyledFooter>
      <FooterContent>
        <FooterLinks></FooterLinks>
        <FooterLanguages></FooterLanguages>
        <FooterPolicy>Footer</FooterPolicy>
        <FooterContact onSubmit={handleContactSubmit}>
          <input
            type="text"
            name="title"
            id="title"
            value={contactData.title}
            onChange={handleContactChange}
          />
          <input
            type="text"
            name="email"
            id="email"
            value={contactData.email}
            onChange={handleContactChange}
          />
          <input
            type="text"
            name="body"
            id="body"
            value={contactData.body}
            onChange={handleContactChange}
          />
          <input
            type="text"
            name="tel_number"
            id="tel_number"
            value={contactData.tel_number}
            onChange={handleContactChange}
          />
          <button>Send</button>
        </FooterContact>
      </FooterContent>
      <FooterCopyright>Jezreel de Andrade - 2024 &copy;</FooterCopyright>
    </StyledFooter>
  );
};

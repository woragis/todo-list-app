import {
  FaFacebook,
  FaInstagram,
  FaLinkedin,
  FaTumblr,
  FaTwitter,
  FaYoutube,
} from "react-icons/fa6";
import { useFooterModel } from "./model";
import {
  FooterBrand,
  FooterContact,
  FooterContainer,
  FooterContent,
  FooterCopyright,
  FooterLanguages,
  FooterLink,
  FooterLinks,
  FooterListItems,
  FooterMediaIcons,
  FooterMenu,
  FooterPolicy,
  StyledFooter,
} from "./styles";

export const FooterView = ({
  contactData,
  handleContactChange,
  handleContactSubmit,
}: ReturnType<typeof useFooterModel>) => {
  if (false) {
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
  } else {
    return (
      <StyledFooter>
        <FooterContainer>
          <div className="col1">
            <FooterBrand to="">Brand</FooterBrand>
          </div>
          <div className="col2">
            <FooterMenu className="menu">
              <FooterListItems>
                <FooterLink to="">Home</FooterLink>
              </FooterListItems>
              <FooterListItems>
                <FooterLink to="">About</FooterLink>
              </FooterListItems>
              <FooterListItems>
                <FooterLink to="">Contact</FooterLink>
              </FooterListItems>
              <FooterListItems>
                <FooterLink to="">Blog</FooterLink>
              </FooterListItems>
              <FooterListItems>
                <FooterLink to="">Services</FooterLink>
              </FooterListItems>
              <FooterListItems>
                <FooterLink to="">Pricing</FooterLink>
              </FooterListItems>
            </FooterMenu>
          </div>
          <div className="col3">
            <FooterMediaIcons className="media-icons">
              <FooterLink to="">
                <FaFacebook />
              </FooterLink>
              <FooterLink to="">
                <FaTwitter />
              </FooterLink>
              <FooterLink to="">
                <FaInstagram />
              </FooterLink>
              <FooterLink to="">
                <FaYoutube />
              </FooterLink>
              <FooterLink to="">
                <FaLinkedin />
              </FooterLink>
              <FooterLink to="">
                <FaTumblr />
              </FooterLink>
            </FooterMediaIcons>
          </div>
        </FooterContainer>
      </StyledFooter>
    );
  }
};

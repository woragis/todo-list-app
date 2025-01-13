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
  FooterContainer,
  FooterLink,
  FooterListItem,
  FooterMediaIcons,
  FooterMenu,
  StyledFooter,
} from "./styles";

export const FooterView = ({
  footerColors,
}: ReturnType<typeof useFooterModel>) => {
  return (
    <StyledFooter
      color={footerColors.contrast}
      backgroundColor={footerColors.background}
      weakColor={footerColors.weak}
    >
      <FooterContainer>
        <div className="col1">
          <FooterBrand to="">Brand</FooterBrand>
        </div>
        <div className="col2">
          <FooterMenu className="menu">
            <FooterListItem>
              <FooterLink to="">Home</FooterLink>
            </FooterListItem>
            <FooterListItem>
              <FooterLink to="">About</FooterLink>
            </FooterListItem>
            <FooterListItem>
              <FooterLink to="">Contact</FooterLink>
            </FooterListItem>
            <FooterListItem>
              <FooterLink to="">Blog</FooterLink>
            </FooterListItem>
            <FooterListItem>
              <FooterLink to="">Services</FooterLink>
            </FooterListItem>
            <FooterListItem>
              <FooterLink to="">Pricing</FooterLink>
            </FooterListItem>
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
};

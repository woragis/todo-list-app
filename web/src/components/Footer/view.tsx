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
  FooterListItems,
  FooterMediaIcons,
  FooterMenu,
  StyledFooter,
} from "./styles";

export const FooterView = ({}: ReturnType<typeof useFooterModel>) => {
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
};

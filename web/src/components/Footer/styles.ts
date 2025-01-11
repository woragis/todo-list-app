import styled from "@emotion/styled";
import { Link } from "react-router-dom";

export const StyledFooter = styled.footer`
  color: #fff;
  background: #121315;
  padding: 50px;
  border: 1px solid red;
  text-align: center;

  p {
    color: #ccc;
    max-width: 25em;
    font-size: 0.9em;
    line-height: 23px;
  }
  a {
    color: #fff;
    text-decoration: none;
  }

  h4 {
    margin-bottom: 1em;
    text-transform: uppercase;
  }
`;

export const FooterMediaIcons = styled.ul`
  margin: 1.5em 0;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 0.5em 0;
  gap: 0.5em;
  li {
    display: inline-block;
  }
  a {
    font-size: 1.1em;
    width: 2em;
    height: 2em;
    border: 1px #fff solid;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: 300ms;

    &:hover {
      background-color: #fff;
      svg {
        fill: #111;
      }
    }
  }
`;

export const FooterBrand = styled(Link)`
  display: block;
  font-size: 1.8em;
  font-weight: 600;
  margin-bottom: 1em;
  margin: 0;
`;

export const FooterListItems = styled.li`
  display: inline-block;
  margin: 1em;
  text-align: center;
`;

export const FooterMenu = styled.ul`
  list-style-type: none;
  a {
    transition: 300ms;
    font-weight: 300;
    color: #ccc;
    &:hover {
      color: #fff;
      text-decoration: none;
    }
  }
`;

export const FooterParagraph = styled.p`
  color: #ccc;
  max-width: 25em;
  font-size: 0.9em;
  line-height: 23px;
`;

export const FooterLink = styled(Link)`
  color: #fff;
  text-decoration: none;
`;

export const FooterTitle = styled.h4`
  margin-bottom: 1em;
  text-transform: uppercase;
`;

export const FooterContainer = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  text-align: center;
  gap: 2em;
  max-width: 1200px;
  margin: 0 auto;
  padding: 2em;
`;

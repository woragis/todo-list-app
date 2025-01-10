import styled from "@emotion/styled";

export const StyledFooter = styled.footer`
  background-color: #181818;
  padding: 50px 50px 80px;
  position: relative;
  height: 400px;
`;

export const FooterContent = styled.article`
  display: grid;
  justify-items: center;
  align-content: center;
  grid-template-columns: repeat(4, 1fr);
  height: 100%;
  font-size: 2rem;
`;

export const FooterLinks = styled.ul``;
export const FooterLanguages = styled.ul``;
export const FooterPolicy = styled.article``;
export const FooterContact = styled.form``;

export const FooterCopyright = styled.p`
  color: white;
  font-weight: 600;
  font-size: 12px;
  letter-spacing: 4px;
  position: absolute;
  left: 50%;
  bottom: 0;
  transform: translateX(-50%);
  height: 50px;
  width: 100%;
  background-color: #111;
  display: flex;
  justify-content: center;
  align-items: center;
  border-top: 3px solid white;
`;

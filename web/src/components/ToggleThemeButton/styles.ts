import styled from "@emotion/styled";

export const ThemeButtonContainer = styled.div`
  /* font-size: 3em; */
  height: 30px;
  width: 100px;
`;

export const InvisibleInput = styled.input`
  transition: 500ms;
  display: none;

  &[type="checkbox"]:checked + .display {
    background: #2c2c2f;
  }
  &[type="checkbox"]:checked + .display label {
    background: #1f1f21;
    box-shadow: 10px 10px 30px rgba(0, 0, 0, 0.5) inset;
  }
  &[type="checkbox"]:checked + .display label .circle {
    left: 100%;
    transform: translate(-110%, -50%);
    background: #2c2c2f;
    box-shadow: 10px 10px 20px rgba(0, 0, 0, 0.5),
      -10px -10px 30px rgba(0, 0, 0, 0.5) inset;
  }
  &[type="checkbox"]:checked + .display label .circle .sun {
    margin-top: 150%;
    opacity: 0;
  }
  &[type="checkbox"]:checked + .display label .circle .moon {
    margin-top: 0%;
    opacity: 1;
  }
`;
export const DisplayedDiv = styled.div`
  * {
    transition: 500ms;
  }

  width: 100%;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: white;
`;
export const ThemeLabel = styled.label`
  width: 400px;
  height: 200px;
  border-radius: 999px;
  background: #f3f3f3;
  box-shadow: 10px 10px 30px rgba(0, 0, 0, 0.05) inset;
  cursor: pointer;
  position: relative;

  &:active .circle {
    width: 200px;
  }
`;
export const ThemeCircle = styled.div`
  width: 160px;
  height: 160px;
  border-radius: 99px;
  background: white;
  box-shadow: 10px 10px 20px rgba(0, 0, 0, 0.05),
    -10px -10px 30px rgba(0, 0, 0, 0.05) inset;
  position: absolute;
  top: 50%;
  left: 0%;
  transform: translate(10%, -50%);
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
`;
// export const ThemeSvg = styled.svg``;

export const SunSvg = styled.svg`
  width: 80px;
  position: absolute;
  color: #ffd600;
  margin-top: 0%;
  opacity: 1;
`;
export const MoonSvg = styled.svg`
  width: 80px;
  position: absolute;
  margin-top: -150%;
  color: white;
  opacity: 0;
`;

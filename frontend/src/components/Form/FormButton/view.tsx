import { useFormButtonModel } from "./model";
import { StyledFormButton } from "./styles";

export const FormButtonView = ({
  children,
}: ReturnType<typeof useFormButtonModel>) => {
  return <StyledFormButton>{children}</StyledFormButton>;
};

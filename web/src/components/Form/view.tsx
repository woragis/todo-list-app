import { useFormModel } from "./model";
import { StyledForm } from "./styles";

export const FormView = ({
  children,
  onSubmit,
}: ReturnType<typeof useFormModel>) => {
  return <StyledForm onSubmit={onSubmit}>{children}</StyledForm>;
};

import { useFormButtonModel } from "./model";
import { FormButtonView } from "./view";

const FormButton = ({ children }: { children: string }) => {
  const model = useFormButtonModel(children);

  return <FormButtonView {...model} />;
};

export default FormButton;

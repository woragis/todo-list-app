import { useFormButtonModel } from "./model";
import { FormButtonView } from "./view";

const FormButtom = ({ children }: { children: string }) => {
  const model = useFormButtonModel(children);

  return <FormButtonView {...model} />;
};

export default FormButtom;

import { FormEvent } from "react";
import { useFormModel } from "./model";
import { FormView } from "./view";

const Form = ({
  children,
  onSubmit,
}: {
  children: any;
  onSubmit: (event: FormEvent) => void;
}) => {
  const model = useFormModel(children, onSubmit);

  return <FormView {...model} />;
};

export default Form;

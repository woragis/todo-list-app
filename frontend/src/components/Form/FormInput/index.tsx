import { ChangeEvent } from "react";
import { useFormInputModel } from "./model";
import { FormInputView } from "./view";

const FormInput = ({
  id,
  name,
  type,
  placeholder,
  value,
  onChange,
}: {
  id: string;
  name: string;
  type: string;
  placeholder: string;
  value: string;
  onChange: (event: ChangeEvent<HTMLInputElement>) => void;
}) => {
  const model = useFormInputModel(id, name, type, placeholder, value, onChange);

  return <FormInputView {...model} />;
};

export default FormInput;

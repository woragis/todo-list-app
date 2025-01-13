import { FormEvent } from "react";

export const useFormModel = (
  children: any,
  onSubmit: (event: FormEvent) => void
) => {
  return { children, onSubmit };
};

import { ChangeEvent, FormEvent, useState } from "react";

export const useFooterModel = () => {
  interface ContactInterface {
    title: string;
    body: string;
    email: string;
    tel_number: string;
  }

  const [contactData, setContactData] = useState<ContactInterface>(
    {} as ContactInterface
  );

  const handleContactChange = (event: ChangeEvent<HTMLInputElement>) => {
    setContactData(
      (prevState) =>
        (prevState = { ...prevState, [event.target.name]: event.target.value })
    );
  };

  const handleContactSubmit = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    console.log("Data to sent to server:", contactData);
  };

  return { contactData, handleContactChange, handleContactSubmit };
};

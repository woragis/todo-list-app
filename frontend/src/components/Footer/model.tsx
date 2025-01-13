import { ChangeEvent, FormEvent, useState } from "react";
import { useSelector } from "react-redux";
import { RootState } from "../../features/store";

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

  const footerColors = useSelector(
    (state: RootState) => state.theme.colors.footer
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

  return {
    contactData,
    handleContactChange,
    handleContactSubmit,
    footerColors,
  };
};

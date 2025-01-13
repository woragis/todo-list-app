import Form from "../../components/Form";
import FormButton from "../../components/Form/FormButton";
import FormInput from "../../components/Form/FormInput";
import { useRegisterModel } from "./model";
import { StyledRegisterPage } from "./styles";

export const RegisterView = ({
  auth,
  registerData,
  handleRegisterChange,
  handleRegisterSubmit,
}: ReturnType<typeof useRegisterModel>) => {
  if (auth.user) {
    return <h1>You are already logged in</h1>;
  }
  return (
    <StyledRegisterPage>
      <Form onSubmit={handleRegisterSubmit}>
        <h1>Register</h1>
        <FormInput
          type="text"
          name="name"
          id="name"
          placeholder="Name"
          value={registerData.name || ""}
          onChange={handleRegisterChange}
        />
        <FormInput
          type="text"
          name="email"
          id="email"
          placeholder="Email"
          value={registerData.email || ""}
          onChange={handleRegisterChange}
        />
        <FormInput
          type="password"
          name="password"
          id="password"
          placeholder="Password"
          value={registerData.password || ""}
          onChange={handleRegisterChange}
        />
        <FormButton>Register</FormButton>
        {auth.status === "loading" && <p>Loading...</p>}
        {auth.error && <p style={{ color: "red" }}>{auth.error}</p>}
      </Form>
    </StyledRegisterPage>
  );
};

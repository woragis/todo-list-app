import Form from "../../components/Form";
import FormButton from "../../components/Form/FormButton";
import FormInput from "../../components/Form/FormInput";
import { useLoginModel } from "./model";

export const LoginView = ({
  auth,
  loginData,
  handleLoginChange,
  handleLoginSubmit,
}: ReturnType<typeof useLoginModel>) => {
  if (auth.user) {
    return <h1>You are already logged in</h1>;
  }
  return (
    <Form onSubmit={handleLoginSubmit}>
      <h1>Login</h1>
      <FormInput
        type="text"
        name="email"
        id="email"
        placeholder="Email"
        value={loginData.email}
        onChange={handleLoginChange}
      />
      <FormInput
        type="text"
        name="password"
        id="password"
        placeholder="Password"
        value={loginData.password}
        onChange={handleLoginChange}
      />
      <FormButton>Send</FormButton>
    </Form>
  );
};

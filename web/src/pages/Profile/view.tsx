import { useProfileModel } from "./model";

export const ProfileView = ({ user }: ReturnType<typeof useProfileModel>) => {
  if (!user) {
    return <h1>You are not logged in</h1>;
  }
  return (
    <div>
      <h1>Profile</h1>
      <h2>{user.name}</h2>
      <hr />
      <p>Email: {user.email}</p>
      <p>Password: {user.password}</p>
      <p>Created At: {user.created_at}</p>
      <p>Updated At: {user.updated_at}</p>
      <br />
      <small>Id: {user.id}</small>
    </div>
  );
};

import { useProfileModel } from "./model";
import { ProfileView } from "./view";

const Profile = () => {
  const model = useProfileModel();

  return <ProfileView {...model} />;
};

export default Profile;

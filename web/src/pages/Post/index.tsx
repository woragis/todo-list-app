import { usePostModel } from "./model";
import { PostView } from "./view";

const Post = () => {
  const model = usePostModel();

  return <PostView {...model} />;
};

export default Post;

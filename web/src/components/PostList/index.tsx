import { Post } from "../../types/posts.types";
import { usePostListModel } from "./model";
import { PostListView } from "./view";

const PostList = ({ posts }: { posts: Post[] }) => {
  const model = usePostListModel(posts);

  return <PostListView {...model} />;
};

export default PostList;

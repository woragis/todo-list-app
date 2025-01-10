import { Post } from "../../types/posts.types";
import ListedPost from "../ListedPost";
import { usePostListModel } from "./model";
import { PostsListContainer } from "./styles";

export const PostListView = ({
  posts,
}: ReturnType<typeof usePostListModel>) => {
  console.log("posts: ", posts);
  const postsComponent = [].map((post: Post) => {
    return <ListedPost key={post.id + "_post_on_list"} {...post} />;
  });
  return <PostsListContainer>{postsComponent}</PostsListContainer>;
};

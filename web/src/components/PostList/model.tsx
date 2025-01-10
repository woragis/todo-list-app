import { Post } from "../../types/posts.types";

export const usePostListModel = (posts: Post[]) => {
  return { posts };
};

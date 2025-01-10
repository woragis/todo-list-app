import { Post } from "../../types/posts.types";

export const useListedPostModel = (post: Post) => {
  return { ...post };
};

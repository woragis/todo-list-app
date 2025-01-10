import { useSelector } from "react-redux";
import { useParams } from "react-router-dom";
import { RootState } from "../../features/store";
import { getPost } from "../../features/slices/postsSlice";
import { useAppDispatch } from "../../features/hooks";

const findPost = (post_id: number) => {
  const posts = useSelector((state: RootState) => state.posts.posts);
  const post = posts.find((posts) => posts.id === post_id);
  if (post) {
    return post;
  } else {
    const dispatch = useAppDispatch();
    const token = useSelector((state: RootState) => state.auth.token);
    dispatch(getPost({ token, post_id }));
    return useSelector((state: RootState) => state.posts.post);
  }
};

export const usePostModel = () => {
  const post_id = Number(useParams().post_id);
  const post = findPost(post_id);

  return { post };
};

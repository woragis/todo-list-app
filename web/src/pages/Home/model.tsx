import { useEffect } from "react";
import { getPosts } from "../../features/slices/postsSlice";
import { useSelector } from "react-redux";
import { RootState } from "../../features/store";
import { useAppDispatch } from "../../features/hooks";

export const useHomeModel = () => {
  const token = useSelector((state: RootState) => state.auth.token);
  const posts = useSelector((state: RootState) => state.posts.data.posts);
  const dispatch = useAppDispatch();
  useEffect(() => {
    dispatch(getPosts(token));
  }, []);
  return { posts };
};

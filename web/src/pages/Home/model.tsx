import { useEffect } from "react";
import { getPosts } from "../../features/slices/postsSlice";
import { useSelector } from "react-redux";
import { RootState } from "../../features/store";
import { useAppDispatch } from "../../features/hooks";

export const useHomeModel = () => {
  const token = useSelector((state: RootState) => state.auth.token);
  const todos = useSelector((state: RootState) => state.posts.data.posts);
  const themeColors = useSelector((state: RootState) => state.theme.colors);
  const dividerColor = themeColors.background.contrast;
  const dispatch = useAppDispatch();
  useEffect(() => {
    dispatch(getPosts(token));
  }, []);
  return { todos, dividerColor };
};

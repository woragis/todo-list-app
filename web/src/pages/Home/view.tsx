import PostList from "../../components/PostList";
import { useHomeModel } from "./model";

export const HomeView = ({ posts }: ReturnType<typeof useHomeModel>) => {
  return (
    <main>
      <h1>Posts</h1>
      <PostList posts={posts} />
    </main>
  );
};

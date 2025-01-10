import { usePostModel } from "./model";

export const PostView = ({ post }: ReturnType<typeof usePostModel>) => {
  if (!post) {
    return (
      <section>
        <header>
          <h1>Post not found</h1>
          <hr />
          <br />
        </header>
      </section>
    );
  } else {
    return (
      <section>
        <header>
          <h1>{post.title}</h1>
          <p>id: {post.id}</p>
          <hr />
          <br />
        </header>
        <div>
          <p>{post.body}</p>
        </div>
        <footer>
          <hr />
          Autor: {post.author_id}
          <hr />
          Criado: {post.created_at}
          <br />
          Atualizado: {post.updated_at}
          <br />
        </footer>
      </section>
    );
  }
};

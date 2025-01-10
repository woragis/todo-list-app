import { useListedPostModel } from "./model";
import {
  ListedPostAuthorData,
  ListedPostDescription,
  ListedPostMetaData,
  ListedPostTitle,
  StyledListedPost,
} from "./styles";

export const ListedPostView = ({
  id,
  title,
  body,
  visibility,
  author_id,
  created_at,
  updated_at,
}: ReturnType<typeof useListedPostModel>) => {
  return (
    <StyledListedPost>
      <ListedPostTitle>{title}</ListedPostTitle>
      <ListedPostDescription>{body}</ListedPostDescription>
      <ListedPostMetaData>
        id: {id}
        <br />
        visibilidade: {visibility}
        <ListedPostAuthorData>Author: {author_id}</ListedPostAuthorData>
        criado: {created_at}
        <br />
        editado: {updated_at}
      </ListedPostMetaData>
    </StyledListedPost>
  );
};

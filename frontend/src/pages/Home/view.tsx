import { Link } from "react-router-dom";
import { useHomeModel } from "./model";
import {
  HomeDivider,
  HomeHeroSection,
  TodoCard,
  TodosContainer,
} from "./styles";

export const HomeView = ({
  todosTitle,
  todosNotFound,
  todos,
  dividerColor,
}: ReturnType<typeof useHomeModel>) => {
  if (!todos.data?.todos) {
    return (
      <HomeHeroSection>
        <h1>{todosNotFound}</h1>
        <HomeDivider dividerColor={dividerColor} />
      </HomeHeroSection>
    );
  }
  const todosComponent = todos.data.todos.map((todo) => {
    return (
      <Link to={`todos/${todo.id}`}>
        <TodoCard key={`listed_todo_${todo.id}`}>
          <h3>{todo.title}</h3>
          <HomeDivider dividerColor={dividerColor} />
          <p>{todo.content}</p>
        </TodoCard>
      </Link>
    );
  });

  return (
    <HomeHeroSection>
      <h1>{todosTitle}</h1>
      <HomeDivider dividerColor={dividerColor} />
      {todos.isLoading && <h1>Loading...</h1>}
      {todos.error && <h1>Error while loading todos...</h1>}
      <TodosContainer>{todosComponent}</TodosContainer>
    </HomeHeroSection>
  );
};

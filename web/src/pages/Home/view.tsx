import { Link } from "react-router-dom";
import { useHomeModel } from "./model";
import {
  HomeDivider,
  HomeHeroSection,
  TodoCard,
  TodosContainer,
} from "./styles";

export const HomeView = ({
  todos,
  dividerColor,
}: ReturnType<typeof useHomeModel>) => {
  const todosComponent = todos.map((todo) => {
    return (
      <Link to={`todos/${todo.id}`}>
        <TodoCard key={`listed_todo_${todo.id}`}>
          <h3>{todo.title}</h3>
          <HomeDivider dividerColor={dividerColor} />
          <p>{todo.body}</p>
        </TodoCard>
      </Link>
    );
  });

  return (
    <main>
      <HomeHeroSection>
        <h1>'user' Todos</h1>
        <HomeDivider dividerColor={dividerColor} />
        <TodosContainer>{todosComponent}</TodosContainer>
      </HomeHeroSection>
    </main>
  );
};

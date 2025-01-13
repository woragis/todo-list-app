import { Route, Routes } from "react-router-dom";
import Layout from "./Layout";
import { pagesData } from "./pagesData";
import { PagesDataInterface } from "../types/router.types";

const AppRouter = () => {
  const routes = pagesData.map(
    ({ title, path, element }: PagesDataInterface) => {
      return (
        <Route key={title + "_page"} path={`/${path}`} element={element} />
      );
    }
  );
  return (
    <Routes>
      <Route path="/" element={<Layout />}>
        {routes}
      </Route>
    </Routes>
  );
};

export default AppRouter;

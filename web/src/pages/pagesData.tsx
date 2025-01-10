import { Pages, PagesDataInterface } from "../types/router.types";
import About from "./About";
import Home from "./Home";
import Login from "./Login";
import Logout from "./Logout";
import Register from "./Register";

export const pagesData: PagesDataInterface[] = [
  { title: Pages.Home, path: "" as Pages, element: <Home /> },
  { title: Pages.Login, path: Pages.Login, element: <Login /> },
  { title: Pages.Register, path: Pages.Register, element: <Register /> },
  { title: Pages.About, path: Pages.About, element: <About /> },
  { title: Pages.Logout, path: Pages.Logout, element: <Logout /> },
];

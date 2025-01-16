import { Pages, PagesDataInterface } from "../types/router.types";
import Home from "./Home";
import Profile from "./Profile";

export const pagesData: PagesDataInterface[] = [
  { title: Pages.Home, path: "" as Pages, element: <Home /> },
  { title: Pages.Profile, path: Pages.Profile, element: <Profile /> },
];

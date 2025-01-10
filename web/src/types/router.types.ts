export enum Pages {
  Home = "home",
  Login = "login",
  Register = "register",
  About = "about",
  Profile = "profile",
  Logout = "logout",
}

export interface NavPages {
  title: string;
  path: Pages;
}

export interface PagesDataInterface {
  title: Pages;
  path: Pages;
  element: JSX.Element;
}

export enum Pages {
  Home = "home",
  Profile = "profile",
  // Login = "login",
  // Register = "register",
  // Logout = "logout",
  // Todos = "todos",
}

export interface NavPages {
  title: string;
  path: string;
  onClick?: VoidFunction;
}

export interface PagesDataInterface {
  title: Pages;
  path: Pages;
  element: JSX.Element;
}

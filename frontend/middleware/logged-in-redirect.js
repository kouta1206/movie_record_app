export default ({ $auth, route, redirect }) => {
  if ($auth.loggedIn() && route.name == "login") {
    return redirect("/index-movie");
  } else if ($auth.loggedIn() && route.name == "signup") {
    return redirect("/index-movie");
  }
};

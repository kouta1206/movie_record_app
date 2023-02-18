import auth from "../plugins/auth";

export default async ({ $auth, store, route, redirect }) => {
  //
  if (!$auth.loggedIn()) {
    return redirect("/login");
  }
};

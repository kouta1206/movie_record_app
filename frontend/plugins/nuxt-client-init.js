export default async ({ $auth, $axios }) => {
  await $axios.$put(
    '/api/v1/auth_token',
    {},
    { validateStatus: status => $auth.resolveUnauthorized(status) }
  ).then(response => $auth.login(response))
}

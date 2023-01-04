<template>
  <div>
    <h2>Usersテーブルの取得</h2>
    <table v-if="users.length">
      <thead>
        <tr>
          <th>id</th>
          <th>name</th>
          <th>email</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(user, i) in users" :key="`user-${i}`">
          <td>{{ user.id }}</td>
          <td>{{ user.name }}</td>
          <td>{{ user.email }}</td>
        </tr>
      </tbody>
    </table>

    <div v-else>ユーザーが取得できませんでした</div>
  </div>
</template>

<script>
export default {
  async asyncData({ $axios }) {
    let users = [];
    await $axios.$get("/api/v1/users").then((res) => (users = res));
    return { users };
  },
};
</script>

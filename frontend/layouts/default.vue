<template>
  <div>
    <nav-bar />
    <section class="is-flex">
      <div v-if="isLoggedIn">
        <side-bar />
      </div>
      <nuxt />
    </section>
  </div>
</template>

<script>
export default {
  name: "DefaultLayout",
  data() {
    return {
      isLoggedIn: this.$auth.loggedIn(),
    };
  },
};
</script>

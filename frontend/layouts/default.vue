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
  mounted() {
    console.log(this.$auth.loggedIn())
  },
  name: "DefaultLayout",
  data() {
    return {
      isLoggedIn: this.$auth.loggedIn(),
    };
  },
};
</script>

<template>
  <div>
    <nav-bar />
    <section class="is-flex">
      <side-bar />
      <nuxt />
    </section>
  </div>
</template>

<script>
export default {
  name: "DefaultLayout",
  data() {
    return {};
  },
};
</script>

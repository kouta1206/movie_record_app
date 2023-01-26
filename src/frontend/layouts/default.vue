<template>
  <div>
    <div class="has-background-primary">
      <b-navbar class="container" type="is-primary">
        <template #brand>
          <b-navbar-item tag="router-link" :to="{ path: '/' }" >
            <strong>movie-record</strong>
          </b-navbar-item>
        </template>

        <template #end>
          <b-navbar-item tag="div">
            <div class="buttons">
              <a class="button is-primary">
                <strong>Sign up</strong>
              </a>
              <nuxt-link to="/login" class="button is-light"> Log in </nuxt-link>
            </div>
          </b-navbar-item>
        </template>
      </b-navbar>
    </div>
    <section class="is-flex">
      <SideBar />
      <Nuxt />
    </section>
  </div>
</template>

<script>

export default {
  name: "DefaultLayout",
  data() {
    return {
    };
  },
};
</script>

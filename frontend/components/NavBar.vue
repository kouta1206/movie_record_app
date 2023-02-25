<template>
  <div class="has-background-primary">
    <b-navbar class="container" type="is-primary"  style="height: 5vh;">
      <template #brand>
        <b-navbar-item tag="router-link" :to="{ path: '/' }">
          <strong>movie-record</strong>
        </b-navbar-item>
      </template>

      <template #end>
        <b-navbar-item tag="div" v-if="isExistUser"> </b-navbar-item>
        <b-navbar-item tag="div" v-else>
          <div class="buttons">
            <a class="button is-primary">
              <strong>サインイン</strong>
            </a>
            <nuxt-link to="/login" class="button is-light">ログイン</nuxt-link>
          </div>
        </b-navbar-item>
      </template>
    </b-navbar>
  </div>
</template>

<script>
export default {
  data() {
    return {
      isExistUser: this.$auth.isExistUser(),
    };
  },
};
</script>

<style>
</style>

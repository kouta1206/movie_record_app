<template>
  <div>hello world!</div>
</template>

<script>
export default {
  mounted() {
    console.log('token', this.$auth.token);
    console.log('payload', this.$auth.payload);
    console.log('user', this.$auth.user);

  }

}
</script>

<style>
</style>

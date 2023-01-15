<template>
  <div class="is-ralative">
    <div class="card card-wrapper">
      <div class="login-title">movie-recordにログインする</div>
      <div class="card-content">
        <div class="content">
          <section>
            <b-field
              label="Username"
              type="is-success"
              message="This username is available"
              class="mb-6"
            >
              <b-input maxlength="30" v-model="params.auth.email"></b-input>
            </b-field>
            {{ params.auth.name }}

            <b-field label="Password" class="mb-6">
              <b-input
                type="password"
                password-reveal
                v-model="params.auth.password"
              >
              </b-input>
            </b-field>
          </section>
        </div>
        <div class="buttons">
          <b-button type="is-primary" expanded @click="login"
            >Expanded</b-button
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      params: { auth: { email: "", password: "" } },
    };
  },
  methods: {
    async login() {
      await this.$axios
        .$post("/api/v1/auth_token", this.params)
        .then((res) => {
          this.succeedAuthentication(res);
        })
        .catch((error) => {
          this.indicateValidationDialog(error);
        });
    },
    indicateValidationDialog(error) {
      if (error.response.status == "404") {
        this.$buefy.dialog.confirm({
          title: "対象のユーザーが存在しません",
          message: "パスワードかメールアドレスが間違っています",
          type: "is-danger",
          hasIcon: true,
          canCancel: false,
          // TODO:後でバリデーションダイアログコンポーネントを作成
        });
      }
    },
    succeedAuthentication(res) {
      this.$auth.login(res);
      console.log("token", this.$auth.token);
      console.log("payload", this.$auth.payload);
      console.log("user", this.$auth.user);
      // TODO:リダイレクトさせる
    },
  },
};
</script>

<style scoped>
.card-wrapper {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 40%;
  height: 50%;
}

.login-title {
  font-size: 40px;
  font-family: "Gill Sans", "Gill Sans MT", Calibri, "Trebuchet MS", sans-serif;
  text-align: center;
}
</style>


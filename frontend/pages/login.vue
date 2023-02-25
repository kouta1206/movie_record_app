<template>
  <div class="section header-section over-width-container" style="height: 93.33vh;">
      <div class="card card-wrapper">
        <div class="login-title">movie-recordにログインする</div>
        <div class="card-content">
          <div class="content">
            <section>
              <b-field
                label="メールアドレス"
                type="is-success"
                message="This username is available"
                class="mb-3"
              >
                <b-input maxlength="30" v-model="params.auth.email"></b-input>
              </b-field>
              {{ params.auth.name }}

              <b-field label="パスワード" class="mb-6">
                <b-input
                  type="password"
                  password-reveal
                  v-model="params.auth.password"
                >
                </b-input>
              </b-field>
              <b-button class="mt-" type="is-primary" expanded @click="login"
                >ログイン</b-button
              >
            </section>
          </div>
        </div>
      </div>
    </div>
</template>

<script>
export default {
  middleware: "logged-in-redirect",
  mounted() {},
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
          this.$router.push({
            name: "index-movie",
            path: "index-movie",
          });
          location.reload();
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

<style>
.card-wrapper {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 50%;
  height: 50%;
}

.login-title {
  font-size: 40px;
  font-family: "Gill Sans", "Gill Sans MT", Calibri, "Trebuchet MS", sans-serif;
  text-align: center;
}

.header-section {
  width: 100vw;
  background-image: linear-gradient(
      to right top,
      rgba(19, 84, 122, 0.6),
      rgba(0, 0, 0, 0.7)
    ),
    url(../assets/top-background-image.jpg);
  background-position: center center;
  background-size: cover;
}
</style>


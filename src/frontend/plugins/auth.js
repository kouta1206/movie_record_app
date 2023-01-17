// front/plugins/auth.js
import jwtDecode from 'jwt-decode'

class Authentication {
  constructor (ctx) {
    this.store = ctx.store
    this.$axios = ctx.$axios
  }

  get token () {
    return this.store.state.auth.token
  }

  get expires () {
    return this.store.state.auth.expires
  }

  get payload () {
    return this.store.state.auth.payload
  }

  get user () {
    return this.store.state.user.current || {}
  }

  // 認証情報をVuexに保存する
  setAuth ({ token, expires, user }) {
    const exp = expires * 1000
    const jwtPayload = (token) ? jwtDecode(token) : {}

    this.store.dispatch('getAuthToken', token)
    this.store.dispatch('getAuthExpires', exp)
    this.store.dispatch('getCurrentUser', user)
    this.store.dispatch('getAuthPayload', jwtPayload)
  }

  // ログイン業務
  login (response) {
    this.setAuth(response)
  }

  // axiosのレスポンス401を許容する
  resolveUnauthorized (status) {
    return (status >= 200 && status < 300 ) || (status == 401)
  }

  // vuexの値をすべて初期化
  resetVuex() {
    this.setAuth({ token: null, expires: 0, user: null })
  }

  // ログアウト業務
  async logout() {
    await this.$axios.$delete('/api/v1/auth_token',
    { validateStatus: status => this.resolveUnauthorized(status) }
    )
    this.resetVuex()
  }

}

export default ({ store, $axios }, inject) => {
  inject('auth', new Authentication({ store, $axios }))
}

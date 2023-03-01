export default {
  // Disable server-side rendering: https://go.nuxtjs.dev/ssr-mode
  ssr: false,
  server: {
    port: 3000,
    host: '0.0.0.0',
  },



  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    title: 'app',
    htmlAttrs: {
      lang: 'en'
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' },
      { name: 'format-detection', content: 'telephone=no' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
  ],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
    'plugins/auth',
    'plugins/axios',
    'plugins/nuxt-client-init',
    '@plugins/textarea-autosize'
  ],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
  ],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    // https://go.nuxtjs.dev/buefy
    'nuxt-buefy',
    // https://go.nuxtjs.dev/axios
    '@nuxtjs/axios',
  ],

  router: {
    middleware: ['silent-refresh-token']
  },

  // Axios module configuration: https://go.nuxtjs.dev/config-axios
  axios: {
    // クロスドメインで認証情報を共有する(ブラウザでcookieを扱う為)
    credentials: true,
    // requestヘッダー設定
    headers: {
      "X-Requested-With": "XMLHttpRequest",
    },

    baseURL: process.env.NODE_ENV === "production" ? "http://movie-record.link" : "http://localhost:3000"

    // Workaround to avoid enforcing hard-coded localhost:3000: https://github.com/nuxt-community/axios-module/issues/308
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
  }
}

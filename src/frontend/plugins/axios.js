export default ({ $axios, $auth  }) => {
  // request logs
  $axios.onRequest((config) => {
    if ($auth.token) {
      config.headers.common.Authorization = `Bearer ${$auth.token}`
    }

    console.log(config)
  })
  // responce logs
  $axios.onResponse((config) => {
    console.log(config)
  })
  // error logs
  $axios.onError((e) => {
    console.log(e.response)
  })
 }

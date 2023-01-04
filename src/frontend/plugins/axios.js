export default ({ $axios }) => {
  // request logs
  $axios.onRequest((config) => {
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

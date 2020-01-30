// axiosのinterceptorsを利用して全リクエスト/レスポンス時に噛ませる共通処理をかくplugin

export default ({ $axios, store }) => {
  // $axios.onRequest((config) => {
  // config.headers.common.authorization = 'Bearer: <token>'
  // })
  // $axios.onError((error) => {
  // const code = parseInt(error.response && error.response.status)
  // switch (code) {
  // }
  // })
}

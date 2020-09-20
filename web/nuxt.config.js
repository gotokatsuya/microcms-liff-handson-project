export default {
  mode: 'spa',
  env: {
    liffId: '1654948312-x5a8mEVA'
  },
  head: {
    title: 'microcms-liff',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1.0' },
      { hid: 'description', name: 'description', content: 'microcms-liff' }
    ]
  },
  buildModules: [
    '@nuxt/typescript-build'
  ],
  modules: [
    '@nuxtjs/axios'
  ],
  plugins: [
    '@/plugins/composition-api',
    '@/plugins/axios-accessor',
    '@/plugins/ant-design-vue'
  ],
  axios: {
    proxy: true
  }
}

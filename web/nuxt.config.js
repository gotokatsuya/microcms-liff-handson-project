export default {
  ssr: false,
  loading: false,
  env: {
    liffId: '1654948312-x5a8mEVA'
  },
  head: {
    title: 'microcms-liff',
    meta: [
      { name: 'viewport', content: 'width=device-width, initial-scale=1.0' }
    ]
  },
  buildModules: [
    '@nuxt/typescript-build'
  ],
  modules: [
    '@nuxtjs/axios'
  ],
  plugins: [
    '@/plugins/axios-accessor',
    '@/plugins/ant-design-vue',
    '@/plugins/vconsole'
  ],
  axios: {
    proxy: true
  }
}

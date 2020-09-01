export default {
  buildModules: [
    '@nuxt/typescript-build'
  ],
  modules: [
    '@nuxtjs/axios'
  ],
  plugins: [
    '@/plugins/composition-api',
    '@/plugins/axios-accessor'
  ],

  axios: {
    proxy: true
  }
}

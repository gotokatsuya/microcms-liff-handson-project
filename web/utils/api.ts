/* eslint-disable space-before-function-paren */
/* eslint-disable import/no-mutable-exports */
import { NuxtAxiosInstance } from '@nuxtjs/axios'
import { lineStore } from '~/store'

let $axios: NuxtAxiosInstance

export function initializeAxios(axiosInstance: NuxtAxiosInstance) {
  $axios = axiosInstance
  $axios.onRequest((config) => {
    config.headers['Content-Type'] = 'application/json'
    if (lineStore.accessToken) {
      config.headers.Authorization = `Bearer ${lineStore.accessToken}`
    }
    return config
  })
}

export { $axios }

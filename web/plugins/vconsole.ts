import { Plugin } from '@nuxt/types'
import Vconsole from 'vconsole'

const vc: Plugin = (ctx, inject) => {
  inject('vConsole', new Vconsole())
}

export default vc

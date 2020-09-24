/* eslint-disable space-before-function-paren */
import { Module, VuexModule, Action, Mutation } from 'vuex-module-decorators'
import liff from '@line/liff'
import { User } from '~/types/line'

@Module({
  name: 'line',
  stateFactory: true,
  namespaced: true
})
export default class LineStore extends VuexModule {
  public initialized = false
  public accessToken = ''
  public user = {} as User

  @Mutation
  private setInitialized() {
    this.initialized = true
  }

  @Mutation
  private setAccessToken(accessToken: string) {
    this.accessToken = accessToken
  }

  @Mutation
  private setUser(user: User) {
    this.user = user
  }

  @Action({ rawError: true })
  private initLiff(liffId: string) {
    console.log(liffId)
    if (this.initialized) {
      console.log('initLiff: initialized')
      return Promise.resolve()
    }
    console.log('liff.init')
    return liff.init({ liffId })
      .then(() => {
        console.log('liff.init success')
        this.setInitialized()
      })
      .catch((err) => {
        console.log('liff.init error')
        console.error(err)
        throw err
      })
  }

  @Action({ rawError: true })
  public async init() {
    console.log('initLiff')
    await this.initLiff(process.env.liffId!)

    console.log('liff.getAccessToken')
    const accessToken = await liff.getAccessToken()
    this.setAccessToken(accessToken!)

    console.log('liff.getProfile')
    const profile = await liff.getProfile()
    this.setUser({ pictureUrl: profile.pictureUrl!, name: profile.displayName! })
  }
}

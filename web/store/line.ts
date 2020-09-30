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
  public async init() {
    if (this.initialized) {
      return
    }

    await liff.init({ liffId: process.env.liffId! })

    const accessToken = await liff.getAccessToken()
    this.setAccessToken(accessToken!)

    const profile = await liff.getProfile()
    this.setUser({ pictureUrl: profile.pictureUrl!, name: profile.displayName! })

    this.setInitialized()
  }
}

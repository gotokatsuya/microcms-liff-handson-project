/* eslint-disable space-before-function-paren */
import { Module, VuexModule, Action, Mutation } from 'vuex-module-decorators'
import { $axios } from '~/utils/api'
import { Content } from '~/types/contents'

@Module({
  name: 'contents',
  stateFactory: true,
  namespaced: true
})
export default class Contents extends VuexModule {
  contents: Content[] = []

  @Mutation
  private setContents(contents: Content[]) {
    this.contents = contents
  }

  @Action
  public async fetchContents() {
    const { data } = await $axios.get<Content[]>('/api/contents')
    this.setContents(data)
  }
}

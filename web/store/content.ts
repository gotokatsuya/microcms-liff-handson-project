/* eslint-disable space-before-function-paren */
import { Module, VuexModule, Action, Mutation } from 'vuex-module-decorators'
import { $axios } from '~/utils/api'
import { Content } from '~/types/content'

@Module({
  name: 'content',
  stateFactory: true,
  namespaced: true
})
export default class ContentStore extends VuexModule {
  public contents = [] as Content[]

  @Mutation
  private setContents(contents: Content[]) {
    this.contents = contents
  }

  @Action({ rawError: true })
  public async fetch() {
    const { data } = await $axios.get<Content[]>('/api/content')
    this.setContents(data)
  }

  @Action({ rawError: true })
  public async post(text: string) {
    await $axios.post<Content>('/api/content', { text })
  }
}

/* eslint-disable space-before-function-paren */
/* eslint-disable import/no-mutable-exports */
import { Store } from 'vuex'
import { getModule } from 'vuex-module-decorators'
import LineStore from '~/store/line'
import ContentStore from '~/store/content'

let lineStore: LineStore
let contentStore: ContentStore

function initialiseStores(store: Store<any>): void {
  lineStore = getModule(LineStore, store)
  contentStore = getModule(ContentStore, store)
}

export { initialiseStores, lineStore, contentStore }

/* eslint-disable space-before-function-paren */
/* eslint-disable import/no-mutable-exports */
import { Store } from 'vuex'
import { getModule } from 'vuex-module-decorators'
import Contents from '~/store/contents'

let contentsStore: Contents

function initialiseStores(store: Store<any>): void {
  contentsStore = getModule(Contents, store)
}

export { initialiseStores, contentsStore }

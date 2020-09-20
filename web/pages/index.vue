<template>
  <Contents />
</template>

<script lang="ts">
import Vue from 'vue'
import Contents from '~/components/contents.vue'
import { lineStore, contentStore } from '~/store'

export default Vue.extend({
  components: {
    Contents
  },
  async fetch () {
    try {
      await lineStore.init()
      await contentStore.fetch()
    } catch (e) {
      console.error(e)
    }
  }
})
</script>

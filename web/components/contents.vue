<template>
  <div class="contents">
    <a-list size="large" bordered :data-source="contents">
      <a-list-item slot="renderItem" slot-scope="item" class="Item">
        <a-list-item-meta class="Item Meta" :description="item.text">
          <div slot="title">{{ item.userName }}</div>
          <a-avatar slot="avatar" :src="item.userPictureUrl" />
        </a-list-item-meta>
      </a-list-item>
    </a-list>
  </div>
</template>

<script lang="ts">
import { defineComponent, computed } from '@vue/composition-api'
import { contentStore } from '~/store'

export default defineComponent({
  setup () {
    const contents = computed(() => contentStore.contents)
    return {
      contents
    }
  }
})
</script>

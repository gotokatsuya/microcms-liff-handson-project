<template>
  <div>
    <div v-for="c in contents" :key="c.id">
      <div>{{ c.content }}</div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, computed, onMounted } from '@vue/composition-api'
import { contentsStore } from '~/store'

export default defineComponent({
  setup () {
    onMounted(async () => {
      try {
        await contentsStore.fetchContents()
      } catch (e) {
        console.error(e)
      }
    })
    const contents = computed(() => contentsStore.contents)
    return {
      contents
    }
  }
})
</script>

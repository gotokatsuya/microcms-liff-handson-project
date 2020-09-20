<template>
  <div class="post-content">
    <div v-if="errorMessage">{{ errorMessage }}</div>
    <div>{{ user.name }}</div>
    <div>{{ user.pictureUrl }}</div>
  </div>
</template>

<script lang="ts">
import { defineComponent, reactive, computed, toRefs } from '@vue/composition-api'
import { lineStore, contentStore } from '~/store'

export default defineComponent({
  setup () {
    const state = reactive({
      errorMessage: '',
      text: ''
    })
    const user = computed(() => lineStore.user)
    const onClick = async () => {
      if (state.text === '') {
        state.errorMessage = 'テキストを入力してください'
        return
      }
      if (state.text.length > 140) {
        state.errorMessage = '140文字以上は入力できません'
        return
      }
      try {
        await contentStore.post(state.text)
        state.errorMessage = ''
      } catch (err) {
        state.errorMessage = err.message
      }
    }
    return {
      ...toRefs(state),
      user,
      onClick
    }
  }
})
</script>

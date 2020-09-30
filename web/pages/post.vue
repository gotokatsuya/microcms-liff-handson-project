<template>
  <div>
    <div class="post-content-head">
      <a-button type="primary" :loading="loading" @click="postContent">
        投稿する
      </a-button>
    </div>
    <div class="post-content-body">
      <div>
        <a-avatar slot="avatar" :src="user.pictureUrl" />
      </div>
      <a-textarea
        style="margin-left: 12px"
        size="large"
        placeholder="ハンズオンどうですか？"
        :rows="4"
        :max-length="140"
        @change="onChangeText"
      />
    </div>
  </div>
</template>

<style scoped>
.post-content-head {
  text-align: right;
  padding: 16px;
}

.post-content-body {
  display: flex;
  padding: 16px;
  padding-top: 0;
}
</style>

<script lang="ts">
import { defineComponent, reactive, computed, toRefs, SetupContext } from '@vue/composition-api'
import { lineStore, contentStore } from '~/store'

export default defineComponent({
  setup (props: {}, ctx: SetupContext) {
    const state = reactive({
      loading: false,
      text: ''
    })
    const user = computed(() => lineStore.user)
    const onChangeText = (e: any) => {
      state.text = e.target.value
    }
    const postContent = async () => {
      if (state.text === '') {
        alert('テキストを入力してください')
        return
      }
      if (state.text.length > 140) {
        alert('140文字以上は入力できません')
        return
      }
      try {
        state.loading = true
        await contentStore.post(state.text)
        ctx.root.$router.back()
      } catch (e) {
        alert(e.message ? e.message : 'エラーが発生しました')
      } finally {
        state.loading = false
      }
    }
    return {
      ...toRefs(state),
      user,
      onChangeText,
      postContent
    }
  }
})
</script>

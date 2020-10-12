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
        placeholder="テキスト入力してください"
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

import Vue from 'vue'
import { lineStore, contentStore } from '~/store'

export default Vue.extend({
  data () {
    return {
      loading: false,
      text: ''
    }
  },
  computed: {
    contents () {
      return lineStore.user
    }
  },
  methods: {
    onChangeText (e: any) {
      this.text = e.target.value
    },
    async postContent () {
      if (this.text === '') {
        alert('テキストを入力してください')
        return
      }
      if (this.text.length > 140) {
        alert('140文字以上は入力できません')
        return
      }
      try {
        this.loading = true
        await contentStore.post(this.text)
        this.$router.back()
      } catch (e) {
        alert(e.message ? e.message : 'エラーが発生しました')
      } finally {
        this.loading = false
      }
    }
  }
})
</script>

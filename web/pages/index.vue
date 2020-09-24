<template>
  <div>
    <div v-if="loading" class="loading">
      <a-spin size="large" />
    </div>
    <div v-else>
      <div class="contents-list">
        <a-list size="large" bordered :data-source="contents">
          <a-list-item slot="renderItem" slot-scope="item" class="Item">
            <a-list-item-meta class="Item Meta" :description="item.text">
              <div slot="title">
                {{ item.userName }}
              </div>
              <a-avatar slot="avatar" :src="item.userPictureUrl" />
            </a-list-item-meta>
          </a-list-item>
        </a-list>
      </div>
      <div class="contents-foot-fixed">
        <a-button
          type="primary"
          size="large"
          shape="circle"
          icon="plus"
          @click="toPostContent"
        />
      </div>
    </div>
  </div>
</template>

<style scoped>
.loading {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.contents-foot-fixed {
  z-index: 100;
  position: fixed;
  width: 100%;
  left: 0;
  bottom: 0;
  background: transparent;
  padding: 30px;
  text-align: right;
}
</style>

<script lang="ts">
import Vue from 'vue'
import { lineStore, contentStore } from '~/store'

export default Vue.extend({
  async fetch () {
    try {
      this.loading = true
      await lineStore.init()
      await contentStore.fetch()
    } catch (e) {
      console.error(e)
      const errorMessage = e.message ? e.message : 'エラーが発生しました'
      alert(errorMessage)
    } finally {
      this.loading = false
    }
  },
  data () {
    return {
      loading: true
    }
  },
  computed: {
    contents () {
      return contentStore.contents
    }
  },
  methods: {
    toPostContent () {
      this.$router.push('/post')
    }
  }
})
</script>

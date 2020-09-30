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
      <div v-if="refreshButtonState" class="contents-head-fixed">
        <a-button type="primary" @click="refreshContents">
          再読み込み
        </a-button>
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

.contents-head-fixed {
  z-index: 100;
  position: fixed;
  width: 100%;
  left: 0;
  top: 0;
  background: transparent;
  padding-top: 20px;
  text-align: center;
}

.contents-foot-fixed {
  z-index: 100;
  position: fixed;
  width: 100%;
  left: 0;
  bottom: 0;
  background: transparent;
  padding-right: 20px;
  padding-bottom: 40px;
  text-align: right;
}
</style>

<script lang="ts">
import Vue from 'vue'
import { lineStore, contentStore } from '~/store'

export default Vue.extend({
  async fetch () {
    if (lineStore.initialized && contentStore.existsContents) {
      return
    }
    try {
      this.loading = true
      await lineStore.init()
      await contentStore.fetch()
    } catch (e) {
      alert(e.message ? e.message : 'エラーが発生しました')
    } finally {
      this.loading = false
    }
  },
  data () {
    return {
      loading: false,
      refreshButtonState: false
    }
  },
  computed: {
    contents () {
      return contentStore.contents
    }
  },
  mounted () {
    window.addEventListener('scroll', this.onScrollRefreshButtonState)
  },
  beforeDestroy () {
    window.removeEventListener('scroll', this.onScrollRefreshButtonState)
  },
  methods: {
    toPostContent () {
      this.$router.push('/post')
    },
    async refreshContents () {
      try {
        this.loading = true
        await contentStore.fetch()
      } catch (e) {
        alert(e.message ? e.message : 'エラーが発生しました')
      } finally {
        this.loading = false
        this.refreshButtonState = false
      }
    },
    onScrollRefreshButtonState () {
      const pos = window.pageYOffset || document.documentElement.scrollTop
      this.refreshButtonState = pos <= 0
    }
  }
})
</script>

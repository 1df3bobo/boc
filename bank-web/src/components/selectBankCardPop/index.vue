<template>
  <van-popup v-model="show" round position="bottom" @close="close" @click-overlay="close">
    <div class="main">
      <img class="bg" src="@/assets/image/home/bankPopup.png" alt="">
      <div class="content">
        <div class="title">
          <div class="item" @click="close"></div>
          <div class="item" @click="confirm"></div>
        </div>
        <div class="list">
          <div class="item" @click="change('全部账户')">
            <img v-if="name === '全部账户'" class="check" src="@/assets/image/home/check.png" alt="">
            <div v-else class="check check-no"></div>
          </div>
          <div class="item" @click="change(userInfo.bankList[0].bankName+' '+userInfo.bankList[0].bankCard.slice(-4))">
            <img v-if="name !== '全部账户'" class="check" src="@/assets/image/home/check.png" alt="">
            <div v-else class="check check-no"></div>
          </div>
          <div class="item" @click="change(userInfo.bankList[0].bankName+' '+userInfo.bankList[0].bankCard.slice(-4))">
            <div class="card">{{ userInfo.bankList[0].bankName }}({{ userInfo.bankList[0].bankCard.slice(-4) }})</div>
            <img v-if="name !== '全部账户'" class="check" src="@/assets/image/home/check.png" alt="">
            <div v-else class="check check-no"></div>
          </div>
        </div>
      </div>
    </div>
  </van-popup>
</template>

<script>
import {mapState} from "vuex";

export default {
  name: "index",
  props: {
    show: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      name: '全部账户'
    }
  },
  computed: {
    ...mapState(['userInfo'])
  },
  methods: {
    close() {
      this.$emit('close')
    },
    confirm() {
      this.$emit('confirm', this.name)
    },
    change(name) {
      this.name = name
    }
  }
}
</script>

<style scoped lang="scss">
.main {
  width: 7.5rem;
  height: 7.5rem;
  position: relative;

  .bg {
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
  }

  .content {
    position: relative;

    .title {
      display: flex;
      align-items: center;
      justify-content: space-between;

      .item {
        width: 1.04rem;
        height: 0.84rem;
      }
    }

    .list {
      width: 100%;
      padding-top: 0.5rem;

      .item {
        height: 0.64rem;
        width: 100%;
        position: relative;
        margin-bottom: 0.4rem;
        display: flex;

        .card {
          color: #2C2C2C;
          padding-left: 0.6rem;
          box-sizing: border-box;
          font-size: 0.26rem;
        }

        .check {
          position: absolute;
          width: 0.38rem;
          height: 0.38rem;
          right: 0.4rem;
        }

        .check-no {
          border-radius: 0.04rem;
          border: 0.02rem solid #666666;
          box-sizing: border-box;
        }
      }
    }
  }
}
</style>

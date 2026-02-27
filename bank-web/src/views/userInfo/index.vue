<template>
  <div class="userInfo">
    <nav-bar title="我的个人信息"></nav-bar>
    <div class="main">
      <img class="bg" src="@/assets/image/home/userinfo.png" alt="">
      <div class="info">
        <div class="name">王*华</div>
        <div class="item" @click="goPages('/userInfo/details')"></div>
        <div class="item" @click="goPages('/userInfo/editPhoneNo')"></div>
      </div>
    </div>
  </div>
</template>

<script>
import {mapState} from "vuex";

export default {
  name: 'userInfo',
  computed: {
    ...mapState(['userInfo'])
  },
  methods: {
    goPages(path) {
      this.$router.push({
        path: path,
      })
    }
  }
}
</script>


<style scoped lang="scss">
.userInfo {
  width: 100%;
  min-height: 100vh;
  background-color: #F4F4F4;
}

.info {
  width: 100%;
  position: relative;
  padding-top: 1.96rem;

  .name {
    line-height: 1;
    color: #FFFFFF;
    font-size: 0.3rem;
    text-align: center;
    font-weight: 700;
    margin-bottom: 1rem;
  }

  .item {
    width: 100%;
    height: 1rem;
  }
}

.main {
  position: relative;
  width: 100%;
}

.bg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 14.14rem;
}
</style>

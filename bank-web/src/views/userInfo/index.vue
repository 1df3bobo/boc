<template>
  <div class="userInfo">
    <nav-bar title="我的个人信息"></nav-bar>
    <div class="main">
      <img class="bg" src="@/assets/image/home/userinfo.png" alt="">
      <div class="info">
        <div class="name">{{ maskName }}</div>
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
    ...mapState(['userInfo']),
    // app那边拷贝过来的逻辑
    maskName() {
      const name = this.userInfo.realName;
      // 处理空值/空字符串
      if (name == null || name.trim().isEmpty) {
        return "";
      }
      const realName = name.trim();
      const length = realName.length;

      // 单字名：直接返回（无脱敏必要）
      if (length == 1) {
        return realName;
      }
      // 两字名：第二个字替换为*
      else if (length == 2) {
        return `${realName.substring(0, 1)}*`;
      }
      // 超两字名：首尾保留，中间全替换为*
      else {
        const firstChar = realName.substring(0, 1);
        const lastChar = realName.substring(length - 1);
        // 计算中间需要替换的*数量
        let middleStars = "";
        for(let i = 0; i < length - 2; i++) {
          middleStars += "*";
        }
        return `${firstChar}${middleStars}${lastChar}`;
      }
    }
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

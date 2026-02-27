<template>
  <div class="app">
    <nav-bar :title="name"></nav-bar>
    <div class="main">
      <div class="header" :style="{top:(statusBarHeight+appBarHeight)+'rem'}">
        <div class="header-time">
          <span>{{ dateTime }}</span>
          <img class="header-icon" src="@/assets/image/home/interest.png" alt="">
        </div>
        <div class="total">
          <div class="total-num">共{{ total }}笔交易</div>
          <div class="money">{{
              incomeExpenseType === '2' ? '支出' : '收入'
            }}￥{{ incomeExpenseType === '2' ? Math.abs(expensesTotal) : Math.abs(incomeTotal) }}
          </div>
        </div>
      </div>
      <div class="header-pl"></div>
      <van-list
          :immediate-check="false"
          style="min-height: 80vh"
          v-model="loading"
          :finished="finished"
          :error="error"
          finished-text="没有更多了"
          @load="nextPages"
      >
        <div class="list">
          <div class="item" v-for="(item,index) in list" :key="index" @click="goDetails(item)">
            <div class="item-time">{{ item.transactionTime }}</div>
            <div class="item-content">
              <img class="item-icon" :src="item.icon" alt="">
              <div class="item-info">
                <div class="item-excerpt">{{ item.excerpt }}</div>
                <div class="item-info-bottom">
                  <div>{{ item.transactionCategory }}({{ item.bankCard }})</div>
                  <div>人民币元 <span>{{ formatAmount(item.amount) }}</span></div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </van-list>
    </div>
  </div>

</template>
<script>
import {getBillCategoryList} from "@/api";
import {mapState} from "vuex";
import {formatAmount} from '@/utils'

export default {
  name: "cateogryList",
  data() {
    return {
      formatAmount: formatAmount,
      name: this.$route.query.name || '',
      type: this.$route.query.type || '',
      incomeExpenseType: this.$route.query.incomeExpenseType || '',
      dateTime: this.$route.query.dateTime || '',
      status: 'loading',
      pageNum: 1,
      pageSize: 10,
      list: [],
      total: 1,
      loading: false,
      finished: false,
      error: false,
      expensesTotal: 0,
      incomeTotal: 0
    }
  },
  created() {
    this.getBillCategoryList()
  },
  computed: {
    ...mapState(['statusBarHeight', 'appBarHeight'])
  },
  methods: {
    nextPages() {
      if (this.total <= this.list.length) {
        this.finished = true
        return;
      }
      this.pageNum = this.pageNum + 1
      this.loading = true
      this.getBillCategoryList()
    },
    goDetails(item) {
      if (window.FlutterBridge) {
        window.FlutterBridge.postMessage({
          type: 'billDetails',
          data: JSON.stringify(item)
        });
      }
    },
    getBillCategoryList() {
      let formattedDate = ''
      if (this.type === '0') {
        formattedDate = this.dateTime.replace(".", "-");
      } else {
        formattedDate = this.dateTime.replace("年", "");
      }
      getBillCategoryList({
        name: this.name,
        type: this.type,
        incomeExpenseType: this.incomeExpenseType,
        dateTime: formattedDate,
        pageSize: this.pageSize,
        pageNum: this.pageNum,
      }).then(res => {
        if (res.data.code === 200) {
          this.list = [...this.list, ...res.data.data.list]
          this.total = res.data.data.total
          this.expensesTotal = res.data.data.expensesTotal
          this.incomeTotal = res.data.data.incomeTotal
          // this.pageNum = res.data.data.customizeParam
          this.loading = false
        } else {
          this.loading = false
          this.error = true
        }
      })
    }
  }
}
</script>

<style scoped lang="scss">
.app {
  width: 100%;
  min-height: 100vh;
  background-color: #F4F4F4;

  .list {
    width: 100%;

    .item {
      width: 100%;
      color: #222222;

      .item-time {
        line-height: 1;
        margin: 0.18rem 0;
        padding: 0 0.3rem;
        box-sizing: border-box;
        font-size: 0.26rem;
      }

      .item-content {
        width: 7.5rem;
        height: 1.36rem;
        background: #FFFFFF;
        padding: 0.3rem 0.34rem 0 0.3rem;
        box-sizing: border-box;
        display: flex;

        .item-icon {
          width: 0.42rem;
          height: 0.42rem;
        }

        .item-info {
          flex: 1;
          color: #666666;
          margin-left: 0.2rem;
          font-size: 0.26rem;

          .item-excerpt {
            color: #222222;
          }

          .item-info-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;

            span {
              color: #222222;
              font-weight: 700;
            }
          }
        }
      }
    }

  }

  .header-pl {
    width: 100%;
    height: 1.5rem;
  }

  .header {
    width: 100%;
    height: 1.5rem;
    background-color: #ffffff;
    position: fixed;
    left: 0;
    color: #222222;
    font-size: 0.26rem;
    padding: 0.3rem;
    box-sizing: border-box;

    .header-time {
      display: flex;
      align-items: center;
      justify-content: space-between;

      .header-icon {
        width: 0.36rem;
        height: 0.36rem;
      }
    }

    .total {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-top: 0.16rem;

      .money {
        font-size: 0.32rem;
        font-weight: 700;
      }
    }
  }
}
</style>

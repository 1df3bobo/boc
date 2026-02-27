<template>
  <div class="app">
    <nav-bar title="收支分析"></nav-bar>
    <div class="main">
      <div class="title">
        <div class="item" @click="datePopup">
          <span>{{ dateTime }}</span>
          <img class="icon" src="@/assets/image/home/arrow-tri-down.png" alt="">
        </div>
        <div class="item" @click="selectBankShow = true">
          <span>{{ bankName }}</span>
          <img class="icon" src="@/assets/image/home/arrow-tri-down.png" alt="">
        </div>
        <div class="date">
          <div @click="changeType('1')" :class="['date-item',type ==='1'?'date-item-month':'']">年</div>
          <div @click="changeType('0')" :class="['date-item',type ==='0'?'date-item-month':'']">月</div>
        </div>
      </div>
      <div class="analysis">
        <img class="analysis-bg" v-if="incomeExpenseType === '2'" src="@/assets/image/home/budgetAnalysis1.png" alt="">
        <img class="analysis-bg" v-if="incomeExpenseType === '1'" src="@/assets/image/home/budgetAnalysis2.png" alt="">
        <div class="analysis-content" v-if="analysisDetails">
          <div class="analysis-title">
            <div :class="['item',incomeExpenseType === '2'?'active':'']" @click="changeIncomeExpenseType('2')">
              <div>支出</div>
              <div>￥{{ Math.abs(analysisDetails.expenses) }}</div>
            </div>
            <div :class="['item',incomeExpenseType === '1'?'active':'']" @click="changeIncomeExpenseType('1')">
              <div>收入</div>
              <div>￥{{ analysisDetails.income }}</div>
            </div>
          </div>
          <div class="chart">
            <div class="chart-line" ref="chartRef"></div>
            <div class="chart-pie" v-if="cateogryList.length>0" ref="chartRefPie"></div>
            <div v-else class="empty">
              <img class="empty-bg" src="@/assets/image/home/empty.png" alt="">
              <span>{{ type === '0' ? '本月暂无交易' : '本年暂无交易' }}</span>
            </div>
          </div>
        </div>
      </div>
      <div class="cateogry-list" v-if="analysisDetails&&cateogryList.length>0">
        <div class="cateogry-title">
          <span>{{ incomeExpenseType === '2' ? '支出' : '收入' }}</span>
          <span>￥{{
              incomeExpenseType === '2' ? Math.abs(analysisDetails.expenses) : Math.abs(analysisDetails.income)
            }}</span>
        </div>
        <div class="item" v-for="(item, index) in cateogryList" :key="index" @click="goCateogryList(item)">
          <img class="item-icon" :src="item.categoryIcon" alt="">
          <div class="item-content">
            <div class="item-content-info">
              <div class="item-name">{{ item.name }} {{ item.rate }}%</div>
              <div class="item-number">￥{{ Math.abs(item.totalAmount) }}</div>
            </div>
            <div class="item-progress">
              <van-progress :show-pivot="false" :percentage="item.rate" stroke-width="0.08rem"
                            :color="incomeExpenseType === '2'?expenseColorList[index]:incomeColorList[index]"/>
            </div>
          </div>
        </div>
      </div>
    </div>
    <select-bank-card-pop @close="selectBankShow = false" @confirm="bankConfirm"
                          :show="selectBankShow"></select-bank-card-pop>
    <van-popup v-model="yearMonthShow" position="bottom" @close="yearMonthShow = false">
      <van-datetime-picker
          v-model="currentDate"
          type="year-month"
          :min-date="minDate"
          :max-date="maxDate"
          :formatter="formatter"
          @cancel="yearMonthShow = false"
          @confirm="yearMonthConfirm"
      />
    </van-popup>
    <van-popup v-model="yearShow" round position="bottom">
      <van-picker
          show-toolbar
          :columns="columns"
          @cancel="yearShow = false"
          @confirm="yearConfirm"
      />
    </van-popup>
  </div>
</template>
<script>
import * as echarts from "echarts";
import {getBillAnalysis} from "@/api";
import {remToPx} from "@/utils";

export default {
  name: "analysis",
  data() {
    return {
      yearMonthShow: false,
      dateTime: '',
      type: '0',
      minDate: new Date(2020, 0, 1),
      maxDate: new Date(),
      currentDate: new Date(),
      currentYear: '',
      yearShow: false,
      analysisDetails: null,
      selectBankShow: false,
      bankName: '全部账户',
      incomeExpenseType: '2', // 1收入 2支出
      expenseColorList: ['#0062EE', '#3137FC', '#0055D4', '#002C86', '#CCE1FF', '#66A7FF', '#99C4FF'],
      incomeColorList: [
        '#DD0035',
        '#FFCCD7',
        '#FF99B0',
        '#FF6688',
        '#FF3360',
        '#B8002C',
        '#930023',
        '#6F001B',
        '#4A0012'
      ],
    }
  },
  mounted() {
    this.initDate()
    this.getBillAnalysis()
  },
  computed: {
    cateogryList() {
      return this.incomeExpenseType === '2' ? this.analysisDetails.expensesCateogryList : this.analysisDetails.incomeCateogryList
    },
    columns() {
      const currentYear = new Date().getFullYear();
      const lastEightYears = [];
      for (let i = 0; i < 9; i++) {
        lastEightYears.push(`${currentYear - i}年`);
      }
      return lastEightYears
    },
    lineChartOption() {
      let trendList = this.analysisDetails.trendList.reverse()
      const incomeList = trendList.map(item => item.income); // 收入
      const expensesList = trendList.map(item => Math.abs(item.expenses)); // 支出
      const dateTimeList = trendList.map(item => {
        const date = new Date(item.dateTime);
        if (this.type === '0') {
          return `${date.getMonth() + 1}-${date.getDate()}`;
        }
        return `${date.getMonth() + 1}月`;
      });
      return {
        tooltip: {
          trigger: 'axis',
          backgroundColor: 'transparent',  // 背景透明
          borderWidth: 0,                  // 边框宽度设为0
          padding: 0,                      // 内边距设为0
          alwaysShowContent: false, // 注意这里设为 false
          // 使用 formatter 返回 HTML 内容
          formatter: (params) => {
            let name, value;
            params.forEach(element => {
              name = element.name
              value = element.value
            });
            return `
                        <div style="
          width: 1.39rem;
          height: 0.93rem;
          background: ${this.incomeExpenseType === '2' ? '#2C70ED' : '#DD0035'};
          border: 0.02rem solid #fff;
          border-radius: 0.08rem;
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: center;
          color: white;
          font-size: 0.2rem;
        ">
                            <div>${name}</div>
                            <div>￥${value?.toFixed(2)}</div>
                        </div>
                    `;
          },
          confine: true,
          extraCssText: 'box-shadow: 0 0 10px rgba(0,0,0,0.3);'
        },
        grid: {
          left: remToPx(0.2),
          right: remToPx(0.3),
          bottom: remToPx(0.2),
        },
        xAxis: {
          type: 'category',
          data: dateTimeList,
        },
        yAxis: {
          type: 'value',
          show: false, // 隐藏Y轴
        },
        series: [
          {
            data: this.incomeExpenseType === '2' ? expensesList : incomeList,
            type: 'line',
            color: this.incomeExpenseType === '2' ? '#2C70ED' : '#DD0035',
            lineStyle: {
              width: 1,         // 线条宽度
              type: 'solid'     // 线条类型：'solid' | 'dashed' | 'dotted'
            }
          }
        ]
      }
    },

    pieChartOption() {
      const list = []
      let cateogryList = this.incomeExpenseType === '2' ? this.analysisDetails.expensesCateogryList : this.analysisDetails.incomeCateogryList
      let upTotalAmount = 110
      cateogryList.forEach((item) => {
        const obj = {
          name: item.name,
          value: Math.abs(item.totalAmount)
        }
        list.push(obj)
      })
      return {
        legend: {
          bottom: 10,
          left: 'center',
          icon: 'circle',
          itemGap: 20,
          width: remToPx(6.5),
          textStyle: { // 图例文字的样式
            color: '#222222',
            fontSize: remToPx(0.24)
          },
          itemHeight: remToPx(0.16)
        },
        graphic: {
          elements: [{
            type: 'image',
            style: {
              image: require('@/assets/image/home/decline.png'),
              width: remToPx(0.3),
              height: remToPx(0.3),
            },
            left: '54%', // 定位到适合的位置
            top: remToPx(2.14), // 定位到适合的位置
          }]
        },
        title: [
          {
            text: this.type === '0' ? '较上月' : '较上年', // 主标题
            textStyle: {
              // 主标题样式
              color: '#ACACAC',
              fontWeight: '500',
              fontSize: remToPx(0.24)
            },
            left: '48%', // 定位到适合的位置
            top: remToPx(2.1), // 定位到适合的位置
            subtext: `￥${upTotalAmount}`, // 副标题
            subtextStyle: {
              // 副标题样式
              color: '#282828',
              fontSize: remToPx(0.26),
              fontWeight: '700',
            },
            textAlign: 'center' // 主、副标题水平居中显示
          }
        ],
        color: this.incomeExpenseType === '2' ? this.expenseColorList : this.incomeColorList,
        series: [
          {
            name: '访问来源',
            type: 'pie',
            radius: [45, 70],
            data: list,
            labelLine: {
              show: false
            },
            label: {
              show: false  // 关键：设置为false
            },

            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }
        ]
      }
    }
  },
  methods: {
    goCateogryList(item) {
      this.$router.push({
        path: `/analysis/cateogryList`,
        query: {
          name: item.name,
          type: this.type,
          incomeExpenseType: this.incomeExpenseType,
          dateTime: this.dateTime
        }
      })
    },
    changeIncomeExpenseType(type) {
      if (type === this.incomeExpenseType) return
      this.incomeExpenseType = type
      let chart = this.chart
      chart.setOption(this.lineChartOption)

      let pieChart = this.pieChart
      pieChart.setOption(this.pieChartOption)
    },
    bankConfirm(name) {
      this.bankName = name;
    },
    initDate() {
      if (this.type === '0') {
        if (this.currentYear) {
          let yearString = Number(this.currentYear.replace("年", ""));
          let date = new Date(yearString, 1)
          let year = date.getFullYear();
          let month = String(date.getMonth()).padStart(2, '0');
          this.dateTime = `${year}.${month}`;
        } else {
          let date = this.currentDate
          let year = date.getFullYear();
          let month = String(date.getMonth() + 1).padStart(2, '0');
          this.dateTime = `${year}.${month}`;
        }
      } else {
        this.dateTime = this.currentDate.getFullYear() + '年';
      }
    },
    yearConfirm(value) {
      this.currentYear = `${value}`
      this.dateTime = `${value}`
      let year = Number(this.currentYear.replace("年", ""));
      this.currentDate = new Date(year, 1)
      this.yearShow = false
      this.getBillAnalysis()
    },
    yearMonthConfirm(value) {
      this.currentDate = value
      this.yearMonthShow = false
      let year = value.getFullYear();
      let month = String(value.getMonth() + 1).padStart(2, '0');
      this.dateTime = `${year}.${month}`;
      this.getBillAnalysis()
    },
    datePopup() {
      if (this.type === '0') {
        this.yearMonthShow = true;
      } else {
        this.yearShow = true;
      }
    },
    formatter(type, val) {
      if (type === 'year') {
        return `${val}年`;
      } else if (type === 'month') {
        return `${val}月`;
      }
      return val;
    },
    // 切换年月
    changeType(type) {
      if (type === this.type) return
      this.type = type
      this.initDate()
      this.getBillAnalysis()
    },
    getBillAnalysis() {
      let formattedDate = ''
      if (this.type === '0') {
        formattedDate = this.dateTime.replace(".", "-");
      } else {
        formattedDate = this.dateTime.replace("年", "");
      }
      getBillAnalysis({
        dateTime: formattedDate,
        type: this.type
      }).then(res => {
        if (res.data.code === 200) {
          this.analysisDetails = res.data.data
          this.$nextTick(() => {
            let echartsDom = this.$refs.chartRef;
            this.chart = echarts.init(echartsDom)
            let chart = this.chart
            chart.setOption(this.lineChartOption)


            let pieEchartsDom = this.$refs.chartRefPie;
            this.pieChart = echarts.init(pieEchartsDom)
            let pieChart = this.pieChart
            pieChart.setOption(this.pieChartOption)


            // 页面加载完成后显示最后一个点的 tooltip
            setTimeout(() => {
              const dataLength = this.lineChartOption.series[0].data.length;
              const lastIndex = dataLength - 1;

              this.chart.dispatchAction({
                type: 'showTip',
                seriesIndex: 0,  // 系列索引
                dataIndex: lastIndex  // 数据索引（最后一个）
              });
            }, 100);
          })
        }
      })
    },
  }
}
</script>
<style scoped lang="scss">
.app {
  width: 100%;
  min-height: 100vh;
  background-color: #F4F4F4;
}

.main {
  width: 100%;

  .cateogry-list {
    width: 7.1rem;
    background: #FFFFFF;
    border-radius: 0.16rem;
    margin: 0.3rem auto 0.5rem;
    padding-bottom: 0.5rem;

    .item {
      width: 100%;
      display: flex;
      align-items: center;
      padding: 0 0.3rem 0 0.24rem;
      box-sizing: border-box;
      margin-bottom: 0.3rem;

      .item-content {
        flex: 1;
        font-size: 0.26rem;
        color: #222222;
        margin-left: 0.24rem;

        .item-progress {
          width: 4.58rem;
          margin-top: 0.1rem;
        }

        .item-content-info {
          display: flex;
          justify-content: space-between;
        }
      }

      .item-number {
        font-size: .32rem;
        color: #282828;
        font-weight: 700;
      }

      .item-icon {
        width: 0.6rem;
        height: 0.6rem;

      }
    }

    .cateogry-title {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0.24rem 0.3rem 0 0.24rem;
      box-sizing: border-box;
      margin-bottom: 0.3rem;

      span {
        font-size: 0.3rem;
        font-weight: bold;
        color: #222222;

        &:last-child {
          font-size: .32rem;
        }
      }
    }
  }

  .analysis {
    width: 7.14rem;
    height: 11.92rem;
    position: relative;
    margin: 0.32rem auto 0;

    .analysis-bg {
      width: 100%;
      height: 100%;
      position: absolute;
      top: 0;
      left: 0;
    }

    .analysis-content {
      position: relative;

      .chart {
        width: 100%;

        .empty {
          width: 100%;
          display: flex;
          flex-direction: column;
          align-items: center;
          font-size: 0.256rem;
          padding-top: 1.5rem;
          color: #666666;

          .empty-bg {
            width: 1.8rem;
            height: 1.8rem;
            margin-bottom: 0.5rem;
          }
        }

        .chart-line {
          width: 100%;
          height: 3rem;
        }

        .chart-pie {
          width: 100%;
          height: 5rem;
          margin-top: 0.5rem;
        }
      }

      .analysis-title {
        width: 100%;
        display: flex;
        padding-top: 0.7rem;
        margin-bottom: 1rem;

        .item {
          width: 50%;
          display: flex;
          align-items: center;
          justify-content: center;
          flex-direction: column;
          font-size: 0.34rem;
          line-height: 1.5;
          font-weight: 700;
          color: #999;
        }

        .active {
          font-weight: 700;
          color: #222222;
        }
      }
    }
  }

  .title {
    display: flex;
    align-items: center;
    width: 100%;
    background-color: #ffffff;
    color: #222222;
    font-size: 0.24rem;
    padding: 0.24rem 0.42rem;
    font-weight: bold;
    box-sizing: border-box;

    .item {
      margin-right: 0.56rem;

    }

    .date {
      width: 1.26rem;
      height: 0.5rem;
      overflow: hidden;
      border-radius: 0.25rem;
      border: 0.02rem solid #2C70ED;
      box-sizing: border-box;
      margin-left: auto;
      display: flex;

      .date-item {
        width: 50%;
        height: 100%;
        display: flex;
        align-items: center;
        color: #2B71EB;
        justify-content: center;

        &.date-item-month {
          background-color: #2B71EB;
          color: #fff;
        }
      }
    }

    .icon {
      width: 0.14rem;
      height: 0.1rem;
      margin-left: 0.08rem;
    }
  }
}
</style>

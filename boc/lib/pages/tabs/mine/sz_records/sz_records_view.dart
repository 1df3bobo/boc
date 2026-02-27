import 'package:boc/pages/tabs/mine/sz_records/component/item1_widget.dart';
import 'package:boc/utils/color_util.dart';
import 'package:boc/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../config/model/pay_ment_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../other/webview_page/webview_page_view.dart';
import 'component/item2_widget.dart';
import 'component/right_widget.dart';
import 'component/time_widget.dart';
import 'sz_records_logic.dart';
import 'sz_records_state.dart';

class SzRecordsPage extends BaseStateless {
  SzRecordsPage({Key? key}) : super(key: key, title: '收支记录');

  final SzRecordsLogic logic = Get.put(SzRecordsLogic());
  final SzRecordsState state = Get.find<SzRecordsLogic>().state;

  @override
  void onLoading() {
    super.onLoading();
    state.szData.pageNum++;
    if (logic.showRange) {
      logic.getData2();
    } else {
      logic.getData1();
    }
  }

  @override
  bool get enablePullDown => false;

  @override
  get refreshController => state.refreshController;


  @override
  List<Widget>? get rightAction => [
    Image(image: 'ic_ke'.png3x,color: Colors.black,width: 20.w,).withOnTap(onTap: (){
      Get.to(() => WebViewPage(),
          arguments: {'routeName': '/customerService'});
    }),
    SizedBox(width: 15.w,),
    Image(image: 'ic_search_left'.png3x,color: Colors.black,width: 20.w,).withOnTap(onTap: (){
      Get.toNamed(Routes.searchHistoryPage);
    }),
    SizedBox(width: 15.w,),
  ];

  @override
  Widget initBody(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1.sw,
          height: 120.w,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 12.w,
              ),
              Stack(
                children: [
                  Image(image: 'sz_jl_top'.png3x),
                  Row(
                    spacing: 24.w,
                    children: [
                      Container().expanded(onTap: () {
                        Get.to(() => WebViewPage(),
                            arguments: {'routeName': '/analysis'});
                      }),
                      Container().expanded(onTap: () {
                        Get.to(() => WebViewPage(),
                            arguments: {'routeName': '/monthlyBill'});
                      }),
                      Container().expanded(),
                    ],
                  ).withContainer(
                      width: 1.sw,
                      height: 55.w,
                      margin: EdgeInsets.only(left: 24.w, right: 24.w))
                ],
              ),
              SizedBox(
                height: 20.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GetBuilder<SzRecordsLogic>(
                        builder: (_) {
                          DateTime now = DateTime.now();
                          String time = DateFormat('yyyy.MM').format(now);
                          if (state.selectTime != '') {
                            time = state.selectTime;
                          } else {
                            if (state.szData.endTime != '') {
                              time =
                                  '${state.szData.beginTime.replaceAll('-', '/')}-${state.szData.endTime.replaceAll('-', '/')}';
                            } else {
                              time = DateFormat('yyyy.MM').format(now);
                            }
                          }

                          return Row(
                            children: [
                              BaseText(
                                text: time,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Color(0xff222222)),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Image(
                                image: 'xia_01'.png,
                                width: 8.w,
                                height: 8.w,
                              ),
                            ],
                          ).withOnTap(onTap: () {
                            SmartDialog.show(
                              alignment: Alignment.centerRight,
                              builder: (context) {
                                return const TimeWidget();
                              },
                            );
                          });
                        },
                        id: 'updateTime',
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Row(
                        children: [
                          BaseText(
                            text: '全部账户',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff222222)),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Image(
                            image: 'xia_01'.png,
                            width: 8.w,
                            height: 8.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                  GetBuilder<SzRecordsLogic>(
                    builder: (_) {
                      bool sx = false;
                      if (state.szData.maxAmount != '' ||
                          state.szData.minAmount != '' ||
                          state.szData.categorys != '') {
                        sx = true;
                      } else {
                        sx = false;
                      }
                      return Row(
                        children: [
                          BaseText(
                            text: '筛选',
                            fontSize: 13,
                            color: sx ? BColors.mainColor : Color(0xff222222),
                          ),
                          Image(
                            image: 'sx_ic'.png3x,
                            width: 12.w,
                            height: 12.w,
                            color: sx ? BColors.mainColor : Color(0xff222222),
                          )
                        ],
                      ).withOnTap(onTap: () {
                        SmartDialog.show(
                          alignment: Alignment.centerRight,
                          builder: (context) {
                            return const RightSzWidget();
                          },
                        );
                      });
                    },
                    id: 'updatesx',
                  )
                ],
              ).withPadding(
                left: 16.w,
                right: 16.w,
              )
            ],
          ),
        ),
        GetBuilder<SzRecordsLogic>(
          builder: (_) {
            return refreshWidget(
                    child: (logic.showRange
                        ? ListView.separated(
                            controller: state.rangeController,
                            padding: EdgeInsets.only(top: 10.w, bottom: 25.w),
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return Stack(
                                  children: [
                                    Image(image: 'range_sz'.png).withContainer(
                                        width: 1.sw,
                                        height: 106.w,
                                        margin: EdgeInsets.only(
                                            left: 15.w, right: 15.w)),
                                    Positioned(
                                        top: 12.w,
                                        left: 32.w,
                                        child: BaseText(
                                          text: '共${state.rangeModel.total}笔交易',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        )),
                                    Positioned(
                                        left: 30.w,
                                        bottom: 24.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BaseText(
                                              text:
                                                  '收入 ${state.rangeModel.incomeTotal}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            BaseText(
                                              text:
                                                  '支出 ${state.rangeModel.expensesTotal}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ).withSizedBox(width: 1.sw - 60.w))
                                  ],
                                );
                              }
                              PayMentList m = state.rangeList[index -1];
                              return Item2Widget(
                                model: m,
                                expensesTotal: state.expensesTotal.bankBalance,
                                incomeTotal: state.incomeTotal.bankBalance,
                                pages: state.rangeModel.total.toString(),
                              );
                            },
                            itemCount: state.rangeList.length + 1,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Container(
                                width: 1.sw,
                                height: 0.5.w,
                                color: Color(0xffF4F4F4),
                              );
                            },
                          )
                        : ListView.separated(
                            controller: state.controller,
                            padding: EdgeInsets.only(top: 10.w, bottom: 25.w),
                            itemBuilder: (BuildContext context, int index) {
                              PayMentList m = state.list[index];
                              return Item1Widget(model: m);
                            },
                            itemCount: state.list.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Container(
                                width: 1.sw,
                                height: 0.5.w,
                                color: Color(0xffF4F4F4),
                              );
                            },
                          )))
                .expanded();
          },
          id: 'updateUI',
        )
      ],
    );
  }
}

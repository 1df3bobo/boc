import 'package:boc/config/app_config.dart';
import 'package:boc/pages/tabs/home/bill/component/right_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/abc_button.dart';
import '../../../../../utils/color_util.dart';
import '../../../../component/sheet_widget/picker_widget.dart';
import '../bill_logic.dart';
import '../bill_state.dart';

class BillTopWidget extends StatefulWidget {
  const BillTopWidget({super.key});

  @override
  State<BillTopWidget> createState() => _BillTopWidgetState();
}

class _BillTopWidgetState extends State<BillTopWidget> {


  final GlobalKey _containerKey = GlobalKey();
  bool showMask = false;

  final BillLogic logic = Get.find<BillLogic>();
  final BillState state = Get.find<BillLogic>().state;

  List title = ['近一周', '近1月', '近3月'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(8.w),
          height: 68.w,
          color: Colors.white,
          child: Row(
            children: [
              Image(
                image: 'yh_card'.png3x,
                width: 52.w,
                height: 32.w,
              ).withPadding(
                left: 15.w,
                right: 8.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText(
                    text: AppConfig.config.abcLogic.card(),
                    color: Color(0xff222222),
                    fontSize: 15,
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  BaseText(
                    text: '长城电子借记卡 （I类账户）',
                    color: Color(0xff666666),
                    fontSize: 13,
                  ),
                ],
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              key: _containerKey, // 绑定 Key
              onTap: () => _showDropDown(), // 点击触发
              child:  Row(
                children: [
                  GetBuilder<BillLogic>(builder: (_){
                    String time = '';
                    if(state.beginTime == '' && state.endTime == ''){
                      DateTime now = DateTime.now();
                      DateFormat formatter = DateFormat('yyyy.MM');
                      time =  formatter.format(now);
                    }else{
                      time = '${state.beginTime.replaceAll('-', '/')}-${state.endTime.replaceAll('-', '/')}';
                    }
                    return BaseText(
                      text: time,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff222222)),
                    );
                  },id: 'updateTopText',),
                  SizedBox(
                    width: 4.w,
                  ),
                  Image(
                    image: 'xia_01'.png,
                    width: 8.w,
                    height: 8.w,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                BaseText(
                  text: '筛选',
                  fontSize: 13,
                  color: Color(0xff222222),
                ),
                Image(
                  image: 'sx_ic'.png3x,
                  width: 12.w,
                  height: 12.w,
                )
              ],
            ).withOnTap(onTap: () {
              SmartDialog.show(
                alignment: Alignment.centerRight,
                builder: (context) {
                  return const RightBillWidget();
                },
              );
            })
          ],
        ).withContainer(
          height: 38.w,
          padding: EdgeInsets.only(left: 10.w,right: 10.w)
        )
      ],
    );
  }

  void _showDropDown() {
    Future.delayed(const Duration(milliseconds: 200), () {
      showMask = true;
      logic.update(['updateColor']);
    });
    SmartDialog.showAttach(
      targetContext: _containerKey.currentContext,
      maskColor: Colors.transparent,
      onDismiss: () {
        showMask = false;
      },
      builder: (context) {
        return Stack(
          children: [
            GetBuilder<BillLogic>(
              builder: (_) {
                return Container(
                  height: 1.sh - 10.w,
                  width: 1.sw,
                  margin: EdgeInsets.only(top: 10.w),
                  color: Colors.black.withOpacity(showMask ? 0.2 : 0),
                );
              },
              id: 'updateColor',
            ),
            Container(
              width: 1.sw,
              height: 260.w,
              color: Colors.white,
              margin: EdgeInsets.only(top: 10.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.w,
                  ),
                  Container(
                    width: 1.sw,
                    padding: EdgeInsets.only(left: 12.w, top: 6.w, bottom: 12.w),
                    alignment: Alignment.centerLeft,
                    child: BaseText(
                      text: '交易日期',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GetBuilder<BillLogic>(
                    builder: (_) {
                      return VerticalGridView(
                        padding: EdgeInsets.only(left: 12.w, right: 12.w),
                        widgetBuilder: (_, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: state.selectTime == title[index]
                                    ? BColors.mainColor.withOpacity(0.06)
                                    : const Color(0xffF4F4F4),
                                border: Border.all(
                                  color: state.selectTime == title[index]
                                      ? BColors.mainColor
                                      : Colors.white,
                                  width: 1.w,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.w))),
                            alignment: Alignment.center,
                            child: BaseText(
                              text: title[index],
                              style: TextStyle(
                                color: state.selectTime == title[index]
                                    ? BColors.mainColor
                                    : Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                          ).withOnTap(onTap: () {
                            state.selectTime = title[index];
                            state.beginTime = getRangeDate(state.selectTime)['start']??'';
                            state.endTime = getRangeDate(state.selectTime)['end']??'';
                            logic.update(['updateTag']);
                          });
                        },
                        itemCount: title.length,
                        crossCount: 3,
                        mainHeight: 32.w,
                        spacing: 10.w,
                        crossSpacing: 15.w,
                      );
                    },
                    id: 'updateTag',
                  ),
                  SizedBox(height: 20.w),
                  GetBuilder<BillLogic>(
                    builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BaseText(
                            text: state.beginTime != '' ? state.beginTime.replaceAll('-', '/')
                                : '起始日期',
                            textAlign: TextAlign.center,
                            color: Color(0xff333333),
                          ).withContainer(
                            alignment: Alignment.center,
                            height: 32.w,
                            width: (1.sw * 0.88 - 40.w) / 2,
                          ).withOnTap(onTap: () {
                            SmartDialog.show(
                              alignment: Alignment.bottomCenter,
                              builder: (context) {
                                return _pickTime(
                                    dateTimePickerNotifier: state.pickerNotifier1,
                                    showDya: true,
                                    time: state.beginTime,
                                    onConfirm: (){
                                      if(state.beginTime != state.temBeginTime){
                                        state.selectTime = '';
                                        state.beginTime = state.temBeginTime;
                                        logic.update(['updateColor','updateTag']);
                                      }
                                    },
                                    onCancel: (){
                                      state.temBeginTime = state.beginTime;
                                    },
                                    onDateTimeChanged: (date) {
                                      state.selectTime = '';
                                      String time = DateFormat('yyyy-MM-dd').format(date);
                                      state.temBeginTime = time;
                                    });
                              },
                            );
                          }),
                          Container(
                            width: 6.w,
                            height: 1,
                            color: Color(0xff222222),
                          ),
                          BaseText(
                            text: state.endTime != ''
                                ? state.endTime.replaceAll('-', '/')
                                : '终止日期',
                            textAlign: TextAlign.center,
                            color: Color(0xff333333),
                          )
                              .withContainer(
                            alignment: Alignment.center,
                            height: 32.w,
                            width: (1.sw * 0.88 - 40.w) / 2,
                          ).withOnTap(onTap: () {
                            SmartDialog.show(
                              alignment: Alignment.bottomCenter,
                              builder: (context) {
                                return _pickTime(
                                    dateTimePickerNotifier: state.pickerNotifier2,
                                    time: state.endTime,
                                    showDya: true,
                                    onConfirm: (){
                                      if(state.endTime != state.temEndTime){
                                        state.selectTime = '';
                                        state.endTime = state.temEndTime;
                                        logic.update(['updateColor','updateTag']);
                                      }
                                    },
                                    onCancel: (){
                                      state.temEndTime = state.endTime;
                                    },
                                    onDateTimeChanged: (date) {
                                      state.selectTime = '';
                                      String time = DateFormat('yyyy-MM-dd').format(date);
                                      state.temEndTime = time;
                                    });
                              },
                            );
                          }),
                        ],
                      );
                    },
                    id: 'updateTag',
                  ),
                  SizedBox(height: 6.w),
                  Container(
                    width: 1.sw,
                    height: 0.4.w,
                    color: Color(0xffeeeeee),
                  ),
                  SizedBox(height: 15.w),
                  BaseText(
                    text: '单次查询跨度不超过6个月，最早可查询至${
                        getRangeDate('近6月')['start']?.replaceAll('-', '/')
                    }。',
                    style: TextStyle(fontSize: 13, color: Color(0xff6666666)),
                  ),
                  SizedBox(height: 12.w),
                  Row(
                    children: [
                      AbcButton(
                        title: '重置',
                        bgColor: Colors.white,
                        height: 40.w,
                        titleColor: const Color(0xffCF0000),
                        radius: 25.w,
                        margin: EdgeInsets.only(left: 16.w, right: 10.w),
                        border: Border.all(
                            width: 1.w, color: const Color(0xffCF0000)),
                        onTap: () {
                          state.selectTime = '';
                          state.temBeginTime = '';
                          state.temEndTime = '';
                          state.beginTime = '';
                          state.endTime = '';
                          logic.update(['updateColor','updateTag']);
                        },
                      ).expanded(),
                      AbcButton(
                        title: '确认',
                        radius: 25.w,
                        height: 40.w,
                        bgColor: Color(0xffCF0000),
                        margin: EdgeInsets.only(left: 10.w, right: 16.w),
                        onTap: () {
                          showMask = false;
                          logic.update(['updateColor','updateTag','updateTopText']);
                          SmartDialog.dismiss();
                          state.billData.endPageTime = '';
                          state.billData.pageNum = 1;
                          state.billData.beginTime = state.beginTime;
                          state.billData.endTime = state.endTime;
                          logic.getData().then((_){
                            try {
                              state.controller.jumpTo(0);
                            }catch(e){}

                          });
                        },
                      ).expanded(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _pickTime({
    DateTimePickerNotifier? dateTimePickerNotifier,
    ValueChanged<DateTime>? onDateTimeChanged,
    bool showDya = true,
    bool showMonth = true,
    Function? onConfirm,
    Function? onCancel,
    required String time,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.w),
            topRight: Radius.circular(8.w),
          )),
      height: 260.w,
      child: Column(
        children: [
          Container(
            height: 45.w,
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.w),
                  topRight: Radius.circular(8.w),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseText(
                  text: '取消',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ).withOnTap(onTap: () {
                  onCancel?.call();
                  SmartDialog.dismiss();
                }),
                BaseText(
                  text: '确认',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ).withOnTap(onTap: () {
                  onConfirm?.call();
                  SmartDialog.dismiss();
                }),
              ],
            ),
          ),
          Container(
            width: 1.sw,
            height: 210.w,
            child: DateTimePicker(
              dateTimePickerNotifier: dateTimePickerNotifier,
              showDay: showDya,
              showMonth: showMonth,
              lastYear: 8,
              initialDateTime: DateTime.tryParse(time),
              onDateTimeChanged: (DateTime date) {
                onDateTimeChanged?.call(date);
              },
            ),
          )
        ],
      ),
    );
  }

  Map<String, String> getRangeDate(String tag) {
    DateTime now = DateTime.now();
    DateTime endDate = now;
    DateTime startDate;

    switch (tag) {
      case '近一周':
        startDate = now.subtract(const Duration(days: 7));
        break;
      case '近1月':
        startDate = DateTime(now.year, now.month - 1, now.day);
        break;
      case '近3月':
        startDate = DateTime(now.year, now.month - 3, now.day);
        break;
      case '近6月':
        startDate = DateTime(now.year, now.month - 6, now.day);
        break;
      default:
        startDate = now;
    }
    String s = DateFormat('yyyy-MM-dd').format(startDate);
    String e = DateFormat('yyyy-MM-dd').format(endDate);

    return {
      'start': s,
      'end': e,
    };
  }

}

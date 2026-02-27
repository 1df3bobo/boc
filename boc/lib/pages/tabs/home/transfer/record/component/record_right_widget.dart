import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../utils/abc_button.dart';
import '../../../../../../utils/color_util.dart';
import '../../../../../component/sheet_widget/picker_widget.dart';
import '../record_logic.dart';
import '../record_state.dart';

class RecordRightWidget extends StatefulWidget {
  const RecordRightWidget({super.key});

  @override
  State<RecordRightWidget> createState() => _RecordRightWidgetState();
}

class _RecordRightWidgetState extends State<RecordRightWidget> {
  final RecordLogic logic = Get.put(RecordLogic());
  final RecordState state = Get.put(RecordLogic()).state;

  List title1 = [
    '近1周',
    '近1月',
    '近3月',
  ];

  List title2 = ['全部', '交易成功', '交易失败', '银行处理中'];

  Map<String, String> getDateRange(String tag) {
    DateTime now = DateTime.now();
    DateTime startDate;
    DateTime endDate = now; // 默认结束时间为现在

    switch (tag) {
      case '本周':
        startDate = now.subtract(Duration(days: now.weekday - 1));
        break;
      case '本月':
        startDate = DateTime(now.year, now.month, 1);
        break;
      case '本年':
        startDate = DateTime(now.year, 1, 1);
        break;
      case '近1月':
        startDate = now.subtract(const Duration(days: 30));
        break;
      case '近3月':
        startDate = now.subtract(const Duration(days: 90));
        break;
      case '近1年':
        startDate = now.subtract(const Duration(days: 365));
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

  @override
  void initState() {
    super.initState();

    state.temStatus = state.recordData.status == ''?'全部':state.recordData.status;
    state.temBeginTime = state.recordData.beginTime;
    state.temEndTime = state.recordData.endTime;
    state.controller1.text = state.recordData.minAmount;
    state.controller2.text = state.recordData.maxAmount;
    state.controller3.text = state.recordData.oppositeAccount;
  }

  @override
  Widget build(BuildContext context) {
    final navHeight = MediaQuery.of(context).padding.top + 44.w;
    return Container(
      width: 1.sw * 0.88,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: navHeight,
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(
              right: 16.w,
              bottom: 12.w,
            ),
            child: BaseText(
              text: '取消',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: BColors.mainColor),
            ).withOnTap(onTap: () {
              SmartDialog.dismiss();
            }),
          ),
          Container(
            width: 1.sw,
            height: 0.5.w,
            margin: EdgeInsets.only(left: 12.w, right: 12.w),
            color: Color(0xffF4F4F4),
          ),
          ListView(
            padding: EdgeInsets.only(bottom: 45.w),
            children: [
              ..._title1Widget(),
              ..._title2Widget(),
              ..._title3Widget(),
              ..._title4Widget(),
              ..._title5Widget(),
            ],
          ).expanded(),
          Row(
            children: [
              AbcButton(
                title: '重置',
                bgColor: Colors.white,
                titleColor: const Color(0xffCF0000),
                border: Border(
                  top: BorderSide(width: 1.w, color: const Color(0xFFE7E7E7)),
                ),
                onTap: () {
                  state.temStatus = '全部';
                  state.selectTime = '近3月';
                  state.temBeginTime = getDateRange(state.selectTime)['start'] ?? '';
                  state.temEndTime = getDateRange(state.selectTime)['end'] ?? '';
                  state.controller1.text = '';
                  state.controller2.text = '';
                  state.controller3.text = '';
                  setState(() {});
                },
              ).expanded(),
              AbcButton(
                title: '确认',
                bgColor: const Color(0xffCF0000),
                onTap: () {
                  state.recordData.status= state.temStatus == '全部'?'':state.temStatus;
                  state.recordData.beginTime = state.beginTime;
                  state.recordData.endTime = state.endTime;
                  state.recordData.minAmount = state.controller1.text;
                  state.recordData.maxAmount = state.controller2.text;
                  state.recordData.oppositeAccount = state.controller3.text;
                  state.recordData.endPageTime = '';
                  state.recordData.pageNum = 1;
                  logic.update(['updateTagText']);
                  SmartDialog.dismiss();
                  logic.transferPage();
                },
              ).expanded(),
            ],
          ),
          SizedBox(
            height: ScreenUtil().bottomBarHeight,
          )
        ],
      ),
    );
  }

  Widget _titleWidget(String name) {
    return Container(
      width: 1.sw * 0.88,
      padding: EdgeInsets.only(left: 12.w, top: 12.w, bottom: 12.w),
      alignment: Alignment.centerLeft,
      child: BaseText(
        text: name,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  List<Widget> _title1Widget() {
    return [
      _titleWidget('金额区间'),
      VerticalGridView(
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        widgetBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
                color: state.selectTime == title1[index]
                    ? BColors.mainColor.withOpacity(0.06)
                    : const Color(0xffF4F4F4),
                border: Border.all(
                  color: state.selectTime == title1[index]
                      ? BColors.mainColor
                      : Colors.white,
                  width: 1.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6.w))),
            alignment: Alignment.center,
            child: BaseText(
              text: title1[index],
              style: TextStyle(
                color: state.selectTime == title1[index]
                    ? BColors.mainColor
                    : Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ).withOnTap(onTap: () {
            state.selectTime = title1[index];
            state.beginTime = getDateRange(state.selectTime)['start'] ?? '';
            state.endTime = getDateRange(state.selectTime)['end'] ?? '';
            setState(() {});
          });
        },
        itemCount: title1.length,
        crossCount: 3,
        mainHeight: 32.w,
        spacing: 10.w,
        crossSpacing: 15.w,
      ),
      SizedBox(height: 15.w),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BaseText(
            text: state.beginTime != ''
                ? state.beginTime.replaceAll('-', '/')
                : '起始日期',
            textAlign: TextAlign.center,
            color: Color(0xff666666),
          )
              .withSizedBox(
            height: 32.w,
            width: (1.sw * 0.88 - 40.w) / 2,
          )
              .withOnTap(onTap: () {
            SmartDialog.show(
              alignment: Alignment.bottomCenter,
              clickMaskDismiss: false,
              builder: (context) {
                return _pickTime(
                    dateTimePickerNotifier: state.pickerNotifier1,
                    showDya: true,
                    time: state.beginTime,
                    onConfirm: (){
                      if(state.beginTime != state.temBeginTime){
                        state.selectTime = '';
                        state.beginTime = state.temBeginTime;
                        setState(() {});
                      }
                    },
                    onCancel: (){
                      state.temBeginTime = state.beginTime;
                    },
                    onDateTimeChanged: (date) {
                      state.selectTime = '';
                      String time = DateFormat('yyyy-MM-dd').format(date);
                      state.temBeginTime = time;
                      setState(() {});
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
            color: Color(0xff666666),
          )
              .withSizedBox(
            height: 32.w,
            width: (1.sw * 0.88 - 40.w) / 2,
          ).withOnTap(onTap: () {
            SmartDialog.show(
              alignment: Alignment.bottomCenter,
              clickMaskDismiss: false,
              builder: (context) {
                return _pickTime(
                    dateTimePickerNotifier: state.pickerNotifier2,
                    time: state.temEndTime,
                    showDya: true,
                    onConfirm: (){
                      if(state.endTime != state.temEndTime){
                        state.selectTime = '';
                        state.endTime = state.temEndTime;
                        setState(() {});
                      }
                    },
                    onCancel: (){
                      state.temEndTime = state.endTime;
                    },
                    onDateTimeChanged: (date) {

                      String time = DateFormat('yyyy-MM-dd').format(date);
                      state.temEndTime = time;
                      setState(() {});
                    });
              },
            );
          }),
        ],
      ),
      SizedBox(height: 15.w),
    ];
  }

  List<Widget> _title2Widget() {
    return [
      Container(
        width: 1.sw * 0.88,
        height: 0.8.w,
        color: Color(0xffdedede),
      ),
      SizedBox(height: 15.w),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BaseText(
            text: '付款账户',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              BaseText(text: '全部账户'),
              Icon(
                Icons.navigate_next,
                size: 20.w,
              )
            ],
          ),
        ],
      ).withPadding(
        left: 12.w,
        right: 12.w,
      ),
      SizedBox(height: 15.w),
      Container(
        width: 1.sw * 0.88,
        height: 0.8.w,
        color: Color(0xffdedede),
      ),
    ];
  }

  List<Widget> _title3Widget() {
    return [
      SizedBox(height: 15.w),
      _titleWidget('金额范围'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFieldWidget(
            textAlign: TextAlign.center,
            hintText: '0.00',
            controller: state.controller1,
            onChanged: (v) {
              setState(() {});
            },
          ).withSizedBox(
            height: 32.w,
            width: (1.sw * 0.88 - 40.w) / 2,
          ),
          Container(
            width: 6.w,
            height: 1,
            color: Color(0xff222222),
          ),
          TextFieldWidget(
            textAlign: TextAlign.center,
            hintText: '99,999,999999.99',
            controller: state.controller2,
            onChanged: (v) {
              setState(() {});
            },
          ).withSizedBox(
            height: 32.w,
            width: (1.sw * 0.88 - 40.w) / 2,
          ),
        ],
      ),
      SizedBox(height: 6.w),
      Container(
        width: 1.sw * 0.88,
        height: 0.8.w,
        color: Color(0xffdedede),
      ),
    ];
  }

  List<Widget> _title4Widget() {
    return [
      SizedBox(height: 15.w),
      _titleWidget('收款人'),
      TextFieldWidget(
        textAlign: TextAlign.center,
        hintText: '请输入收款人姓名/账号/手机号',
        controller: state.controller3,
        onChanged: (v) {
          setState(() {});
        },
      ).withSizedBox(
        height: 32.w,
        width: 1.sw * 0.88,
      ),
      SizedBox(height: 6.w),
      Container(
        width: 1.sw * 0.88,
        height: 0.8.w,
        color: Color(0xffdedede),
      ),
    ];
  }

  List<Widget> _title5Widget() {
    return [
      _titleWidget('交易状态'),
      VerticalGridView(
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        widgetBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
                color: state.temStatus == title2[index]
                    ? BColors.mainColor.withOpacity(0.06)
                    : const Color(0xffF4F4F4),
                border: Border.all(
                  color: state.temStatus == title2[index]
                      ? BColors.mainColor
                      : Colors.white,
                  width: 1.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6.w))),
            alignment: Alignment.center,
            child: BaseText(
              text: title2[index],
              style: TextStyle(
                color: state.temStatus == title2[index]
                    ? BColors.mainColor
                    : Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ).withOnTap(onTap: () {
            state.temStatus = title2[index];
            setState(() {});
          });
        },
        itemCount: title2.length,
        crossCount: 2,
        mainHeight: 32.w,
        spacing: 10.w,
        crossSpacing: 15.w,
      ),
      SizedBox(height: 15.w),
    ];
  }

  Widget _pickTime({
    DateTimePickerNotifier? dateTimePickerNotifier,
    ValueChanged<DateTime>? onDateTimeChanged,
    bool showDya = true,
    bool showMonth = true,
    required String time,
    Function? onConfirm,
    Function? onCancel,
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
}

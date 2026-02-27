import 'package:boc/pages/tabs/mine/sz_records/search_list/search_list_logic.dart';
import 'package:boc/pages/tabs/mine/sz_records/search_list/search_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/abc_button.dart';
import '../../../../../utils/color_util.dart';
import '../../../../../utils/time_tool.dart';
import '../../../../component/sheet_widget/picker_widget.dart';
import '../sz_records_logic.dart';
import '../sz_records_state.dart';

class SearchTimeWidget extends StatefulWidget {
  const SearchTimeWidget({super.key});

  @override
  State<SearchTimeWidget> createState() => _SearchTimeWidgetState();
}

class _SearchTimeWidgetState extends State<SearchTimeWidget> {
  List title1 = [
    '本月',
    '本年',
  ];
  List title2 = [
    '近1月',
    '近3月',
    '近1年',
  ];

  final SearchListLogic logic = Get.find<SearchListLogic>();
  final SearchListState state = Get.find<SearchListLogic>().state;

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();


  Map<String, String> getDateRange(String tag) {
    DateTime now = DateTime.now();
    DateTime startDate;
    DateTime endDate = now; // 默认结束时间为现在

    switch (tag) {
      case '本月':
        // 本月第一天 00:00:00
        startDate = DateTime(now.year, now.month, 1);
        break;
      case '本年':
        // 本年第一天 01-01 00:00:00
        startDate = DateTime(now.year, 1, 1);
        break;
      case '近1月':
        // 当前时间减去 30 天（或者减去一个月）
        startDate = now.subtract(const Duration(days: 30));
        break;
      case '近3月':
        startDate = now.subtract(const Duration(days: 90));
        break;
      case '近1年':
        // 当前时间减去 365 天
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
              _titleWidget('交易日期'),
              ..._title1Widget(),
              _titleWidget('交易年月'),
              ..._title2Widget(),
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
                  DateTime now = DateTime.now();
                  state.beginTime = DateFormat('yyyy-MM-dd').format(now);
                  state.endTime = '';
                  state.showSelectTime= false;
                  state.selectTime = '';
                  state.temTimeYTitle = '';
                  state.temTimeMTitle = '';
                  setState(() {});
                },
              ).expanded(),
              AbcButton(
                title: '确认',
                bgColor: Color(0xffCF0000),
                onTap: () {
                  SmartDialog.dismiss();
                  state.searchData.beginTime = state.beginTime;
                  state.searchData.endTime = state.endTime;
                  logic.timeFilter();
                  logic.update(['updateTime']);
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
      width: 1.sw,
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
            state.showSelectTime = true;
            state.selectTime = title1[index];
            state.temTimeYTitle = '';
            state.temTimeMTitle = '';
            state.beginTime = getDateRange(state.selectTime)['start']??'';
            state.endTime = getDateRange(state.selectTime)['end']??'';
            setState(() {});
          });
        },
        itemCount: title1.length,
        crossCount: 3,
        mainHeight: 32.w,
        spacing: 10.w,
        crossSpacing: 15.w,
      ),
      SizedBox(
        height: 15.w,
      ),
      VerticalGridView(
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        widgetBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
                color: state.selectTime == title2[index]
                    ? BColors.mainColor.withOpacity(0.06)
                    : const Color(0xffF4F4F4),
                border: Border.all(
                  color: state.selectTime == title2[index]
                      ? BColors.mainColor
                      : Colors.white,
                  width: 1.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6.w))),
            alignment: Alignment.center,
            child: BaseText(
              text: title2[index],
              style: TextStyle(
                color: state.selectTime == title2[index]
                    ? BColors.mainColor
                    : Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ).withOnTap(onTap: () {
            state.showSelectTime = true;
            state.selectTime = title2[index];
            state.temTimeYTitle = '';
            state.temTimeMTitle = '';
            state.beginTime = getDateRange(state.selectTime)['start']??'';
            state.endTime = getDateRange(state.selectTime)['end']??'';

            setState(() {});
          });
        },
        itemCount: title2.length,
        crossCount: 3,
        mainHeight: 32.w,
        spacing: 10.w,
        crossSpacing: 15.w,
      ),
      SizedBox(height: 30.w),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BaseText(
            text: (state.showSelectTime && state.beginTime != '')
                ? state.beginTime.replaceAll('-', '/')
                : '起始日期',
            textAlign: TextAlign.center,
            color: Color(0xff666666),
          ).withSizedBox(
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
                      state.beginTime = state.temBeginTime1;
                      setState(() {});
                    },
                    onCancel: (){
                      state.temBeginTime1 = state.beginTime;
                    },
                    onDateTimeChanged: (date) {
                      state.showSelectTime = true;
                      state.selectTime = '';
                      String time = DateFormat('yyyy-MM-dd').format(date);
                      state.temBeginTime1 = time;
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
            text: (state.showSelectTime && state.endTime != '')
                ? state.endTime.replaceAll('-', '/')
                : '终止日期',
            textAlign: TextAlign.center,
            color: Color(0xff666666),
          ).withSizedBox(
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
                      state.endTime = state.temEndTime1;
                      setState(() {});
                    },
                    onCancel: (){
                      state.temEndTime1 = state.endTime;
                    },
                    onDateTimeChanged: (date) {
                      state.selectTime = '';
                      state.showSelectTime = true;
                      String time = DateFormat('yyyy-MM-dd').format(date);
                      state.temEndTime1 = time;
                    });
              },
            );
          }),
        ],
      ),
      SizedBox(height: 15.w),
      BaseText(
        text: '查询时间跨度不能大于12个月',
        style: TextStyle(color: Color(0xff666666), fontSize: 13),
      ).withContainer(
        alignment: Alignment.center,
        width: 1.sw * 0.88,
      ),
      SizedBox(height: 15.w),
    ];
  }

  List<Widget> _title2Widget() {
    return [
      SizedBox(height: 10.w),
      Container(
        width: 1.sw,
        height: 0.8,
        color: Color(0xffF4F4F4),
      ),
      Container(
        width: 1.sw,
        height: 45.w,
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseText(text: '按月份选择'),
            Row(
              children: [
                BaseText(
                  text: state.temTimeMTitle == '' ? '请选择' : state.temTimeMTitle,
                  color: Color(0xff666666),
                ),
                Icon(
                  Icons.navigate_next,
                  size: 20.w,
                )
              ],
            )
          ],
        ).withOnTap(onTap: () {
          SmartDialog.show(
            alignment: Alignment.bottomCenter,
            builder: (context) {
              return _pickTime(
                  dateTimePickerNotifier: state.mPickerNotifier,
                  time: state.beginTime,
                  showDya: false,
                  onDateTimeChanged: (date) {
                    state.selectTime = '';
                    state.showSelectTime = false;
                    state.temTimeMTitle = DateFormat("yyyy年MM月").format(date);
                    state.temTimeYTitle = '';
                    String currentMonth = DateFormat('yyyy-MM').format(date);
                    var result1 =
                        DateUtils1.getFormattedFirstAndLastDay(currentMonth);
                    state.beginTime = result1['firstDay'] ?? '';
                    state.endTime = result1['lastDay'] ?? '';
                    setState(() {});
                  });
            },
          );
        }),
      ),
      Container(
        width: 1.sw,
        height: 0.8,
        color: Color(0xffF4F4F4),
      ),
      Container(
        width: 1.sw,
        height: 45.w,
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BaseText(text: '按年份选择'),
            Row(
              children: [
                BaseText(
                  text: state.temTimeYTitle == '' ? '请选择' : state.temTimeYTitle,
                  color: Color(0xff666666),
                ),
                Icon(
                  Icons.navigate_next,
                  size: 20.w,
                )
              ],
            )
          ],
        ),
      ).withOnTap(onTap: () {
        SmartDialog.show(
          alignment: Alignment.bottomCenter,
          builder: (context) {
            return _pickTime(
                dateTimePickerNotifier: state.yPickerNotifier,
                time: state.beginTime,
                showDya: false,
                showMonth: false,
                onDateTimeChanged: (date) {
                  state.selectTime = '';
                  state.showSelectTime = false;
                  state.temTimeYTitle = DateFormat("yyyy年").format(date);
                  state.temTimeMTitle = '';
                  String currentMonth = DateFormat('yyyy-MM').format(date);
                  var result1 =
                      DateUtils1.getFormattedFirstAndLastDay(currentMonth);
                  state.beginTime = result1['firstDay'] ?? '';
                  state.endTime = result1['lastDay'] ?? '';
                  setState(() {});
                });
          },
        );
      }),
      Container(
        width: 1.sw,
        height: 0.8,
        color: Color(0xffF4F4F4),
      ),
    ];
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
}

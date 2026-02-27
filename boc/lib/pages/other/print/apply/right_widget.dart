import 'package:boc/utils/abc_button.dart';
import 'package:boc/utils/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'apply_logic.dart';
import 'apply_state.dart';

class RightWidget extends StatefulWidget {
  const RightWidget({super.key});

  @override
  State<RightWidget> createState() => _RightWidgetState();
}

class _RightWidgetState extends State<RightWidget> {
  List title = ['近3月', '近6月', '近1年'];

  String selectTitle = '近1年';

  String beginTime = '';
  String endTime = '';


  final ApplyLogic logic = Get.put(ApplyLogic());
  final ApplyState state = Get.find<ApplyLogic>().state;

  @override
  void initState() {
    super.initState();
    beginTime = state.reqPrint.beginTime;
    endTime = state.reqPrint.endTime;
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
            ),
          ),
          Container(
            width: 1.sw,
            height: 0.5.w,
            margin: EdgeInsets.only(left: 12.w, right: 12.w),
            color: Color(0xffF4F4F4),
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                width: 1.sw,
                padding: EdgeInsets.only(left: 12.w, top: 12.w, bottom: 12.w),
                alignment: Alignment.centerLeft,
                child: BaseText(
                  text: '交易时间',
                  fontSize: 15,
                ),
              ),
              VerticalGridView(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                widgetBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: selectTitle == title[index]
                            ? BColors.mainColor.withOpacity(0.1)
                            : const Color(0xffF7F7F9),
                        borderRadius: BorderRadius.all(Radius.circular(6.w))),
                    alignment: Alignment.center,
                    child: BaseText(
                      text: title[index],
                      style: TextStyle(
                        color: selectTitle == title[index]
                            ? BColors.mainColor
                            : Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                  ).withOnTap(onTap: () {
                    selectTitle = title[index];
                    beginTime = state.getTimeRange(selectTitle).first;
                    endTime = state.getTimeRange(selectTitle).last;
                    setState(() {});
                  });
                },
                itemCount: title.length,
                crossCount: 3,
                mainHeight: 32.w,
                spacing: 10.w,
                crossSpacing: 15.w,
              ),
              SizedBox(
                height: 15.w,
              ),
              Container(
                width: 1.sw,
                height: 0.5.w,
                margin: EdgeInsets.only(left: 12.w, right: 12.w),
                color: Color(0xffF4F4F4),
              ),
              SizedBox(
                height: 15.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // '${state.reqPrint.beginTime.replaceAll('-', '/')}至${state.reqPrint.endTime.replaceAll('-', '/')}',
                  BaseText(
                    text: beginTime.replaceAll('-', '/'),
                    style: TextStyle(fontSize: 13, color: Color(0xff222222)),
                  ),
                  Container(
                    width: 6.w,
                    height: 1,
                    color: Color(0xff222222),
                  ),
                  BaseText(
                    text: endTime.replaceAll('-', '/'),
                    style: TextStyle(fontSize: 13, color: Color(0xff222222)),
                  ),
                ],
              ),
              SizedBox(
                height: 15.w,
              ),
              Container(
                width: 1.sw,
                height: 0.5.w,
                margin: EdgeInsets.only(left: 12.w, right: 12.w),
                color: Color(0xffF4F4F4),
              ),
              SizedBox(
                height: 15.w,
              ),
              BaseText(
                text: '支持开立时间十年内且跨度不超过一年的交易记录',
                style: TextStyle(color: Color(0xff666666), fontSize: 13),
              ).withPadding(
                left: 12.w
              )
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
                onTap: (){
                  beginTime = state.getTimeRange('近1年').first;
                  endTime = state.getTimeRange('近1年').last;
                },
              ).expanded(),
              AbcButton(title: '确认',bgColor: Color(0xffCF0000),onTap: (){
                SmartDialog.dismiss();
                state.reqPrint.beginTime = beginTime;
                state.reqPrint.endTime = endTime;
                logic.update(['updateTime']);
              },).expanded(),
            ],
          ),
          SizedBox(
            height: ScreenUtil().bottomBarHeight,
          )
        ],
      ),
    );
  }
}

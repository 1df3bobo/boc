import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'sz_detail_logic.dart';
import 'sz_detail_state.dart';

class SzDetailPage extends BaseStateless {
  SzDetailPage({Key? key}) : super(key: key, title: '明细');

  final SzDetailLogic logic = Get.put(SzDetailLogic());
  final SzDetailState state = Get.find<SzDetailLogic>().state;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: 1.sw,
          color: Colors.white,
          padding: EdgeInsets.only(
            left: 15.w,
            top: 15.w,
            right: 15.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text: '${state.model.type == '1' ? '收入' : '支出'}金额 (人民币元)',
                style: const TextStyle(color: Color(0xff666666), fontSize: 14),
              ),
              SizedBox(height: 20.w),
              BaseText(
                text: state.model.amount.bankBalance,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff222222)),
              ),
              SizedBox(height: 20.w),
            ],
          ),
        ),
        ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              String e = state.titles[index];
              if (e == '')
                return SizedBox(
                  width: 1.sw,
                  height: 8.w,
                );
              if (e == 'text')
                return Container(
                  width: 1.sw,
                  height: 32.w,
                  alignment: Alignment.centerLeft,
                  color: const Color(0xFFF5F5F5),
                  padding: EdgeInsets.only(left: 15.w),
                  child: BaseText(
                    text: '涝可修改分类、备注、所属账本、交易对象和计入收支情况',
                    fontSize: 11,
                    color: Color(0xff999999),
                  ),
                );
              // if(logic.valueStr(e) == '') return const SizedBox.shrink();
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BaseText(
                    text: e,
                    fontSize: 13,
                    maxLines: 2,
                    color: Color(0xff666666),
                  ).withContainer(
                    width: 65.w,
                  ),
                  SizedBox(
                    width: 52.w,
                  ),
                  state.titles2.contains(e)
                      ? Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BaseText(
                                text: logic.valueStr(e),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp),
                              ),
                              _titles2Widget(e),
                            ],
                          ),
                        ).expanded()
                      : Container(
                          child: BaseText(
                            text: logic.valueStr(e),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13.sp),
                          ),
                        ).expanded()
                ],
              ).withContainer(
                  padding: EdgeInsets.only(
                    top: 10.w,
                    bottom: 10.w,
                    left: 15.w,
                    right: 15.w,
                  ),
                  color: Colors.white);
            },
            separatorBuilder: (context, index) {
              return state.titles2.contains(state.titles[index])
                  ? Container(
                      width: 1.sw,
                      height: 0.5.w,
                      color: Color(0xffdedede),
                    )
                  : const SizedBox.shrink();
            },
            itemCount: state.titles.length),

        Image(image: 'sz_b_bg'.png3x),
        SizedBox(height: 45.w),
      ],
    );
  }

  Widget _titles2Widget(String name) {
    if (name == '分类') {
      return BaseText(
        text: '修改',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
            color: Colors.blueAccent),
      );
    }
    if (name == '交易备注') {
      return BaseText(
        text: '修改',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
            color: Colors.blueAccent),
      );
    }
    if (name == '所属账本') {
      return BaseText(
        text: '选择账本',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
            color: Colors.blueAccent),
      );
    }
    if (name == '交易对象') {
      return BaseText(
        text: '修改',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
            color: Colors.blueAccent),
      );
    }
    if (name == '计入收支') {
      return Obx(() => CupertinoSwitch(
          value: logic.noShow.value,
          // activeTrackColor: Color.fromARGB(255, 3, 134, 91),
          activeColor: Color(0xff2F805A),
          onChanged: (bool value) {
            logic.noShow.value = value;
          }).withContainer(
        height: 25
      )).sw(scale: 1);
    }
    return const SizedBox.shrink();
  }
}

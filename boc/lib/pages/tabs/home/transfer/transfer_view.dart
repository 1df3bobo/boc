import 'dart:math' as math;

import 'package:boc/pages/tabs/home/transfer/transfer_contacts_widget.dart';
import 'package:flutter/material.dart';
import 'package:boc/utils/stack_position.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'transfer_logic.dart';
import 'transfer_state.dart';

class TransferPage extends BaseStateless {
  TransferPage({Key? key}) : super(key: key, title: '转账汇款');

  final TransferLogic logic = Get.put(TransferLogic());
  final TransferState state = Get.find<TransferLogic>().state;

  @override
  bool get isChangeNav => true;

  @override
  Color? get titleColor => Color(0xff111111);

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    StackPosition position1 = StackPosition(
        designWidth: 1080, designHeight: 246, deviceWidth: 1.sw);
    StackPosition position2 = StackPosition(
        designWidth: 1080, designHeight: 420, deviceWidth: 1.sw);
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            Image(image: 'bg_zh'.png3x),
            Positioned(
                bottom: 75.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: state.titles.map((e) {
                    return Column(
                      children: [
                        Image(
                          image: logic.imagePath(e).png3x,
                          height: 42.w,
                        ),
                        BaseText(text: e)
                      ],
                    ).withOnTap(onTap: () => logic.jumpPage(e));
                  }).toList(),
                ).withContainer(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w),
                  width: 1.sw,
                )),
            Positioned(
                bottom: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: state.titles1.map((e) {
                    return Row(
                      spacing: 9.w,
                      children: [
                        Image(
                          image: logic.imagePath(e).png3x,
                          height: 16.w,
                        ),
                        BaseText(text: e)
                      ],
                    ).withOnTap(onTap: () => logic.jumpPage(e));
                  }).toList(),
                ).withContainer(
                    padding: EdgeInsets.only(left: 12.w, right: 12.w),
                    width: 1.sw,
                    height: 52.w,
                    alignment: Alignment.center))
          ],
        ),
        Stack(
          children: [
            Obx(() => state.zzJtRotated.value
                ? Stack(
                    children: [
                      Image(image: 'zh_f_1'.png3x),
                      VerticalGridView(
                        padding:
                            EdgeInsets.only(left: 16.w, right: 16.w, top: 12.w),
                        widgetBuilder: (_, index) {
                          return SizedBox(width: 1.sw/4, height: position1.getHeight(180),).withOnTap(onTap: () => logic.jumpTag(index));
                        },
                        itemCount: 4,
                        crossCount: 4,
                        mainHeight: position1.getHeight(180),
                      ).withPadding(right: 20.w)
                    ],
                  )
                : Stack(
                    children: [
                      Image(image: 'zh_f_2'.png3x),
                      VerticalGridView(
                        padding:
                            EdgeInsets.only(left: 16.w, right: 16.w, top: 12.w),
                        widgetBuilder: (_, index) {
                           return SizedBox(width: 1.sw/4, height: position2.getHeight(180)).withOnTap(onTap: () => logic.jumpTag(index));
                        },
                        itemCount: 6,
                        crossCount: 4,
                        mainHeight: position1.getHeight(180),
                      ).withPadding(right: 20.w)
                    ],
                  )),
            Positioned(
              right: 0.w,
              top: 10.w,
              child: Container(
                width: 25.w,
                height: 70.w,
              ).withOnTap(onTap: (){
                logic.toggleZzJtRotation();
              })
            )
          ],
        ),
        TransferContactsWidget(),
      ],
    );
  }
}

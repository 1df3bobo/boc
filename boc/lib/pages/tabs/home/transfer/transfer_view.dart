import 'package:boc/pages/tabs/home/transfer/transfer_contacts_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'transfer_logic.dart';
import 'transfer_state.dart';

class TransferPage extends BaseStateless {
  TransferPage({Key? key}) : super(key: key,title: '转账汇款');

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
            Stack(
              children: [
                Image(image: 'zh_f'.png3x),
                VerticalGridView(
                  padding: EdgeInsets.only(left: 16.w,right: 16.w,top: 12.w),
                  widgetBuilder: (_, index) {
                    return SizedBox(
                      width: 45.w,
                      height: 45.w).withOnTap(onTap: () => logic.jumpTag(index));
                  },
                  itemCount: 6,
                  crossCount: 4,
                  mainHeight: 65.w,
                  spacing: 12.w,
                ).withPadding(
                  right: 20.w
                )
              ],
            ),
            Positioned(
              right: 10.w,top: 28.w,
              child: Image(
                width: 18.w,
                height: 54.w,
                image: 'zz_jt'.png3x,
              ),
            )
          ],
        ),
        TransferContactsWidget(),
      ],
    );
  }
}

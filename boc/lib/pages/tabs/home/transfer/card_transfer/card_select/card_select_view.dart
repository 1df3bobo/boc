import 'package:boc/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'card_select_logic.dart';
import 'card_select_state.dart';

class CardSelectPage extends BaseStateless {
  CardSelectPage({Key? key}) : super(key: key, title: '选择账户');

  final CardSelectLogic logic = Get.put(CardSelectLogic());
  final CardSelectState state = Get.find<CardSelectLogic>().state;

  @override
  List<Widget>? get rightAction => [];

  @override
  Widget initBody(BuildContext context) {
    return Container(
      color: Color(0XFFF2F3F5),
      height: 1.sh,
      width: 1.sw,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 15.w, horizontal: 8.w),
            height: 68.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.w),
            ),
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
                      text: '长城电子借记卡',
                      color: Color(0xff666666),
                      fontSize: 13,
                    ),
                  ],
                )
              ],
            ),
          ).withOnTap(onTap: () {
            Get.back();
          })
        ],
      ),
    );
  }
}

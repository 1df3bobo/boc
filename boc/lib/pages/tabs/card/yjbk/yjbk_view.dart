import 'package:boc/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'yjbk_logic.dart';
import 'yjbk_state.dart';

class YjbkPage extends BaseStateless {
  YjbkPage({Key? key}) : super(key: key,title: '一键绑卡');

  final YjbkLogic logic = Get.put(YjbkLogic());
  final YjbkState state = Get.find<YjbkLogic>().state;


  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            Image(image: 'yjbk_bg'.png3x),

            Positioned(
                top: 180.w,
                left: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(text: AppConfig.config.abcLogic.card()),
                SizedBox(height: 5.w,),
                BaseText(text: '长城电子借记卡 （II类账户）')
              ],
            ))
          ],
        )
      ],
    );
  }
}

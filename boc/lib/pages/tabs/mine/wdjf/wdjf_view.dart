import 'package:boc/config/app_config.dart';
import 'package:boc/utils/stack_position.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'wdjf_logic.dart';
import 'wdjf_state.dart';

class WdjfPage extends StatelessWidget {
  WdjfPage({Key? key}) : super(key: key);

  final WdjfLogic logic = Get.put(WdjfLogic());
  final WdjfState state = Get.find<WdjfLogic>().state;


  Widget build(BuildContext context) {
    StackPosition position =
        StackPosition(designWidth: 1080, designHeight: 2791, deviceWidth: 1.sw);
    return Scaffold(
        backgroundColor: const Color(0xFFF2F2F5),
        body: Container(
          width: 1.sw,
          height: 1.sh,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  Image(
                    image: 'wdjf'.png3x,
                    width: 1.sw,
                    fit: BoxFit.fitWidth,
                  ).withOnTap(onTap: (){
                    Get.back();
                  }),
                  Positioned(
                      top: position.getY(400),
                      left: position.getX(275),
                      child: BaseText(
                        text: AppConfig.config.abcLogic.memberInfo.points
                            .toStringAsFixed(2),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.w,
                            color: Color(0xFFDB7C4F)),
                      ))
                ],
              )
            ],
          ),
        )
    );
  }
}

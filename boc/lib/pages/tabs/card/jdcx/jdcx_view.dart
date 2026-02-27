import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../utils/color_util.dart';
import 'jdcx_logic.dart';
import 'jdcx_state.dart';

class JdcxPage extends BaseStateless {
  JdcxPage({Key? key}) : super(key: key,);

  final JdcxLogic logic = Get.put(JdcxLogic());
  final JdcxState state = Get.find<JdcxLogic>().state;

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1.sw,
          height: 42.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: state.titles.map((String name) {
              int index = state.titles.indexOf(name);
              return Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText(
                    text: name,
                    style: TextStyle(
                        color: logic.selectTitle.value == index
                            ? BColors.mainColor
                            : Color(0xff666666),
                        fontSize:
                        logic.selectTitle.value == index ? 15 : 15),
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  Container(
                    width: 16.w,
                    height: 2.w,
                    decoration: BoxDecoration(
                        color: logic.selectTitle.value == index
                            ? BColors.mainColor
                            : Color(0xFFF5F5F5),
                        borderRadius:
                        BorderRadius.all(Radius.circular(4.w))),
                  )
                ],
              ).withOnTap(onTap: () {
                logic.selectTitle.value = index;
              }));
            }).toList(),
          ),
        ),
        Container(
          width: 1.sw,
          height: 0.5.w,
          color: Color(0xffdedede),
        ),
        Image(image: 'sqk'.png)
      ],
    );
  }
}

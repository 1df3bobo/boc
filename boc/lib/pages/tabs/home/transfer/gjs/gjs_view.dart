import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import 'gjs_logic.dart';
import 'gjs_state.dart';

class GjsPage extends BaseStateless {
  GjsPage({Key? key}) : super(key: key);

  final GjsLogic logic = Get.put(GjsLogic());
  final GjsState state = Get.find<GjsLogic>().state;

  @override
  bool get isShowAppBar => false;


  @override
  Widget initBody(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1.sw,
          height: ScreenUtil().statusBarHeight,
        ),
        ListView(
          padding: EdgeInsets.only(top: (Get.arguments?['top'] ?? 0).toDouble()),
          children: [
            Image(
              image:  'gjs_bg'.png3x,
              fit: BoxFit.fitWidth,
              width: 1.sw,
            ).withOnTap(onTap: (){
              Get.back();
            }),
          ],
        ).expanded()
      ],
    );
  }
}

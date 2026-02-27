import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import 'cpjh_logic.dart';
import 'cpjh_state.dart';

class CpjhPage extends BaseStateless {
  CpjhPage({Key? key}) : super(key: key,title: '选择账户');

  final CpjhLogic logic = Get.put(CpjhLogic());
  final CpjhState state = Get.find<CpjhLogic>().state;


  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Image(image: 'xzzh'.png).withPadding(
          top: 100.w
        ),
      ],
    );
  }
}

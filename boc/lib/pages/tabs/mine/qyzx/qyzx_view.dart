import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import 'qyzx_logic.dart';
import 'qyzx_state.dart';


class QyzxPage extends StatelessWidget {
  QyzxPage({Key? key}) : super(key: key);

  final QyzxLogic logic = Get.put(QyzxLogic());
  final QyzxState state = Get.find<QyzxLogic>().state;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image(
              image: "qyzx_${index + 1}".png3x,
              width: 1.sw,
              height: 1.sh,
              fit: BoxFit.fill,
            ).withOnTap(onTap: () {
              Get.back();
            });
          },
          itemCount: 4,
        ).withContainer(
          width: 1.sw,
          height: 1.sh,
          color: Colors.white,
          padding: EdgeInsets.zero,
        )
      );
  }
}

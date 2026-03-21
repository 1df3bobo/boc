import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:boc/utils/common_right_button.dart';
import 'package:boc/utils/stack_position.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:boc/config/app_config.dart';

import 'ckgl_logic.dart';
import 'ckgl_state.dart';

class CkglPage extends BaseStateless {
  CkglPage({Key? key}) : super(key: key, title: '存款管理');

  final CkglLogic logic = Get.put(CkglLogic());
  final CkglState state = Get.find<CkglLogic>().state;

  @override
  Color? get background => Colors.white;

  @override
  List<Widget>? get rightAction => [
        CommonNavButtonUtil.image(
          imgPath: 'ic_ke',
          rightPadding: 12.w,
        ),
      ];

  @override
  Widget initBody(BuildContext context) {
    StackPosition position1 =
        StackPosition(designWidth: 1080, designHeight: 3752, deviceWidth: 1.sw);
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Obx(() => Stack(
              children: [
                Image(
                  image: 'ckgl'.png3x,
                  width: 1.sw,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                    top: position1.getY(90),
                    left: position1.getX(490),
                    child: Image(
                      image: logic.eyeOpen.value
                          ? 'ckgl_eye_open'.png3x
                          : 'ckgl_eye_close'.png3x,
                      width: 20.w,
                    ).withOnTap(onTap: () {
                      logic.eyeOpen.value = !logic.eyeOpen.value;
                    })),
                Positioned(
                  top: position1.getY(170),
                  left: position1.getX(90),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BaseText(
                        text: !logic.eyeOpen.value
                            ? '******'
                            : '¥${AppConfig.config.abcLogic.balance()}',
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff5d3616)),
                      ),
                      Image(
                        image: "ckgl_arrow".png3x,
                        width: 5.w,
                      ).withPadding(left: 10.w)
                    ],
                  ),
                ),
                Positioned(
                    right: 25.w,
                    top: 25.w,
                    child: Container(
                      width: 30.w,
                      height: 20.w,
                    ).withOnTap(onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierColor: Colors.black.withOpacity(0.5),
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding:
                                EdgeInsets.symmetric(horizontal: 20.w),
                            child: GestureDetector(
                              onTap: () => Get.back(),
                              child: Image(
                                image: 'ckgl_sheet'.png3x,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          );
                        },
                      );
                    }))
              ],
            ))
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import 'fuzai_state.dart';

class FuzaiLogic extends GetxController {
  final FuzaiState state = FuzaiState();

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(milliseconds: 500),(){
      SmartDialog.show(
        alignment: Alignment.bottomCenter,
        builder: (context) {
          return Image(image: 'game1'.png).withOnTap(onTap: (){
            '该服务由中银金融科技(苏州)有限公司提供技术支持，相关技术服务和责任由该第三方承担。若有疑问，请致电客服电话400-686-9603或95566'.dialog(
              title: '免责声明',
              showCancel: false,
              contentAlign: TextAlign.start,
              contentStyle: const TextStyle(
                color: Color(0xff666666)
              ),
              onBack: (v){
                Get.back();
              }
            );
          });
        },
      );
    });

  }
}

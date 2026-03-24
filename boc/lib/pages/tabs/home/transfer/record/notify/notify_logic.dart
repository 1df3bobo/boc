import 'package:boc/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import 'notify_state.dart';

class NotifyLogic extends GetxController {
  final NotifyState state = NotifyState();

  @override
  void onInit() {
    super.onInit();
    state.model = Get.arguments['model'];
  }

  bool needsEye(String field) => state.eyeFields.contains(field);

  bool isEyeOn(String field) => state.eyeVisible[field] == true;

  void onEyeTap(String field) {
    final current = isEyeOn(field);
    if (current) {
      state.eyeVisible[field] = false;
    } else {
      state.eyeVisible[field] = true;
      if (!state.dontShowAgain.value) {
        _showRevealDialog();
      }
    }
  }

  void _showRevealDialog() {
    bool checked = false;
    SmartDialog.show(
      clickMaskDismiss: true,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSt) => Center(
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Image(image: 'tz_show_dialog'.png3x, width: 300.w),
              Positioned(
                bottom: -30.w,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setSt(() => checked = !checked);
                    if (checked) {
                      state.dontShowAgain.value = true;
                      SmartDialog.dismiss();
                    }
                  },
                  child: Image(
                    image: checked ? 'tz_check_yes'.png3x : 'tz_check_on'.png3x,
                    width: 160.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String valueStr(String name){
    switch (name) {

    case "转账金额":
      return '人民币 ${state.model.amount.bankBalance}';
    case "交易时间":
      return state.model.transactionTime;
    case "收款人名称":
      return state.model.oppositeName;
    case "收款账号":
      return state.model.oppositeAccount.maskBankCardNumber(
        maskCharCount: 6,
      );
    case "收款银行":
      return state.model.oppositeBankName;
    case "付款人名称":
      return AppConfig.config.abcLogic.memberInfo.realName;
    case "付款账号":
      return AppConfig.config.abcLogic.card();
    case "交易序号":
      return state.model.certificateNo;
    }
    return '';
  }
}

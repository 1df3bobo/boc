import 'package:boc/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import 'notify_state.dart';

class NotifyLogic extends GetxController {
  static const _kDontShowEyeDialog = 'notify_dont_show_eye_dialog';

  final NotifyState state = NotifyState();

  @override
  void onInit() {
    super.onInit();
    state.model = Get.arguments['model'];
    // 从本地恢复「不再提示」设置
    state.dontShowAgain.value =
        SpUtil.getBool(_kDontShowEyeDialog) ?? false;
  }

  bool needsEye(String field) => state.eyeFields.contains(field);

  bool isEyeOn(String field) => state.eyeVisible[field] == true;

  void onEyeTap(String field) {
    if (isEyeOn(field)) {
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
                left: 20.w,
                bottom: 62.w,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setSt(() => checked = !checked),
                  child: Image(
                    image: checked ? 'tz_check_yes'.png3x : 'tz_check_no'.png3x,
                    width: 15.w,
                  ),
                ),
              ),
              Positioned(
                left: 20.w,
                right: 20.w,
                bottom: 0.w,
                child: Container(
                  height: 50.w,
                  width: 1.sw - 40.w,
                ).withOnTap(onTap: () {
                  if (checked) {
                    state.dontShowAgain.value = true;
                    // 持久化到本地
                    SpUtil.putBool(_kDontShowEyeDialog, true);
                  }
                  SmartDialog.dismiss();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── 值展示（根据眼睛状态决定是否加密）────────────────────────────

  /// 对外统一入口：眼睛打开时返回明文，关闭时返回加密文本。
  String displayValue(String name) {
    if (isEyeOn(name)) return _plainValue(name);
    return _maskedValue(name);
  }

  /// 明文值
  String _plainValue(String name) {
    switch (name) {
      case "转账金额":   return '人民币 ${state.model.amount.bankBalance}';
      case "交易时间":   return state.model.transactionTime;
      case "收款人名称": return state.model.oppositeName;
      case "收款账号":   return state.model.oppositeAccount;
      case "收款银行":   return state.model.oppositeBankName;
      case "付款人名称": return AppConfig.config.abcLogic.memberInfo.realName;
      // 付款账号服务端给的已经是加密数据，用 card1() 取原始卡号
      case "付款账号":   return AppConfig.config.abcLogic.card1();
      case "交易序号":   return state.model.certificateNo;
    }
    return '';
  }

  /// 加密值
  String _maskedValue(String name) {
    switch (name) {
      case "转账金额":   return '人民币 ${state.model.amount.bankBalance}';
      case "交易时间":   return state.model.transactionTime;
      case "收款人名称": return state.model.oppositeName;
      case "收款账号":   return _maskAccount(state.model.oppositeAccount);
      case "收款银行":   return state.model.oppositeBankName;
      case "付款人名称": return _maskName(AppConfig.config.abcLogic.memberInfo.realName);
      case "付款账号":   return _maskAccount(AppConfig.config.abcLogic.card1());
      case "交易序号":   return state.model.certificateNo;
    }
    return '';
  }

  /// 姓名加密：2字→末位*；3字→中间*；其余→首尾保留、中间全*
  static String _maskName(String name) {
    if (name.isEmpty) return name;
    if (name.length == 2) return '${name[0]}*';
    if (name.length == 3) return '${name[0]}*${name[2]}';
    final mid = '*' * (name.length - 2);
    return '${name[0]}$mid${name[name.length - 1]}';
  }

  /// 账号加密：前4位 + 6个* + 后4位，格式 "1234 ****** 1234"
  static String _maskAccount(String account) {
    if (account.length <= 8) return account;
    final head = account.substring(0, 4);
    final tail = account.substring(account.length - 4);
    return '$head ****** $tail';
  }

  /// 保留旧调用兼容（不带眼睛的字段仍走此方法）
  String valueStr(String name) => _maskedValue(name);
}

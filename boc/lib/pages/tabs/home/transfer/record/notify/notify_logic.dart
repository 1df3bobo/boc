import 'package:boc/config/app_config.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/string_extension.dart';

import 'notify_state.dart';

class NotifyLogic extends GetxController {
  final NotifyState state = NotifyState();


  @override
  void onInit() {
    super.onInit();
    state.model = Get.arguments['model'];
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

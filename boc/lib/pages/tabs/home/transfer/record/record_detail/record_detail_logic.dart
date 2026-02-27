import 'package:boc/config/app_config.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';

import 'record_detail_state.dart';

class RecordDetailLogic extends GetxController {
  final RecordDetailState state = RecordDetailState();

  @override
  void onInit() {
    super.onInit();
    state.model = Get.arguments['model'];
  }


  String valueStr(String name) {

    switch (name) {
      case '人行报文号':
      return state.model.postscriptno;
      case '优惠后费用':
      return '人民币元 0.00';
      case '收款人名称':
      return state.model.oppositeName;
      case '收款账号':
        return state.model.oppositeAccount;
      case '收款银行':
        return state.model.transactionType;
      case '付款账户':
        return '${AppConfig.config.abcLogic.memberInfo.realName} ${AppConfig.config.abcLogic.card()}';
      case '交易渠道':
        return state.model.transactionChannel;
      case '交易序号':
        return state.model.certificateNo;
      case '交易时间':
        return state.model.transactionTime;
    }
    return '';
  }
}

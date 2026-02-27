import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';

import '../../../../../config/model/bill_item_model.dart';
import 'bill_info_state.dart';

class BillInfoLogic extends GetxController {
  final BillInfoState state = BillInfoState();

  @override
  void onInit() {
    super.onInit();
    state.model = Get.arguments['model'] ?? BillItemList();
  }

  String valueStr(String name) {
    switch (name) {
      case '交易时间':
      case '记账时间':
        return state.model.transactionTime;
      case '交易类型':
        return state.model.transactionType;
      case '交易后余额':
        return '人民币元 ${state.model.accountBalance.bankBalance}';
      case '交易渠道/场所':
        return state.model.transactionChannel;
      case '附言':
        return state.model.merchantBranch;
    }
    return '';
  }
}

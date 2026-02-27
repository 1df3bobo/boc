import 'package:boc/config/app_config.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';

import '../../../../../config/model/bill_item_model.dart';
import 'sz_detail_state.dart';

class SzDetailLogic extends GetxController {
  final SzDetailState state = SzDetailState();

  var noShow = true.obs;

  @override
  void onInit() {
    super.onInit();
    state.model = Get.arguments['model'] ?? BillItemList();
  }

  String valueStr(String name) {
    switch (name) {
      case '交易账户':
        return '借记卡 ${AppConfig.config.abcLogic.card()}';
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

      case '分类':
        return state.model.transactionCategory;
      case '交易备注':
        return state.model.postscriptno;
      case '所属账本':
        return '';
      case '交易对象':
        return '';
      case '计入收支':
        return state.model.merchantBranch;
    }
    return '';
  }
}

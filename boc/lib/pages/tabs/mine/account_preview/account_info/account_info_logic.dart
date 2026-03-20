import 'package:get/get.dart';

import '../../../../../config/dio/network.dart';
import '../../../../../config/model/bill_item_model.dart';
import '../../../../../config/net_config/apis.dart';
import 'account_info_state.dart';

class AccountInfoLogic extends GetxController {
  final AccountInfoState state = AccountInfoState();

  void revealCard() {
    state.showFullCard = true;
    update(['updateCardNo']);
  }

  Future getData() async{
    await Http.get(
        Apis.billPage,
        queryParameters: state.billData.toJson(),
        isLoading: state.billData.pageNum == 1
    ).then((v) {
      state.itemModel = BillItemModel.fromJson(v);
      state.list = state.itemModel.list;
      update(['updateUI']);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}

import 'package:get/get.dart';

import '../../../../config/dio/network.dart';
import '../../../../config/model/bill_item_model.dart';
import '../../../../config/net_config/apis.dart';
import 'bill_state.dart';

class BillLogic extends GetxController {
  final BillState state = BillState();


  @override
  void onInit() {
    super.onInit();
    getData();
  }
  Future getData() async{
   await Http.get(
        Apis.billPage,
        queryParameters: state.billData.toJson(),
        isLoading: state.billData.pageNum == 1
    ).then((v) {
      state.itemModel = BillItemModel.fromJson(v);
      state.refreshController.loadComplete();
      if (!state.itemModel.list.isNotEmpty) {
        state.refreshController.loadNoData();
      }else {
        state.billData.endPageTime = state.itemModel.list.last.transactionTime;
      }
      if (state.billData.pageNum == 1) {
        state.list = state.itemModel.list;
      } else {
        state.list = state.list + state.itemModel.list;
      }
      update(['updateUI']);
    });
  }
}

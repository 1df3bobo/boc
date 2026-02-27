import 'package:get/get.dart';

import '../../../../../config/dio/network.dart';
import '../../../../../config/model/transfer_record_model.dart';
import '../../../../../config/net_config/apis.dart';
import 'record_state.dart';

class RecordLogic extends GetxController {
  final RecordState state = RecordState();

  @override
  void onInit() {
    super.onInit();
    transferPage();
  }


  void transferPage() {
    Http.get(Apis.transferPage,
      queryParameters: state.recordData.toJson(),
    ).then((v) {
      state.recordModel = TransferRecordModel.fromJson(v);
      state.refreshController.loadComplete();
      if(!state.recordModel.list.isNotEmpty){
        state.refreshController.loadNoData();
      }
      if(state.recordData.pageNum == 1){
        state.list = state.recordModel.list;
      }else{
        state.list = state.list + state.recordModel.list;
      }
      update(['updateUI']);
    });
  }

}

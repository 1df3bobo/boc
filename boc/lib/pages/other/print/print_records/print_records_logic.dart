import 'package:get/get.dart';

import '../../../../config/dio/network.dart';
import '../../../../config/model/apply_record_model.dart';
import '../../../../config/net_config/apis.dart';
import 'print_records_state.dart';

class PrintRecordsLogic extends GetxController {
  final PrintRecordsState state = PrintRecordsState();


  @override
  void onInit() {
    super.onInit();
    flowExportApplyPage();
  }

  void flowExportApplyPage(){
    Http.get(Apis.applyPageList,queryParameters: {
      'pageSize':10,
      'pageNum':state.pageNum
    }).then((v){
      state.recordModel = ApplyRecordModel.fromJson(v);
      state.refreshController.loadComplete();
      if (!state.recordModel.list.isNotEmpty) {
        state.refreshController.loadNoData();
      }

      if (state.pageNum == 1) {
        state.list = state.recordModel.list;
      } else {
        state.list = state.list + state.recordModel.list;
      }
      update(['updateUI']);
    });
  }
}

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
      _deduplicateDayHeaders(state.list);
      update(['updateUI']);
    });
  }

  /// 去重月份标题：如果上面已经展示过某月，下面同月的 day 不展示
  void _deduplicateDayHeaders(List<TransferRecordList> list) {
    final seenMonths = <String>{};
    for (final item in list) {
      if (item.day.isEmpty) continue;
      final key = _getMonthKey(item);
      if (key.isEmpty) continue;
      if (seenMonths.contains(key)) {
        item.day = '';
      } else {
        seenMonths.add(key);
      }
    }
  }

  String _getMonthKey(TransferRecordList item) {
    final time = item.detail?.transactionTime;
    if (time == null || time.isEmpty) return '';
    try {
      final normalized = time.replaceAll('/', '-');
      final dt = DateTime.parse(normalized);
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}';
    } catch (_) {
      return '';
    }
  }

}

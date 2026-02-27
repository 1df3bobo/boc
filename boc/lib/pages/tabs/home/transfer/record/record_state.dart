import 'package:boc/pages/tabs/home/transfer/record/req_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../../config/model/transfer_record_model.dart';
import '../../../../component/sheet_widget/picker_widget.dart';

class RecordState {

  ScrollController scController = ScrollController();
  RefreshController refreshController = RefreshController();

  ReqRecordData recordData = ReqRecordData();
  TransferRecordModel recordModel = TransferRecordModel();

  List<TransferRecordList> list = [];



  String selectTime = '近3月';
  DateTimePickerNotifier pickerNotifier1 = DateTimePickerNotifier();
  DateTimePickerNotifier pickerNotifier2 = DateTimePickerNotifier();
  // 开始时间
  String temBeginTime = '';
  String beginTime = '';
  //结束时间
  String temEndTime = '';
  String endTime = '';

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  String temStatus = '';


  RecordState() {
    ///Initialize variables
  }
}

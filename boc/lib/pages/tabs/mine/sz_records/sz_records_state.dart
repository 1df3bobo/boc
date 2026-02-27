import 'package:boc/pages/tabs/mine/sz_records/req_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../config/model/pay_ment_model.dart';
import '../../../component/sheet_widget/picker_widget.dart';

class SzRecordsState {



  RefreshController refreshController = RefreshController();
  ScrollController controller = ScrollController();
  ScrollController rangeController = ScrollController();


  ReqSzData szData = ReqSzData();
  String selectPrice = '';
  List selectCategorys = [];




  DateTimePickerNotifier mPickerNotifier = DateTimePickerNotifier();
  DateTimePickerNotifier yPickerNotifier = DateTimePickerNotifier();
  String selectTime = '';
  DateTimePickerNotifier pickerNotifier1 = DateTimePickerNotifier();
  DateTimePickerNotifier pickerNotifier2 = DateTimePickerNotifier();

  String timeMTitle = '';
  String temTimeMTitle1 = '';

  String timeYTitle = '';
  String temTimeYTitle1 = '';

  //  开始时间
  String temBeginTime1 = '';
  String beginTime = '';
  //结束时间
  String temEndTime1 = '';
  String endTime = '';

  bool showSelectTime = false;

  PayMentModel model = PayMentModel();
  List<PayMentList> list = [];

  PayMentModel rangeModel = PayMentModel();
  List<PayMentList> rangeList = [];

  double incomeTotal = 0;
  double expensesTotal = 0;

  SzRecordsState() {
    ///Initialize variables

    DateTime now = DateTime.now();
    szData.beginTime = DateFormat('yyyy-MM-dd').format(now);

  }
}

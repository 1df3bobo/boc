import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../../config/model/pay_ment_model.dart';
import '../../../../component/sheet_widget/picker_widget.dart';
import '../req_data.dart';

class SearchListState {


  TextEditingController textController = TextEditingController();

  ReqSzData searchData = ReqSzData();

  DateTimePickerNotifier mPickerNotifier = DateTimePickerNotifier();
  DateTimePickerNotifier yPickerNotifier = DateTimePickerNotifier();
  String selectTime = '近1年';
  DateTimePickerNotifier pickerNotifier1 = DateTimePickerNotifier();
  DateTimePickerNotifier pickerNotifier2 = DateTimePickerNotifier();

  String timeMTitle = '';
  String temTimeMTitle = '';

  String timeYTitle = '';
  String temTimeYTitle = '';

  //  开始时间
  String temBeginTime1 = '';
  String beginTime = '';
  //结束时间
  String temEndTime1 = '';
  String endTime = '';

  bool showSelectTime = false;


  RefreshController refreshController = RefreshController();
  ScrollController controller = ScrollController();
  PayMentModel model = PayMentModel();
  List<PayMentList> list = [];
  double incomeTotal = 0;
  double expensesTotal = 0;

  SearchListState() {
    ///Initialize variables

    searchData.beginTime = getDateRange(selectTime)['start']??'';
    searchData.endTime = getDateRange(selectTime)['end']??'';
  }

  Map<String, String> getDateRange(String tag) {
    DateTime now = DateTime.now();
    DateTime startDate;
    DateTime endDate = now; // 默认结束时间为现在

    switch (tag) {
      case '本月':
      // 本月第一天 00:00:00
        startDate = DateTime(now.year, now.month, 1);
        break;
      case '本年':
      // 本年第一天 01-01 00:00:00
        startDate = DateTime(now.year, 1, 1);
        break;
      case '近1月':
      // 当前时间减去 30 天（或者减去一个月）
        startDate = now.subtract(const Duration(days: 30));
        break;
      case '近3月':
        startDate = now.subtract(const Duration(days: 90));
        break;
      case '近1年':
      // 当前时间减去 365 天
        startDate = now.subtract(const Duration(days: 365));
        break;
      default:
        startDate = now;
    }

    String s = DateFormat('yyyy-MM-dd').format(startDate);
    String e = DateFormat('yyyy-MM-dd').format(endDate);

    return {
      'start': s,
      'end': e,
    };
  }
}

import 'package:intl/intl.dart';

import '../../../../../config/model/bill_item_model.dart';
import '../../../home/bill/Req_data.dart';

class AccountInfoState {
  ReqBillData billData = ReqBillData();
  BillItemModel itemModel = BillItemModel();
  List<BillItemList> list = [];
  bool showFullCard = false;
  AccountInfoState() {
    billData.pageSize =200;
    billData.beginTime = getRangeDate()['start']??'';
    billData.endTime = getRangeDate()['end']??"";
  }

  Map<String, String> getRangeDate({String tag = '近一周'}) {
    DateTime now = DateTime.now();
    DateTime endDate = now;
    DateTime startDate;

    switch (tag) {
      case '近一周':
        startDate = now.subtract(const Duration(days: 7));
        break;
      case '近1月':
        startDate = DateTime(now.year, now.month - 1, now.day);
        break;
      case '近3月':
        startDate = DateTime(now.year, now.month - 3, now.day);
        break;
      case '近6月':
        startDate = DateTime(now.year, now.month - 6, now.day);
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

import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../config/model/bill_item_model.dart';
import '../../../component/sheet_widget/picker_widget.dart';
import 'Req_data.dart';

class BillState {
  RefreshController refreshController = RefreshController();
  ScrollController controller = ScrollController();

  ReqBillData billData = ReqBillData();
  String selectPrice = '全部';
  List selectType = ['全部'];
  String selectSzStr = '全部';
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();

  BillItemModel itemModel = BillItemModel();
  List<BillItemList> list = [];

  String selectTime = '';
  //  开始时间
  String temBeginTime = '';
  String beginTime = '';
  //结束时间
  String temEndTime = '';
  String endTime = '';

  DateTimePickerNotifier pickerNotifier1 = DateTimePickerNotifier();
  DateTimePickerNotifier pickerNotifier2 = DateTimePickerNotifier();


  BillState() {
    ///Initialize variables
  }
}

import '../../../../../config/model/bill_item_model.dart';

class BillInfoState {

  List titles = [
    '交易时间',
    '记账时间',
    '交易类型',
    '交易后余额',
    '交易渠道/场所',
    '附言'
  ];
  BillItemListBillDetail model = BillItemListBillDetail();

  BillInfoState() {
    ///Initialize variables
  }
}

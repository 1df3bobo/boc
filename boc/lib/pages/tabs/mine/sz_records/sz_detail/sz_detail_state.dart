import '../../../../../config/model/bill_item_model.dart';

class SzDetailState {
  List titles = [
    '交易账户',
    '交易后余额',
    '',
    '对方名称',
    '对方账号',
    // '交易时间',
    // '记账时间',
    '交易类型',
    '交易后余额',
    '交易渠道/场所',
    '附言',
    '交易时间',
    'text',
  ];
  List titles2 = [
    '分类',
    '交易备注',
    '所属账本',
    '交易对象',
    '计入收支',
  ];
  BillItemListBillDetail model = BillItemListBillDetail();

  /// 交易对象选项（接口返回后覆盖，见 [SzDetailLogic.loadCounterpartyOptions]）
  List<String> counterpartyOptions = [];

  SzDetailState() {
    ///Initialize variables
    titles.addAll(titles2);
  }
}

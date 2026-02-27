import '../../../../../../config/model/transfer_record_model.dart';

class RecordDetailState {

  List titles0 = [
    '人行报文号',
    '优惠后费用',
    '',
  ];

  List titles = [
    '收款人名称',
    '收款账号',
    '收款银行',
    '付款账户',
    '交易渠道',
    '交易序号',
    '交易时间'
  ];
  TransferRecordListDetail model = TransferRecordListDetail();
  RecordDetailState() {
    titles0.addAll(titles);
  }
}

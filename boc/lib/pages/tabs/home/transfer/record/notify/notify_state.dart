import '../../../../../../config/model/transfer_record_model.dart';

class NotifyState {

  List title = [
    "转账金额",
    "交易时间",
    "收款人名称",
    "收款账号",
    "收款银行",
    "付款人名称",
    "付款账号",
    "交易序号"
  ];
  TransferRecordListDetail model = TransferRecordListDetail();
  NotifyState() {
    ///Initialize variables
  }
}

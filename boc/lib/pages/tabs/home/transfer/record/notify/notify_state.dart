import 'package:get/get.dart';
import '../../../../../../config/model/transfer_record_model.dart';

class NotifyState {

  List<String> title = [
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

  /// 需要展示眼睛图标的字段
  final Set<String> eyeFields = {'收款账号', '付款人名称', '付款账号'};

  /// 各字段是否处于「已展开」状态
  final RxMap<String, bool> eyeVisible = RxMap<String, bool>();

  /// 是否勾选了「不再提示」
  final RxBool dontShowAgain = false.obs;

  NotifyState();
}

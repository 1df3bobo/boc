class ReqRecordData {
  ReqRecordData({
    this.beginTime = '',
    this.endTime = '',
    this.pageNum = 1,
    this.pageSize = 20,
    this.maxAmount = '',
    this.minAmount = '',
    this.accountType = '',
    this.dateType = '',
    this.transactionChannel = '',
    this.oppositeAccount = '',
    this.keyword = '',
    this.type = '',
    this.status = '',
  });

  ReqRecordData.fromJson(dynamic json) {
    beginTime = json['beginTime'];
    endTime = json['endTime'];
    oppositeAccount = json['oppositeAccount'];
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
    keyword = json['keyword'];
    endPageTime = json['endPageTime'];
    maxAmount = json['maxAmount'];
    minAmount = json['minAmount'];
    accountType = json['accountType'];
    dateType = json['dateType'];
    transactionChannel = json['transactionChannel'];
    type = json['type'];
    status = json['status'];
  }

  String beginTime = '';
  String endTime = '';
  String oppositeAccount = '';
  int pageNum = 1;
  int pageSize = 10;
  String keyword = '';
  String endPageTime = '';
  String maxAmount = '';
  String minAmount = '';
  String accountType = '';
  String dateType = '';
  String transactionChannel = '';
  String type = '';
  String status = '';


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['beginTime'] = beginTime;
    map['endTime'] = endTime;
    map['oppositeAccount'] = oppositeAccount;
    map['pageNum'] = pageNum;
    map['pageSize'] = pageSize;
    map['keyword'] = keyword;
    map['endPageTime'] = endPageTime;
    map['maxAmount'] = maxAmount;
    map['minAmount'] = minAmount;
    map['accountType'] = accountType;
    map['dateType'] = dateType;
    map['transactionChannel'] = transactionChannel;
    map['type'] = type;
    map['status'] = status;
    return map;
  }
}

class ReqBillData {
  ReqBillData({
      this.beginTime = '',
      this.endTime = '',
      this.endPageTime = '',
      this.pageNum = 1,
      this.pageSize = 20,
      this.type = '',

      this.orderSort = '',
      this.minAmount = '',
      this.maxAmount = '',
      this.transactionType = '',
      this.oppositeName = '',
      this.oppositeAccount = '',

  });

  ReqBillData.fromJson(dynamic json) {
    beginTime = json['beginTime'];
    endTime = json['endTime'];
    endPageTime = json['maxAmount'];
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
    type = json['type'];

    orderSort = json['orderSort'];
    minAmount = json['minAmount'];
    maxAmount = json['maxAmount'];
    transactionType = json['transactionType'];
    oppositeName = json['oppositeName'];
    oppositeAccount = json['oppositeAccount'];


  }
  String beginTime = '';
  String endTime = '';
  int pageNum = 1;
  int pageSize = 10;
  String endPageTime = '';
  String type = '';

  String orderSort = '';
  String minAmount = '';
  String maxAmount = '';
  String transactionType = '';
  String oppositeName = '';
  String oppositeAccount = '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['beginTime'] = beginTime;
    map['endTime'] = endTime;
    map['pageNum'] = pageNum;
    map['pageSize'] = pageSize;
    map['endPageTime'] = endPageTime;
    map['type'] = type;

    map['orderSort'] = orderSort;
    map['minAmount'] = minAmount;
    map['maxAmount'] = maxAmount;
    map['transactionType'] = transactionType;
    map['oppositeName'] = oppositeName;
    map['oppositeAccount'] = oppositeAccount;
    return map;
  }

}
class ReqSzData {
  ReqSzData({
    this.beginTime = '',
    this.endTime = '',
    this.pageNum = 1,
    this.pageSize = 20,
    this.endPageTime = '',
    this.minAmount = '',
    this.maxAmount = '',
    this.orderSort = '',
    this.categorys = '',
    this.queryTime = '',
    this.transactionChannel = '',
    this.keyword = '',
  });

  ReqSzData.fromJson(dynamic json) {
    beginTime = json['beginTime'];
    endTime = json['endTime'];
    endPageTime = json['maxAmount'];
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
    minAmount = json['minAmount'];
    maxAmount = json['maxAmount'];
    orderSort = json['orderSort'];
    categorys = json['categorys'];
    queryTime = json['queryTime'];

    transactionChannel = json['transactionChannel'];
    keyword = json['keyword'];
  }

  String beginTime = '';
  String endTime = '';
  int pageNum = 1;
  int pageSize = 20;
  String minAmount = '';
  String maxAmount = '';
  String orderSort = '';
  String categorys = '';
  String endPageTime = '';
  String queryTime = '';

  String transactionChannel = '';
  String keyword = '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['beginTime'] = beginTime;
    map['endTime'] = endTime;
    map['pageNum'] = pageNum;
    map['pageSize'] = pageSize;
    map['endPageTime'] = endPageTime;
    map['minAmount'] = minAmount;
    map['maxAmount'] = maxAmount;
    map['orderSort'] = orderSort;
    map['categorys'] = categorys;
    map['queryTime'] = queryTime;

    map['transactionChannel'] = transactionChannel;
    map['keyword'] = keyword;
    return map;
  }
}

class CardReq {
  CardReq({
    this.realName = '',
    this.cardNo = '',
    this.bankId = '',
    this.amount = '',
    this.purpose = '',
    this.bankName = '',
  });

  CardReq.fromJson(dynamic json) {
    realName = json['realName'];
    cardNo = json['cardNo'];
    bankId = json['bankId'];
    amount = json['amount'];
    purpose = json['purpose'];
    bankName = json['bankName'];
  }
  String realName = '';
  String cardNo ='';
  String bankId = '';
  String amount = '';
  String purpose = '';
  String bankName = '';


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['realName'] = realName;
    map['cardNo'] = cardNo;
    map['bankId'] = bankId;
    map['amount'] = amount;
    map['purpose'] = purpose;
    map['bankName'] = bankName;
    return map;
  }

}
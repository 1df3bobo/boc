import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';

class ContactInfo extends ISuspensionBean {

  String? tagIndex;
  String? namePinyin;

  Color? bgColor;
  IconData? iconData;

  String icon;
  String id;
  String bankName;
  String name;
  String bankId;
  String bankCard;

  ContactInfo({
    required this.name,
    this.tagIndex,
    this.namePinyin,
    this.bgColor,
    this.iconData,
    this.icon = '',
    this.id = '',
    this.bankCard = '',
    this.bankName = '',
    this.bankId = '',
  });

  ContactInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'].toString(),
        icon = json['icon'].toString(),
        id = json['id'].toString(),
        bankCard = json['bankCard'].toString(),
        bankName = json['bankName'].toString(),
        bankId = json['bankId'].toString();

  Map<String, dynamic> toJson() => {
    'name': name,
    'icon': icon,

    'id': id,
    'bankCard': bankCard,
    'bankName': bankName,
    'bankId': bankId,
  };

  @override
  String getSuspensionTag() => tagIndex!;

  @override
  String toString() => json.encode(this);
}
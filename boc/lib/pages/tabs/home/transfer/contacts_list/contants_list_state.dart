
import 'package:flutter/material.dart';

class ContactsListState {

  List<String> titleList = [
    '普通收款人',
    '网银大额收款人',
    '本人账户转账',
  ];

  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  ContactsListState() {
    ///Initialize variables
  }
}

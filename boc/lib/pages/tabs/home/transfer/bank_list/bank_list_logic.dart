import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';

import '../../../../../config/dio/network.dart';
import '../../../../../config/net_config/apis.dart';
import 'bank_list_model.dart';
import 'bank_list_state.dart';

class BankListLogic extends GetxController {
  final BankListState state = BankListState();



  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    // rootBundle.loadString('assets/data/bank_models.json').then((value) {
    //   List list = json.decode(value);
    //   for (var v in list) {
    //     state.contactList.add(ContactInfo.fromJson(v));
    //   }
    //   _handleList(state.contactList);
    // });

    Http.get(Apis.bankList).then((value){
      if(value!= null){
        for (var v in value['bankList']) {
          state.contactList.add(ContactInfo.fromJson(v));
        }
        for (var v in value['hotList']) {
          state.hotBankList.add(ContactInfo.fromJson(v));
        }
      }
      _handleList(state.contactList);
    });

  }

  void _handleList(List<ContactInfo> list) {
    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(state.contactList);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(state.contactList);

    // add header.
    state.contactList.insert(0, ContactInfo(name: 'header', tagIndex: '热'));

    update(['updateUI']);
  }
}

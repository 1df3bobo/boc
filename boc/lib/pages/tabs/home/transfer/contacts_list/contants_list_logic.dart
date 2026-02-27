import 'package:azlistview/azlistview.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';

import '../../../../../config/dio/network.dart';
import '../../../../../config/net_config/apis.dart';
import '../bank_list/bank_list_model.dart';
import 'contants_list_state.dart';

class ContactsListLogic extends GetxController{
  final ContactsListState state = ContactsListState();

  List<ContactInfo> contactList = [];
  List<ContactInfo> topList = [];


  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData({String name = ''}) async {

    Http.get(Apis.contactsList,queryParameters: {
      'name':name
    }).then((v){
      // print(v);
      if(v is List){
        contactList =  v.map((e) => ContactInfo.fromJson(e)).toList();
      }
      _handleList(contactList);
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
    SuspensionUtil.sortListBySuspensionTag(contactList);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(contactList);

    // add header.
    // contactList.insert(0, ContactInfo(name: 'header', tagIndex: '我'));


    update(['updateUI']);
  }

}

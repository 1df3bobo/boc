import 'package:boc/pages/tabs/home/transfer/card_transfer/card_transfer_view.dart';
import 'package:boc/pages/tabs/home/transfer/record/record_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../other/change_nav/change_nav_view.dart';
import '../../../other/fixed_nav/fixed_nav_view.dart';
import '../../../other/tips_page/tips_page_view.dart';
import 'contacts_list/contants_list_view.dart';
import 'transfer_state.dart';

class TransferLogic extends GetxController {
  final TransferState state = TransferState();


  String imagePath(String name){
    if(name == '账号转账') return 'zhzh_1';
    if(name == '手机号转账') return 'sjhzz_2';
    if(name == '跨境汇款') return 'kjzh_3';
    if(name == '预约转账') return 'yyzz_4';
    if(name == '转账记录') return 'zzjl_4';
    return '';
  }

  void jumpPage(String name){
    print(name);
    if(name == '账号转账'){
      Get.to(() => CardTransferPage());
    }
    if(name == '转账记录'){
      Get.to(() => RecordPage());
    }
    if(name == '预约转账'){
      Get.to(()=>FixedNavPage(),arguments: {
        'image':'yy_bg',
        'title':'预约转账',
      });
    }
    if(name == '跨境汇款'){
      Get.to(() => ChangeNavPage(),
          arguments: {'image': 'kj_bg', 'title': '外币跨境汇款'});
    }
  }

  void jumpTag(int index){
    if(index == 0){
      Get.to(() => TipsPagePage(),arguments: {
        'title':'',
        'content':'您暂无可使用该服务的卡片，您可将卡片关联手机银行或进行“信用卡申请”',
        'showCancel':false,
      });
    }
    if(index == 2){
      Get.to(() => ChangeNavPage(),
          arguments: {'image': 'xqb_bg', 'title': '闲钱宝','defTitleColor':Colors.white});
    }
    if(index == 3){
      Get.to(() => FixedNavPage(), arguments: {
        'image': 'tradeSet',
        'title': '交易限额设置',
      });
    }
    if(index == 4){
      Get.to(() => ContactsListPage());
    }
  }
}

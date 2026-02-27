import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import '../../other/fixed_nav/fixed_nav_view.dart';
import '../../other/tips_page/tips_page_view.dart';
import '../home/transfer/card_transfer/card_transfer_view.dart';
import 'card_state.dart';
import 'cpjh/cpjh_view.dart';

class CardLogic extends GetxController {
  var navActionColor = Colors.black.obs;
  final CardState state = CardState();

  void jumpTag(int index){
    print(index);
    if(index == 0){
      Get.to(() => TipsPagePage(),arguments: {
        'title':'',
        'content':'您暂无可使用该服务的卡片，您可将卡片关联手机银行或进行“信用卡申请”',
        'showCancel':false,
      });
    }
    if(index == 1){
      Get.to(() => CardTransferPage());
    }
    if(index == 2 || index == 3 || index == 6){
      '\n所涉及相关资产信息可能会存在更新延迟等情况，仅供参考，不作为对账凭证。\n'.dialog(
        showCancel: false,
          sureText: '我知道了',
          contentStyle: TextStyle(
          color: Color(0xff666666)
      )
      );
    }
    if(index == 4){
      Get.to(()=>FixedNavPage(),arguments: {
        'image':'xyksq_bg',
        'title':'信用卡申请',
      });
    }
    if(index == 5){
      Get.to(()=>FixedNavPage(),arguments: {
        'image':'yjbk_bg',
        'title':'一键绑卡',
      });
    }
    if(index == 7){
      Get.to(()=>FixedNavPage(),arguments: {
        'image':'szxyk_bg',
        'title':'数字行用卡',
      });
    }
    if(index == 8){
      Get.to(()=>CpjhPage());
    }
    if(index == 9){
      Get.to(() => FixedNavPage(), arguments: {
        'image': 'dz2',
        'title': '更多',
      });
    }
  }
}

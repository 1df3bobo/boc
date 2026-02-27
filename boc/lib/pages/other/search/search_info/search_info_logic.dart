import 'package:boc/pages/other/print/print_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../webview_page/webview_page_view.dart';
import 'search_info_state.dart';

class SearchInfoLogic extends GetxController {
  final SearchInfoState state = SearchInfoState();

  var selectTitle = 0.obs;
  String title = '';
  @override
  void onInit() {
    super.onInit();
    title = Get.arguments['title']??'';
    WidgetsBinding.instance.addPostFrameCallback((_){
      state.searchController.text = Get.arguments['title']??'';
    });
  }

  void jumpPage(){

    if(title.contains('流水')){
      Get.to(() => PrintPage());
    }
    if(title.contains('账单')){
      Get.to(() => WebViewPage(),
          arguments: {'routeName': '/monthlyBill'});
    }
  }
}

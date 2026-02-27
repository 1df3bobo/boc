import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../config/dio/network.dart';
import '../../../../../config/model/pay_ment_model.dart';
import '../../../../../config/net_config/apis.dart';
import 'search_list_state.dart';

class SearchListLogic extends GetxController {
  final SearchListState state = SearchListState();

  void timeFilter(){
    state.searchData.pageNum = 1;
    state.searchData.endPageTime = '';
    getData2().then((_){
      try {
        state.controller.jumpTo(0);
      }catch(e){}

    });;
  }

  @override
  void onInit() {
    super.onInit();

    state.searchData.keyword = Get.arguments['name']??'';
    getData2().then((_){
      try {
        state.controller.jumpTo(0);
      }catch(e){}

    });
    WidgetsBinding.instance.addPostFrameCallback((_){
      state.textController.text = state.searchData.keyword;
    });
  }

  Future getData2() async{
   await Http.get(
        Apis.pageKeyWordPayment,
        queryParameters: state.searchData.toJson(),
        isLoading: state.searchData.pageNum == 1
    ).then((v) {
      state.model = PayMentModel.fromJson(v);
      state.refreshController.loadComplete();
      if (!state.model.list.isNotEmpty) {
        state.refreshController.loadNoData();
      }else {
        state.searchData.endPageTime = state.model.list.last.transactionTime;
      }
      if (state.searchData.pageNum == 1) {
        state.incomeTotal = state.model.incomeTotal;
        state.expensesTotal = state.model.expensesTotal;
        state.list = state.model.list;
      } else {
        state.list = state.list + state.model.list;
      }
      update(['updateUI']);
    });
  }
}

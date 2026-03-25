import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../../../config/dio/network.dart';
import '../../../../config/model/pay_ment_model.dart';
import '../../../../config/net_config/apis.dart';
import '../../../other/webview_page1/web_widget.dart';
import '../../../other/webview_page1/webview_page_logic.dart';
import '../../../other/webview_page1/webview_page_view.dart';
import 'sz_records_state.dart';

class SzRecordsLogic extends GetxController {

  final SzRecordsState state = SzRecordsState();

  late final ListObserverController observerController =
      ListObserverController(controller: state.controller);

  bool showRange = false;

  Widget webWidget = WebViewPage1();


  var isWebViewInStack = true.obs;

  @override
  void onInit() {
    super.onInit();
    getData1();

    // 关键：在 SzRecords 初始化的同时也让 WebView 跑起来
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preLoadWebView();
    });
  }
  void _preLoadWebView() {
    // 确保 WebViewLogic1 已经存在 (WebViewPage1 创建时会自动 put)
    if (Get.isRegistered<WebViewLogic1>()) {
      final webLogic = Get.find<WebViewLogic1>();
      // 这里可以提前传数据，比如路由名或者初始化参数
      webLogic.onEnterPage({'routeName': '/analysis'});
    }
  }


  void onListViewObserve(ListViewObserveModel observeModel) {
    if (state.beginTime != '' || state.endTime != '') return;

    int firstVisible = observeModel.firstChild?.index ?? 0;
    for (int i = firstVisible; i >= 0; i--) {
      if (i < state.list.length && state.list[i].month != '') {
        print(state.list[i]);
        final String newTime = state.list[i].month.replaceAll('-', '.');
        if(state.selectTime != newTime) {
          state.selectTime = newTime;
          print(state.selectTime);
          update(['updateTime']);
        }
        break;
      }
    }
  }


  Future getData1() async{
    print('pagePayment 0000 ${state.szData.toJson()}');
   await Http.get(
        Apis.pagePayment,
        queryParameters: state.szData.toJson(),
        isLoading: state.szData.pageNum == 1
    ).then((v) {
      state.model = PayMentModel.fromJson(v);
      state.refreshController.loadComplete();
      if (!state.model.list.isNotEmpty) {
        state.refreshController.loadNoData();
      }else {
        state.szData.endPageTime = state.model.list.last.transactionTime;
      }
      if (state.szData.pageNum == 1) {
        state.list = state.model.list;
      } else {
        state.list = state.list + state.model.list;
      }
      update(['updateUI']);
    });
  }

  Future getData2() async{
    print('pageRangePayment 0000 ${state.szData.toJson()}');
   await Http.get(
        Apis.pageRangePayment,
        queryParameters: state.szData.toJson(),
        isLoading: state.szData.pageNum == 1
    ).then((v) {
      state.rangeModel = PayMentModel.fromJson(v);
      state.refreshController.loadComplete();
      if (!state.rangeModel.list.isNotEmpty) {
        state.refreshController.loadNoData();
      } else {
        state.szData.endPageTime = state.rangeModel.list.last.transactionTime;
      }
      if (state.szData.pageNum == 1) {
        state.incomeTotal = state.model.incomeTotal;
        state.expensesTotal = state.model.expensesTotal;
        state.rangeList = state.rangeModel.list;
      } else {
        state.rangeList = state.rangeList + state.rangeModel.list;
      }
      update(['updateUI']);
    });
  }


  void timeFilter(){
    if(state.szData.endTime == ''){
      showRange = false;
      getData1().then((_){
        try {
          state.controller.jumpTo(0);
        }catch(e){}

      });
    }else {
      showRange = true;
      getData2().then((_){
        try {
          state.rangeController.jumpTo(0);
        }catch(e){}
      });
    }

  }
}

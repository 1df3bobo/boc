import 'package:boc/pages/other/webview_page1/webview_page_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../tabs/mine/sz_records/sz_records_logic.dart';
class WebWidget extends StatefulWidget {
  const WebWidget({super.key});

  @override
  State<WebWidget> createState() => _WebWidgetState();
}

class _WebWidgetState extends State<WebWidget> {

  final SzRecordsLogic logic = Get.find<SzRecordsLogic>();

  final WebViewLogic1 logic1 = Get.find<WebViewLogic1>();

  @override
  void initState() {
    super.initState();
    // 确保在第一帧渲染后执行，此时 WebView 已经从后台 Stack 移动到了前台页面
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final webLogic = Get.find<WebViewLogic1>();
      // 将跳转时的参数同步给预加载好的 WebView
      webLogic.onEnterPage(Get.arguments);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: logic.webWidget,
      ),
    );
  }
}

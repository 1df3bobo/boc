import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../tabs/mine/sz_records/sz_records_logic.dart';

class WebWidget extends StatefulWidget {
  const WebWidget({super.key});

  @override
  State<WebWidget> createState() => _WebWidgetState();
}

class _WebWidgetState extends State<WebWidget> {

  final SzRecordsLogic logic = Get.find<SzRecordsLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // 1. 设为透明
      body: Container(
        color: Colors.transparent, // 2. 容器也透明
        child: logic.webWidget,
      ),
    );
  }
}

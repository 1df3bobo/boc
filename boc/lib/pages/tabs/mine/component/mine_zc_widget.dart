import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../config/app_config.dart';
import '../sz_records/sz_records_view.dart';

class MineZcWidget extends StatefulWidget {
  const MineZcWidget({super.key});

  @override
  State<MineZcWidget> createState() => _MineZcWidgetState();
}

class _MineZcWidgetState extends State<MineZcWidget> {


  final double totalWidth = 312;
  double _width1 = 0;
  double _width2 = 0;

  void _calculateWidths() {
    double value1 = AppConfig.config.abcLogic.memberInfo.expensesTotal;
    double value2 = AppConfig.config.abcLogic.memberInfo.incomeTotal;
    double sum = value1 + value2;

    if (sum == 0) {
      setState(() {
        _width1 = totalWidth / 2;
        _width2 = totalWidth / 2;
      });
      return;
    }

    setState(() {
      _width1 = ((value1 / sum) * totalWidth).w;
      _width2 = ((value2 / sum) * totalWidth).w;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      _calculateWidths();
    });

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.w,
      child: Column(
        children: [
          SizedBox(height: 45.w,),
          Row(
            children: [
              Expanded(
                  child: Container(
                    height: 22.w,
                    child: BaseText(
                      text: '¥${AppConfig.config.abcLogic.memberInfo.incomeTotal.bankBalance}',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )),
              Expanded(
                  child: Container(
                      height: 22.w,
                      alignment: Alignment.bottomRight,
                      child: BaseText(
                        text: '¥${AppConfig.config.abcLogic.memberInfo.expensesTotal.bankBalance}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ))),
            ],
          ),
          SizedBox(height: 12.w,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: _width1,
                height: 4.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3.w),
                    bottomLeft: Radius.circular(3.w),
                    topRight: Radius.circular(_width2 > 0 ? 0 : 3.w),
                    bottomRight: Radius.circular(_width2 > 0 ? 0 : 3.w),
                  ),
                  color: Color(0xffD5A869),
                ),
              ),
              SizedBox(width: 1.w,),
              Container(
                width: _width2,
                height: 4.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(3.w),
                    bottomRight: Radius.circular(3.w),
                    topLeft: Radius.circular(_width1 > 0 ? 0 : 3.w),
                    bottomLeft: Radius.circular(_width1 > 0 ? 0 : 3.w),
                  ),
                  color: Color(0xff656568),
                ),
              ),
            ],
          )
        ],
      ),
    ).withOnTap(onTap: (){
      Get.to(() => SzRecordsPage());
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'bill_info_logic.dart';
import 'bill_info_state.dart';

class BillInfoPage extends BaseStateless {
  BillInfoPage({Key? key}) : super(key: key, title: '明细');

  final BillInfoLogic logic = Get.put(BillInfoLogic());
  final BillInfoState state = Get.find<BillInfoLogic>().state;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: 1.sw,
          height: 155.w,
          color: Colors.white,
          padding: EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(text: '${state.model.type == '1'?'收入':'支出'}金额 (人民币元)',style: TextStyle(
                color: Color(0xff666666),
                fontSize: 14
              ),),
              SizedBox(height: 20.w,),
              BaseText(text: state.model.amount.bankBalance,style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff222222)
              ),),
              SizedBox(height: 20.w,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(text: '对方账户名称/账号',
                    fontSize: 13,
                    color: Color(0xff666666),
                    maxLines: 2,
                  ).withSizedBox(
                    width: 58.w,
                  ),
                  SizedBox(width: 52.w,),
                  Container(
                    child: BaseText(text: '${
                    state.model.oppositeName
                    } ${
                    state.model.oppositeAccount.maskBankCardNumber(
                      fixStr: ' ',
                      maskCharCount: 6,
                    )
                    }',
                        maxLines: 5,style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp
                    ),),
                  ).expanded()
                ],
              )
            ],
          ),
        ),
        SizedBox(
          width: 1.sw,
          height: 8.w,
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(15.w),
          child: Column(
            children: state.titles.map((e) {
              if(logic.valueStr(e) == '') return const SizedBox.shrink();
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                    text: e,
                    fontSize: 13,
                    maxLines: 2,
                    color: Color(0xff666666),
                  ).withSizedBox(
                    width: 58.w,
                  ),
                  SizedBox(width: 52.w,),
                  Container(
                    child: BaseText(text: logic.valueStr(e),style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp
                    ),),
                  ).expanded()
                ],
              ).withPadding(
                top: 10.w,bottom: 10.w
              );
            }).toList(),
          ),
        ),
        BaseText(
          text: '"交易时间"为该笔交易的提交时间;"记账时间"为后台系统\n对该笔交易的实际处理时间。',
          color: Color(0xff666666),
          fontSize: 13,
        ).withContainer(
            height: 85.w,
            width: 1.sw,
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
            )),
        Image(image: 'bill_info_bottom'.png3x),
      ],
    );
  }
}

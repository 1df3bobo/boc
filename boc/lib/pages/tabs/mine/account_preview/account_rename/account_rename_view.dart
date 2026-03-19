import 'package:boc/config/app_config.dart';
import 'package:boc/pages/tabs/home/bill/bill_view.dart';
import 'package:boc/pages/tabs/home/transfer/transfer_view.dart';
import 'package:boc/pages/tabs/mine/account_preview/account_info/account_info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';

import 'account_rename_logic.dart';
import 'account_rename_state.dart';

class AccountRenamePage extends BaseStateless {
  AccountRenamePage({Key? key}) : super(key: key, title: '账户别名');

  final AccountRenameLogic logic = Get.put(AccountRenameLogic());
  final AccountRenameState state = Get.find<AccountRenameLogic>().state;

  @override
  Color? get background => Color(0xffF4F4F4);

  @override
  Color? get navColor => Color(0xffF4F4F4);

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 12.w),
      children: [
        Stack(children: [
          Image(
              image: 'account_rename'.png3x, width: 1.sw, fit: BoxFit.fitWidth),
          Positioned(
              left: 15.w,
              top: 10.w,
              child: Container(
                width: 1.sw - 30.w,
                height: 60.w,
                child: TextFieldWidget(
                  hintText: '请输入',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  controller: state.textController,
                ),
              )
          ),
          Positioned(
              left: 0.w,
              top: 120.w,
              child: Container(
                width: 1.sw,
                child: Row(
                  children: [
                    Container(width: 1.sw/4, height: 30.w,).withOnTap(onTap: (){
                      state.textController.text = '工资卡';
                    }),
                    Container(width: 1.sw/4, height: 30.w,).withOnTap(onTap: (){
                      state.textController.text = '消费卡';
                    }),
                    Container(width: 1.sw/4, height: 30.w,).withOnTap(onTap: (){
                      state.textController.text = '还款卡';
                    }),
                    Container(width: 1.sw/4, height: 30.w,).withOnTap(onTap: (){
                      state.textController.text = '公积金卡';
                    }),
                  ],
                ),
              )
          ),
          Positioned(
            left: 0.w,
              top: 185.w,
            child: Container(
              width: 1.sw,
              height: 40.w,
            ).withOnTap(onTap: () {
              logic.saveAliasLocally();
              Get.back();
            })
          )
        ]),
      ],
    );
  }
}

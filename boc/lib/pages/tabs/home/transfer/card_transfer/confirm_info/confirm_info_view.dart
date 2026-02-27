import 'package:boc/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/alter_widget.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../config/dio/network.dart';
import '../../../../../../config/net_config/apis.dart';
import '../../../../../../utils/abc_button.dart';
import '../../../../../component/right_widget.dart';
import '../../../../../component/auth_sm.dart';
import 'confirm_info_logic.dart';
import 'confirm_info_state.dart';

class ConfirmInfoPage extends BaseStateless {
  ConfirmInfoPage({Key? key}) : super(key: key, title: '确认信息');

  final ConfirmInfoLogic logic = Get.put(ConfirmInfoLogic());
  final ConfirmInfoState state = Get.find<ConfirmInfoLogic>().state;

  @override
  List<Widget>? get rightAction =>
      [RightWidget.rightImage(imgPath: 'ic_ke'), SizedBox(width: 18.w)];

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Image(image: 'tips_top'.png3x),
        Container(
          width: 1.sw,
          height: 185.w,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: 1.sw,
                height: 112.w,
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                ),
                child: Column(
                  spacing: 16.w,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BaseText(
                      text: '转账金额(人民币元)',
                      color: Color(0xff222222),
                      fontSize: 15,
                    ),
                    BaseText(
                      text: double.parse(state.cardReq.amount).bankBalance,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color(0xff222222)),
                    )
                  ],
                ),
              ),
              Container(
                width: 1.sw,
                height: 0.5.w,
                color: Color(0xffF0EFF5),
              ),
              Container(
                width: 1.sw,
                height: 72.w,
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                ),
                child: Column(
                  spacing: 16.w,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _itemWidget('转账费用','免费',color: Color(0xffDC0034)),
                    _itemWidget('转账方式','实时'),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.w),
        Container(
          width: 1.sw,
          height: 144.w,
          color: Colors.white,
          padding: EdgeInsets.only(top: 8.w,bottom: 10.w,left: 15.w,right: 15.w),
          child: Column(
            spacing: 19.w,
            children: [
              _itemWidget('收款人名称',state.cardReq.realName),
              _itemWidget('收款账号',logic.formatCardNumber(state.cardReq.cardNo)),
              _itemWidget('收款银行',state.cardReq.bankName),
              _itemWidget('付款账户',AppConfig.config.abcLogic.card()),
            ],
          ),
        ),
        SizedBox(height: 10.w),
        Container(
          width: 1.sw,
          height: 35.w,
          color: Colors.white,
          padding: EdgeInsets.only(left: 15.w,right: 15.w),
          child:  _itemWidget('安全工具','手机交易码'),
        ),

        SizedBox(height: 40.w,),
        AbcButton(
          title: '确定',
          bgColor: Color(0xff2D70ED),
          onTap: () {
            AlterWidget.alterWidget(builder: (context) {
              return AuthSm(callBack: (){
                print(state.cardReq.toJson());
                Http.post(Apis.transfer, data: state.cardReq.toJson()).then((v) {
                  print(state.cardReq.toJson());
                      if(v != null){
                       Get.back();
                      }
                });
              },);
            });
          },
          margin: EdgeInsets.only(left: 15.w,right: 15.w),
          width: 343.w,
          height: 44.w,
          radius: 6.w,
        ),
      ],
    );
  }

  Widget _itemWidget(String title,String content,{Color? color}){

    return Row(
      children: [
        BaseText(
          text: title,
          style: TextStyle(
              color: Color(0xff666666),
              fontSize: 13,
              fontWeight: FontWeight.bold),
        ).withSizedBox(width: 100.w),
        BaseText(
          text: content,
          style: TextStyle(
              color:color?? Color(0xff222222),
              fontSize: 13,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pinput/pinput.dart';
import 'package:wb_base_widget/component/count_down_btn.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../config/app_config.dart';
import '../../utils/abc_button.dart';
import '../../utils/color_util.dart';
import '../../utils/local_notifications.dart';

class AuthSm extends StatefulWidget {
  final Function callBack;
  const AuthSm({super.key, required this.callBack});

  @override
  State<AuthSm> createState() => _AuthSmState();
}

class _AuthSmState extends State<AuthSm> {


  CountDownBtnController downBtnController = CountDownBtnController();

  String code = Random().nextVerificationCode(6);
  String name =  AppConfig.config.abcLogic.memberInfo.realName.removeFirstChar1();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds:800),(){
      downBtnController.click();
      NotificationHelper.getInstance().showNotification(
          title: "中国银行",
          body: "验证码:$code。尊敬的$name，"
              "您正在通过手机银行查看账户信息。"
              "为保护信息安全，"
              "请不要将验证码告诉他人(短信编号:${Random().nextVerificationCode(4)})【中国银行】",
          payload: "payload");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw * 0.80,
      height: 233.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(4.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox().expanded(),
              BaseText(
                text: '手机交易码',
                fontSize: 16.sp,
                textAlign: TextAlign.center,
              ).expanded(),
              const SizedBox().expanded(),
            ],
          ).withPadding(
            top: 10.w,bottom: 10.w,
            left: 12.w,right: 12.w
          ),
          Container(
            width: 1.sw,
            height: 0.5.w,
            color: Color(0xffD8D8E0),
          ),

          BaseText(text: '已发送至尾号1234的手机',color: Color(0xff222222),).withPadding(
            top: 16.w,bottom: 12.w,
              left: 20.w,
          ),
          Container(
            height: 43.w,
            margin: EdgeInsets.only(left: 20.w,right: 20.w,),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff666666),
                width: 0.8
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Pinput(
                  length: 6,
                  separatorBuilder: (index) => Container(width: 1.w,color: Color(0xffdedede),),
                  onCompleted: (pin) {
                    // Map<String,dynamic> data = widget.reqPrint.toJson();
                    // print(data);
                    // Http.post(Apis.flowExportPrint,data: data,).then((v){
                    //   if(v != null){
                    //     Get.back();
                    //     Get.to(() => PrintResultPage(),arguments: {
                    //       'req':widget.reqPrint,
                    //     });
                    //   }
                    // });
                  },
                  defaultPinTheme: PinTheme(
                    width: 42.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                  ),
                ).expanded(),
              ],
            ),
          ),


          SizedBox(height: 12.w,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(
                text: '收不到短信？',
                fontSize: 12.sp,
                color: Color(0xff2D70ED),
              ).withPadding(left: 12.w,),
              WzhCountDownBtn(
                controller: downBtnController,
                showBord: false,
                textColor: Colors.black,
                getVCode: () async {
                  return true;
                },
              )
            ],
          ).withPadding(
            left: 18.w,right: 18.w,
          ),
          SizedBox(height: 16.w),
          Container(
            width: 1.sw,
            height: 0.5.w,
            color: Color(0xffD8D8E0),
          ),
          Container(
            width: 1.sw,
            height: 38.w,
            alignment: Alignment.center,
            child: BaseText(text: '确认',color: Color(0xffDC0034),),
          ).withOnTap(onTap: (){
            SmartDialog.dismiss();
            widget.callBack();
          })
        ],
      ),
    );
  }
}

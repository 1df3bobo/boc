import 'package:boc/config/app_config.dart';
import 'package:boc/pages/tabs/home/bill/bill_view.dart';
import 'package:boc/pages/tabs/home/transfer/transfer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../other/fixed_nav/fixed_nav_view.dart';
import '../../home/transfer/card_transfer/card_transfer_view.dart';
import 'account_preview_logic.dart';
import 'account_preview_state.dart';

class AccountPreviewPage extends BaseStateless {
  AccountPreviewPage({Key? key}) : super(key: key, title: '账户总览');

  final AccountPreviewLogic logic = Get.put(AccountPreviewLogic());
  final AccountPreviewState state = Get.find<AccountPreviewLogic>().state;

  @override
  Color? get background => Color(0xffF4F4F4);

  @override
  Color? get navColor => Color(0xffF4F4F4);

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 12.w),
      children: [
        Obx(() => Stack(
              children: [
                Image(image: 'a_yl_top'.png3x).withPadding(
                  left: 14.w,
                  right: 14.w,
                ),
                Positioned(
                    top: 25.w,
                    left: 175.w,
                    child: Image(
                      image: logic.eyeOpen.value
                          ? 'eye_open'.png3x
                          : 'eye_close'.png3x,
                      width: 18.w,
                      color: Color(0xff613000),
                    ).withOnTap(onTap: (){
                      logic.eyeOpen.value = !logic.eyeOpen.value;
                    })),
                Positioned(
                    top: 55.w,
                    left: 35.w,
                    child: Row(
                      children: [
                        BaseText(
                          text:!logic.eyeOpen.value?'******':AppConfig.config.abcLogic.balance(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color(0xff613000)),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Image(
                          image: 'right_corlo'.png3x,
                          width: 18.w,
                          color: Color(0xff613000),
                        )
                      ],
                    )),
                Positioned(
                    top: 99.w,
                    left: 120.w,
                    child: Row(
                      children: [
                        BaseText(
                          text: !logic.eyeOpen.value?'******':'--',
                          style:
                              TextStyle(color: Color(0xff613000), fontSize: 16),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Image(
                          image: 'right_corlo'.png3x,
                          width: 18.w,
                          color: Color(0xff613000),
                        )
                      ],
                    ))
              ],
            )),
        SizedBox(
          height: 28.w,
        ),
        const BaseText(
          text: '中行卡',
          color: Color(0xff666666),
          fontSize: 13,
        ).withPadding(
          left: 18.w,
        ),
        Stack(
          children: [
            Image(image: 'a_yl_bottom'.png3x).withPadding(
              left: 6.w,
              right: 6.w,
            ),
            Positioned(
                top: 25.w,
                left: 95.w,
                child: Container(
                  width: 1.sw - 120.w,
                  height: 42.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: AppConfig.config.abcLogic.card(),
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff222222)),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      BaseText(
                        text: '长城电子借记卡 （I类账户）',
                        style:
                            TextStyle(fontSize: 13, color: Color(0xff666666)),
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: 25.w + 60.w,
                left: 95.w,
                child: Container(
                  width: 1.sw - 120.w,
                  height: 42.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BaseText(
                        text: '人民币元 ',
                        style:
                            TextStyle(fontSize: 13, color: Color(0xff666666)),
                      ),
                      BaseText(
                        text: AppConfig.config.abcLogic.balance(),
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff222222),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
            Positioned(
              bottom: 100.w,
              left: 20.w,
              child: Container(
                width: 1.sw - 40.w,
                height: 50.w,
                child: Row(
                  children: [
                    Container().expanded(onTap: () {
                      Get.to(() => BillPage());
                    }),
                    Container().expanded(onTap:(){
                      // Get.to(() => TransferPage());
                      Get.to(() => CardTransferPage());
                    }),
                    Container().expanded(onTap: (){
                      Get.to(()=>FixedNavPage(),arguments: {
                        'image':'mlc_bg',
                        'title':'产品列表',
                      });
                    }),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

import 'package:boc/pages/other/webview_page/webview_page_view.dart';
import 'package:boc/pages/tabs/home/transfer/share_card/withdrawal_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../config/app_config.dart';
import 'share_card_logic.dart';
import 'share_card_state.dart';

class ShareCardPage extends BaseStateless {
  ShareCardPage({Key? key}) : super(key: key, title: '收款名片');

  final ShareCardLogic logic = Get.put(ShareCardLogic());
  final ShareCardState state = Get.find<ShareCardLogic>().state;

  @override
  List<Widget>? get rightAction => [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: 'ic_ke'.png3x,
              width: 20.w,
              height: 20.w,
              color: Colors.black,
            ),
            BaseText(
              text: '客服',
              fontSize: 12.sp,
              color: Colors.black,
            ),
          ],
        ).withOnTap(onTap: () {
          Get.to(() => WebViewPage(),
              arguments: {'routeName': '/customerService'});
        }),
        SizedBox(width: 16.w),
      ];

  void _showPasswordDialog() {
    final fullCard = AppConfig.config.abcLogic.card1().formatBankCardNumber();
    SmartDialog.show(
      builder: (context) => WithdrawalPasswordDialog(
        fullCardNumber: fullCard,
        onRevealed: () => logic.revealCard(),
      ),
    );
  }

  void _showShareCardBottomSheet(BuildContext context) {
    final realName = AppConfig.config.abcLogic.memberInfo.realName;
    final accountNo =
        AppConfig.config.abcLogic.card1().formatBankCardNumber();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: 'share_card_bottom'.png3x,
            width: 1.sw,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            left: 125.w,
            top: 110.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 50.w, top: 5.w, bottom: 5.w, left: 10.w),
                  color: Colors.white,
                  child: BaseText(
                    text: realName,
                    fontSize: 16.sp,
                    color: Colors.black,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.0
                    ),
                  ),
                ),
                SizedBox(height: 19.w),
                Container(
                  padding: EdgeInsets.only(right: 50.w, top: 5.w, bottom: 5.w, left: 10.w),
                  color: Colors.white,
                  child: BaseText(
                    text: accountNo,
                    fontSize: 15.sp,
                    color: Colors.black,
                    style: TextStyle(
                      fontSize: 15.sp,
                      letterSpacing: 0.5,
                      height: 1.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12.w,
            right: 12.w,
            child: GestureDetector(
              onTap: () => Navigator.of(ctx).pop(),
              child: Icon(Icons.close, size: 24.w, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget initBody(BuildContext context) {
    final maskedCard = AppConfig.config.abcLogic.card();
    final fullCard = AppConfig.config.abcLogic.card1().formatBankCardNumber();

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.w),
            GetBuilder<ShareCardLogic>(
              builder: (logic) {
                final displayCard =
                    logic.state.showFullCard ? fullCard : maskedCard;
                return Stack(
                  children: [
                    Image(
                      image: 'share_card'.png3x,
                      width: 1.sw,
                      fit: BoxFit.fitWidth,
                    ),
                    Positioned(
                      right: 50.w,
                      top: 102.w,
                      child: Text(
                        displayCard,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          height: 1.0,
                          fontFamily: "boc"
                        ),
                      ),
                    ),
                    Positioned(
                      top: 350.w,
                      child: Container(
                        width: 1.sw * 0.5,
                        height: 60.w,
                      ).withOnTap(onTap: () => _showPasswordDialog())),
                    Positioned(
                      top: 350.w,
                      left: 1.sw * 0.5,
                      child: Container(
                        width: 1.sw * 0.5,
                        height: 60.w,
                      ).withOnTap(onTap: () => _showShareCardBottomSheet(context)))
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

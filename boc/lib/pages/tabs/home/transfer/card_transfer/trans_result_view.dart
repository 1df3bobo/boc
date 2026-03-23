import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'package:boc/pages/component/right_widget.dart';
import 'package:boc/pages/other/webview_page/webview_page_view.dart';
import 'package:boc/routes/app_pages.dart';

import 'card_req.dart';

/// 关闭「确认信息 + 转账表单」等路由后进入本页，并带上 [CardReq]。
void openTransferResultPage(CardReq req) {
  Get.offUntil(
    GetPageRoute(
      page: () => const TransResultPage(),
      routeName: Routes.transResultPage,
      settings: RouteSettings(
        name: Routes.transResultPage,
        arguments: {'req': req},
      ),
    ),
    (route) => route.isFirst,
  );
}

class TransResultPage extends BaseStateless {
  const TransResultPage({super.key}) : super(title: '操作结果');

  @override
  List<Widget>? get rightAction => [
        InkWell(
          onTap: () => Get.to(
            () => WebViewPage(),
            arguments: {'routeName': '/customerService'},
          ),
          child: RightWidget.rightImage(imgPath: 'ic_ke'),
        ),
        SizedBox(width: 18.w),
      ];

  CardReq _req(BuildContext context) {
    final args = Get.arguments;
    if (args is Map && args['req'] is CardReq) {
      return args['req'] as CardReq;
    }
    return CardReq();
  }

  @override
  Widget initBody(BuildContext context) {
    final req = _req(context);
    final amountStr = (double.tryParse(req.amount) ?? 0).bankBalance;
    return Semantics(
      label: '操作结果 ${req.realName} $amountStr 元',
      child: ColoredBox(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Image(
              image: 'trans_result_bg'.png3x,
              width: 1.sw,
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              top: 83.w,
              left: 0,
              right: 0,
              child: Center(
                child: BaseText(
                  text: '$amountStr元交易成功',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff222222),
                    height: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

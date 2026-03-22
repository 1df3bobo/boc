import 'dart:math' show pi;

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

import '../../../other/fixed_nav/fixed_nav_view.dart';
import '../../../other/webview_page/webview_page_view.dart';
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
                    top: 10.w,
                    right: 25.w,
                    child: Container(
                      width: 50.w,
                      height: 50.w,
                    ).withOnTap(onTap: () {
                      Get.dialog(
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Material(
                            color: Colors.black54,
                            child: Center(
                              child: Image(
                                image: 'zhzl_gth'.png3x,
                                width: 1.sw,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                        barrierColor: Colors.black54,
                      );
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
                        !logic.eyeOpen.value?Image(
                          image: 'right_corlo'.png3x,
                          width: 18.w,
                          color: Color(0xff613000),
                        ): _SpinningRefreshIcon(
                          width: 15.w,
                          color: const Color(0xff613000),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseText(
              text: '中行卡',
              color: Color(0xff666666),
              fontSize: 13,
            ).withPadding(
              left: 18.w,
            ),
            _SpinningRefreshIcon(
              width: 10.w,
              color: const Color(0xff613000),
            ).withPadding(
              right: 18.w,
            ),
          ],
        ),
        Stack(
          children: [
            Image(image: 'a_yl_bottom'.png3x).withPadding(
              left: 6.w,
              right: 6.w,
            ).withOnTap(onTap: (){
              Get.to(() => AccountInfoPage());
            }),
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
                      Obx(() => BaseText(
                        text: !logic.eyeOpen.value?'******':AppConfig.config.abcLogic.balance(),
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff222222),
                            fontWeight: FontWeight.bold),
                      )),
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
            Positioned(
                bottom: 0,
                child: Container(
                  width: 1.sw,
                  height: 80.w,
                ).withOnTap(onTap: () {
                  Get.to(() => FixedNavPage(), arguments: {
                    'image': 'zhgl',
                    'title': '账户关联',
                    'centerTitle': true,
                  });
                })),
          ],
        ),
        Container(
          width: 1.sw,
          height: 80.w,
        ).withOnTap(onTap: () {
          Get.to(() => FixedNavPage(), arguments: {
            'image': 'qqzhfw',
            'title': '全球账户服务',
            'rightWidget': [
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: InkWell(
                  onTap: () => Get.to(
                    () => WebViewPage(),
                    arguments: {'routeName': '/customerService'},
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Image(
                      image: 'ic_ke'.png3x,
                      width: 22.w,
                      height: 22.w,
                      color: const Color(0xFF333333),
                    ),
                  ),
                ),
              ),
            ],
          });
        }),
      ],
    );
  }
}

/// 点击后顺时针旋转 3 周，结束后复位。
class _SpinningRefreshIcon extends StatefulWidget {
  const _SpinningRefreshIcon({
    required this.width,
    required this.color,
  });

  final double width;
  final Color color;

  @override
  State<_SpinningRefreshIcon> createState() => _SpinningRefreshIconState();
}

class _SpinningRefreshIconState extends State<_SpinningRefreshIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (_controller.isAnimating) return;
        _controller.forward(from: 0);
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 4 * pi,
            child: child,
          );
        },
        child: Image(
          image: 'mine_refresh'.png3x,
          width: widget.width,
          color: widget.color,
        ),
      ),
    );
  }
}

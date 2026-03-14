import 'package:boc/config/abc_config/balance_eye_widget.dart';
import 'package:boc/pages/other/fixed_nav/fixed_nav_view.dart';
import 'package:boc/pages/other/webview_page/webview_page_view.dart';
import 'package:boc/pages/tabs/home/transfer/card_transfer/component/scan_card_view.dart';
import 'package:boc/pages/tabs/home/transfer/transfer_view.dart';
import 'package:boc/utils/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../other/change_nav/change_nav_view.dart';
import '../../mine/account_preview/account_preview_view.dart';

class HomeTopWidget extends StatefulWidget {
  const HomeTopWidget({super.key});

  @override
  State<HomeTopWidget> createState() => _HomeTopWidgetState();
}

class _HomeTopWidgetState extends State<HomeTopWidget> {
  List titleName = [
    '扫一扫',
    '闲钱宝',
    '转账',
    '账户管理',
  ];

  List<String> imgList = [
    'ic_scan',
    'ic_xqm',
    'ic_zz',
    'ic_zhgl',
  ];

  void jumpPage(String name) {
    if (name == '扫一扫') {
      Get.to(() => const ScanCardPage(), arguments: {'mode': '扫一扫'});
      return;
    }
    if (name == '转账') {
      Get.to(() => TransferPage());
    }
    if (name == '账户管理') {
      Get.to(() => AccountPreviewPage());
    }
    if (name == '闲钱宝') {
      Get.to(() => ChangeNavPage(), arguments: {
        'image': 'xqb_bg',
        'title': '闲钱宝',
        'defTitleColor': Colors.white,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final navHeight = MediaQuery.of(context).padding.top + 44.w;
    return Stack(
      children: [
        Image(image: 'bg_home_top'.png3x, fit: BoxFit.fitWidth, width: 1.sw,).withOnTap(onTap: () {
          Get.to(() => FixedNavPage(), arguments: {
            'image': 'home_top_bg',
            'title': '支付超给利',
            'rightWidget': [
              CustomButton.rightSearchButton(
                color: Colors.grey,
                size: 24.w,
                icon: Icons.share,
              ),
            ],
          });
        }),
        Positioned(
          top: navHeight + 18.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: titleName.map((e) {
              return Container(
                width: 50.w,
                height: 60.w,
              ).withOnTap(onTap: () => jumpPage(e));
            }).toList(),
          ).withContainer(width: 1.sw),
        ),
      ],
    );
  }
}

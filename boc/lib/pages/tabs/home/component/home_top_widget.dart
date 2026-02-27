import 'package:boc/config/abc_config/balance_eye_widget.dart';
import 'package:boc/pages/other/webview_page/webview_page_view.dart';
import 'package:boc/pages/tabs/home/transfer/transfer_view.dart';
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
        Image(image: 'bg_home_top'.png3x),
        Positioned(
          top: navHeight + 25.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: titleName.map((e) {
              return Column(
                children: [
                  Image(
                    image: imgList[titleName.indexOf(e)].png3x,
                    width: 37.w,
                    height: 37.w,
                  ),
                  BaseText(text: e)
                ],
              ).withOnTap(onTap: () => jumpPage(e));
            }).toList(),
          ).withContainer(width: 1.sw),
        ),
      ],
    );
  }
}

import 'package:boc/config/app_config.dart';
import 'package:boc/pages/other/fuzai/fuzai_view.dart';
import 'package:boc/pages/tabs/mine/account_preview/account_preview_view.dart';
import 'package:boc/pages/tabs/mine/component/mine_zc_widget.dart';
import 'package:boc/pages/tabs/mine/wdjf/wdjf_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../component/placeholder_search_widget.dart';
import '../../other/change_nav/change_nav_view.dart';
import '../../other/fixed_nav/fixed_nav_view.dart';
import '../../other/webview_page/webview_page_view.dart';
import 'mine_logic.dart';
import 'mine_state.dart';

class MinePage extends BaseStateless {
  MinePage({Key? key}) : super(key: key);

  final MineLogic logic = Get.put(MineLogic());
  final MineState state = Get
      .find<MineLogic>()
      .state;

  @override
  bool get isChangeNav => true;

  @override
  Widget? get titleWidget =>
      PlaceholderSearchWidget(
        width: 220.w,
        contentList: const ['账单', '优惠活动', '明细查询'],
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.5),
        textColor: Colors.black,
      );

  @override
  Widget? get leftItem =>
      Row(
        children: [
          SizedBox(width: 16.w),
          _mineTag(img: 'ic_exit', name: '退出'),
          SizedBox(width: 16.w),
        ],
      );

  @override
  double? get lefItemWidth => 59.w;

  @override
  List<Widget>? get rightAction =>
      [
        SizedBox(width: 10.w),
        _mineTag(img: 'mine_setting', name: '设置').withOnTap(onTap: () {
          Get.to(() => WebViewPage(),
              arguments: {'routeName': '/Settings'});
        }),
        SizedBox(width: 18.w),
        _mineTag(img: 'ic_ke', name: '客服').withOnTap(onTap: () {
          Get.to(() => WebViewPage(),
              arguments: {'routeName': '/customerService'});
        }),
        SizedBox(width: 18.w),
        _mineTag(img: 'ic_msg', name: '消息').withOnTap(onTap: () {
          Get.to(() => FixedNavPage(), arguments: {
            'image': 'myNews',
            'title': '我的消息',
          });
        }),
        SizedBox(width: 16.w),
      ];

  @override
  Function(bool change)? get onNotificationNavChange =>
          (v) {
        logic.navActionColor.value = v ? Colors.black : Colors.white;
      };

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            Image(image: 'main_bg1'.png3x),
            Positioned(
                bottom: 115.w,
                left: 22.w,
                child: Row(
                  children: [
                    Image(
                      image: 'mine_head'.png3x,
                      width: 60.w,
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseText(
                          text: '晚上好，${logic.maskName()}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        BaseText(
                          text: '上次登录:${AppConfig.config.abcLogic.memberInfo
                              .loginTime}',
                          fontSize: 10,
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                ).withOnTap(onTap: () {
                  Get.to(() => WebViewPage(),
                      arguments: {'routeName': '/userInfo'});
                }))
          ],
        ),
        Stack(
          children: [
            Image(image: 'main_bg2'.png3x),
            Positioned(
                bottom: 45.w,
                left: 35.w,
                child: Container(
                  width: 45.w,
                  height: 45.w,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 11.w),
                  child: const BaseText(
                    text: '1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )),
            Positioned(child: Row(
              spacing: 12.w,
              children: [
                Container().expanded(onTap: () {
                  Get.to(() => AccountPreviewPage());
                }),
                Container().expanded(onTap: () {
                  Get.to(() => ChangeNavPage(),
                      arguments: {
                        'image': 'zxqy',
                        'title': '尊享权益'
                      });
                }),
                Container().expanded(onTap: () {
                  Get.to(() => WdjfPage());
                }),
                Container().expanded(onTap: () {
                  Get.to(() => FuzaiPage());
                }),
              ],
            ).withContainer(
              width: 1.sw,
              height: 90.w,
              padding: EdgeInsets.only(left: 24.w,right: 24.w)
            ))
          ],
        ),
        Stack(
          children: [
            Image(image: 'main_bg3'.png3x),
            Positioned(
                top: 8.w,
                left: 88.w,
                child: Image(
                  image: 'eye_open'.png3x,
                  width: 22.w,
                )),
            Positioned(
                top: 90.w,
                left: 30.w,
                right: 30.w,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          height: 22.w,
                          child: BaseText(
                            text: '¥${AppConfig.config.abcLogic.balance()}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        )),
                    Expanded(
                        child: Container(
                            height: 22.w,
                            alignment: Alignment.bottomRight,
                            child: BaseText(
                              text: '--',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ))),
                  ],
                )),
            Positioned(
                top: 175.w,
                left: 30.w,
                right: 30.w,
                child: const MineZcWidget()),

            Positioned(top: 50.w, left: 20.w, child: Container(
              width: 1.sw - 40.w,
              height: 80.w,
              child: Row(
                children: [
                  Container().expanded(onTap: () {
                    Get.to(() => WebViewPage(),
                        arguments: {'routeName': '/asset'});
                  }),
                  Container().expanded(onTap: () {
                    Get.to(() => WebViewPage(),
                        arguments: {'routeName': '/earnings'});
                  }),
                ],
              ),
            ))
          ],
        ),
        Stack(
          children: [
            Image(image: 'main_bg4'.png3x),

            Positioned(
                top: 45.w,
                left: 12.w, right: 12.w,
                child: Row(children: [
                  Container(
                    width: 1.sw * 0.58,
                    height: 140.w,
                  ).withOnTap(onTap: () {
                    Get.to(() => FixedNavPage(), arguments: {
                      'image': 'websiteList',
                      'title': '网点列表',
                    });
                  }),
                  Container(
                    width: 1.sw * 0.32,
                    height: 140.w,
                    child: Column(
                      children: [
                        Container().expanded(onTap: () {

                        }),
                        Container().expanded(onTap: () {
                          Get.to(() => ChangeNavPage(),
                              arguments: {
                                'image': 'wbxcyy',
                                'title': '外币现钞预约'
                              });
                        }),
                        Container().expanded(onTap: () {
                          Get.to(() => FixedNavPage(), arguments: {
                            'image': 'jjgs',
                            'title': '紧急挂失',
                          });
                        }),
                      ],
                    ),
                  )
                ],))
          ],
        ),
        Stack(
          children: [
            Image(image: 'main_bg5'.png3x),
            Positioned(
              top: 45.w,
              left: 12.w, right: 12.w,
              child:Column(
                children: [

                  Row(
                    children: [
                      Container(
                        width: 1.sw/2 - 18.w,
                        height: 220.w,
                      ).withOnTap(onTap: (){
                        Get.to(() => ChangeNavPage(), arguments: {
                          'image': 'grxybg',
                          'title': '征信查询',
                        });
                      }),
                      SizedBox(
                        width: 12.w,
                      ),
                      Container(
                        width: 1.sw/2 - 18.w,
                        height: 220.w,
                      ).withOnTap(onTap: (){
                        Get.to(() => FixedNavPage(), arguments: {
                          'image': 'myShare',
                          'title': '我的分享',
                        });
                      }),
                    ],
                  )
                ],
              ),)
          ],
        )
      ],
    );
  }


  Widget _mineTag({
    required String img,
    required String name,
  }) {
    return Obx(() =>
        Column(
          children: [
            Image(
              image: img.png3x,
              width: 20.w,
              height: 20.w,
              color: logic.navActionColor.value,
            ),
            BaseText(
              text: name,
              fontSize: 12.sp,
              color: logic.navActionColor.value,
            )
          ],
        ));
  }
}

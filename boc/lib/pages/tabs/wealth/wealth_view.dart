import 'package:boc/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../component/placeholder_search_widget.dart';
import '../../other/change_nav/change_nav_view.dart';
import '../../other/fixed_nav/fixed_nav_view.dart';
import '../../other/webview_page/webview_page_view.dart';
import 'wealth_logic.dart';
import 'wealth_state.dart';

class WealthPage extends BaseStateless {
  WealthPage({Key? key}) : super(key: key);

  final WealthLogic logic = Get.put(WealthLogic());
  final WealthState state = Get.find<WealthLogic>().state;

  @override
  double? get lefItemWidth => 17.w;

  @override
  Widget? get leftItem => SizedBox.shrink();

  @override
  Widget? get titleWidget => PlaceholderSearchWidget(
        width: 312.w,
        contentList: const ['账单', '优惠活动', '明细查询'],
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.5),
        textColor: Colors.black,
      );

  @override
  List<Widget>? get rightAction => [
        SizedBox(width: 18.w),
        _cardTag(img: 'right_cart', name: '购物车'),
        SizedBox(width: 18.w),
        _cardTag(img: 'ic_ke', name: '客服').withOnTap(onTap: (){
          Get.to(() => WebViewPage(),
              arguments: {'routeName': '/customerService'});
        }),
        SizedBox(width: 18.w),
      ];

  Widget _cardTag({
    required String img,
    required String name,
  }) {
    return Obx(() => Column(
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

  String _textValue(String value) {
    return logic.eyeOpen.value ? value : '******';
  }

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      children: [
        Obx(() {
          return (logic.showMore.value
              ? _topWidget('cf_top1', children: [
                  Positioned(
                    bottom: 0,
                    left: 1.sw / 2 - 16.w,
                    child: SizedBox(
                      width: 32.w,
                      height: 32.w,
                    ).withOnTap(onTap: () {
                      logic.showMore.value = !logic.showMore.value;
                    }),
                  ),
                  Positioned(
                      top: 22.w,
                      left: 145.w,
                      child: Image(
                        image: logic.eyeOpen.value
                            ? 'eye_open'.png3x
                            : 'eye_close'.png3x,
                        color: Colors.white,
                        width: 22.w,
                      ).withOnTap(onTap: () {
                        logic.eyeOpen.value = !logic.eyeOpen.value;
                      })),
                  Positioned(
                      top: 55.w,
                      left: 26.w,
                      right: 45.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            text:
                                _textValue(AppConfig.config.abcLogic.balance()),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          BaseText(
                            text: _textValue('--'),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      )),
                  Positioned(
                      top: 55.w + 85.w,
                      left: 26.w,
                      right: 45.w,
                      child: Row(
                        children: [
                          BaseText(
                            text: _textValue('徘多元配置 攻守兼备'),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ).expanded(),
                          SizedBox(
                            width: 42.w,
                          ),
                          BaseText(
                            text: _textValue('投资理财 稳健致远'),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ).expanded(),
                        ],
                      )),
                  Positioned(
                      top: 55.w + 85.w + 45.w,
                      left: 26.w,
                      right: 45.w,
                      child: Row(
                        children: [
                          BaseText(
                            text: _textValue('0.00'),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ).expanded(),
                          SizedBox(
                            width: 42.w,
                          ),
                          BaseText(
                            text: _textValue('优选配置'),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ).expanded(),
                        ],
                      )),
                  Positioned(
                      top: 55.w + 85.w + 45.w + 48.w,
                      left: 26.w,
                      right: 45.w,
                      child: Row(
                        children: [
                          BaseText(
                            text:
                                _textValue(AppConfig.config.abcLogic.balance()),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ).expanded(),
                          SizedBox(
                            width: 42.w,
                          ),
                          const BaseText(
                            text: '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ).expanded(),
                        ],
                      )),
                ])
              : _topWidget('cf_top2', children: [
                  Positioned(
                    bottom: 0,
                    left: 1.sw / 2 - 16.w,
                    child: SizedBox(
                      width: 32.w,
                      height: 32.w,
                    ).withOnTap(onTap: () {
                      logic.showMore.value = !logic.showMore.value;
                    }),
                  ),
                  Positioned(
                      top: 22.w,
                      left: 145.w,
                      child: Image(
                        image: logic.eyeOpen.value
                            ? 'eye_open'.png3x
                            : 'eye_close'.png3x,
                        color: Colors.white,
                        width: 22.w,
                      ).withOnTap(onTap: () {
                        logic.eyeOpen.value = !logic.eyeOpen.value;
                      })),
                  Positioned(
                      top: 55.w,
                      left: 26.w,
                      right: 45.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            text: _textValue(AppConfig.config.abcLogic.balance()),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          BaseText(
                            text: _textValue('--'),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ))
                ]));
        }),

        Stack(
          children: [
            Image(image: 'cf_tag1'.png3x),
            VerticalGridView(
              padding: EdgeInsets.only(left: 15.w,right: 15.w),
              widgetBuilder: (_, index) {
                return SizedBox(
                  width: 45.w,
                  height: 45.w,
                ).withOnTap(onTap: () => jumpPage('$index'));
              },
              itemCount: 10,
              crossCount: 5,
              mainHeight: 58.w,
              spacing: 12.w,
            )
          ],
        ),
        Stack(
          children: [
            Image(image: 'bg_cf'.png3x),

            Positioned(
                top: 55.w,
                left: 15.w,right: 15.w,
                child: Container(
              width: 1.sw,
              height: 160.w,
            ).withOnTap(onTap: (){
                  Get.to(() => FixedNavPage(), arguments: {
                    'image': 'dqqlc',
                    'title': '短期理财闲 钱动起来',
                  });
                }))
          ],
        )
      ],
    );
  }

  void jumpPage(String tag) {
    int index = int.tryParse(tag) ?? -1;
    switch (index){
      case 0:

        Get.to(() => ChangeNavPage(), arguments: {
          'image': 'hqb',
          'title': '',
          'leftWidget':Container(width: 90.w,height: 45.w,).withOnTap(onTap: (){
            Get.back();
          })

        });
        break;
      case 1:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'lc',
          'title': '理财',
        });
        break;
      case 2:
        break;
      case 3:

        Get.to(() => ChangeNavPage(),
            arguments: {
              'image': 'jhgh',
              'title': '结汇购汇',
              'top':ScreenUtil().statusBarHeight
            });
        break;
      case 4:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'jj',
          'title': '基金',
        });
        break;
      case 5:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'jgxck',
          'title': '结构性存款',
        });
        break;
      case 6:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'zhgjs',
          'title': '开通积存金',
        });
        break;
      case 7:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'ktjcj',
          'title': '开通积存金',
        });
        break;
      case 8:
        Get.to(() => ChangeNavPage(),
            arguments: {
              'image': 'zyht',
              'title': '',
              'leftWidget':Container(width: 90.w,height: 45.w,).withOnTap(onTap: (){
                Get.back();
              })
            });
        break;
      case 9:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'dz1',
          'title': '更多',
        });
        break;
    }
  }

  Widget _topWidget(String name, {required List<Widget> children}) {
    return Stack(
      children: [Image(image: name.png3x), ...children],
    );
  }
}

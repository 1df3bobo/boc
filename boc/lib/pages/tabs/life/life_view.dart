import 'package:boc/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/component/swiper_horizontal.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../utils/common_right_button.dart';
import '../../../utils/customButton.dart';
import '../../../utils/stack_position.dart';
import '../../component/placeholder_search_widget.dart';
import '../../other/change_nav/change_nav_view.dart';
import '../../other/fixed_nav/fixed_nav_view.dart';
import '../../other/fuzai/fuzai_view.dart';
import '../../other/webview_page/webview_page_view.dart';
import 'life_logic.dart';
import 'life_state.dart';

class LifePage extends BaseStateless {
  LifePage({Key? key}) : super(key: key);

  final LifeLogic logic = Get.put(LifeLogic());
  final LifeState state = Get.find<LifeLogic>().state;

  @override
  bool get isChangeNav => true;

  @override
  Widget? get titleWidget => PlaceholderSearchWidget(
        width: 220.w,
        contentList: const ['账单', '优惠活动', '明细查询'],
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.5),
        textColor: Colors.black,
      );

  @override
  Widget? get leftItem => Row(
        children: [
          SizedBox(width: 16.w),
          _lifeTag(img: 'dw', name: '合肥'),
          SizedBox(width: 16.w),
        ],
      );

  @override
  double? get lefItemWidth => 59.w;

  @override
  List<Widget>? get rightAction => [
        SizedBox(width: 10.w),
        _lifeTag(img: 'sys', name: '扫一扫'),
        SizedBox(width: 18.w),
        _lifeTag(img: 'ic_ke', name: '客服').withOnTap(onTap: () {
          Get.to(() => WebViewPage(),
              arguments: {'routeName': '/customerService'});
        }),
        SizedBox(width: 16.w),
      ];

  @override
  Function(bool change)? get onNotificationNavChange => (v) {
        logic.navActionColor.value = v ? Colors.black : Colors.white;
      };

  @override
  Color? get background => Colors.white;

  Widget _lifeTag({
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

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(width: 1.sw, height: 250.w + 50.w),
            SwiperHorizontal(
                itemCount: 2,
                activeColor: Colors.transparent,
                color: Colors.transparent,
                widgetBuilder: (_, index) {
                  return Image(
                    image: 'life_b_01'.png3x,
                    width: 1.sw,
                    fit: BoxFit.fitWidth,
                  );
                }).withSizedBox(width: 1.sw, height: 250.w),
            Positioned(
              bottom: 0,
              child: Image(
                image: 'lift_b_02'.png3x,
                width: 1.sw - 26.w,
              ),
            ),

            Positioned(
                bottom: 10,
                child: Row(
              children: [
                Container().expanded(onTap: (){
                  Get.to(() => FixedNavPage(), arguments: {
                    'image': 'shjf',
                    'title': '生活缴费',
                  });
                }),
                Container().expanded(onTap: (){
                  Get.to(()=>FixedNavPage(),arguments: {
                    'image':'home_hfcz',
                    'title':'话费充值',
                    'top':10.w,
                    'rightWidget':[
                      CustomButton.rightServiceButton(
                        color: Colors.grey,
                        size: 24.w,
                        icon: Icons.phone,
                      ),
                      CustomButton.rightSearchButton(
                        color: Colors.grey,
                        size: 24.w,
                        icon: Icons.share,
                      ),
                    ]
                  });
                }),
                Container().expanded(onTap: (){
                  Get.to(() => FixedNavPage(), arguments: {
                    'image': 'bj',
                    'title': AppConfig.config.abcLogic.memberInfo.city,
                  });
                }),
                Container().expanded(onTap: (){
                  Get.to(() => FuzaiPage());
                }),
              ],
            ).withContainer(
                  width: 1.sw - 24.w,
                  height: 76.w,
                margin: EdgeInsets.only(left: 12.w,right: 12.w,),
                ),)
          ],
        ),

        Stack(
          children: [
            Image(image: 'life_b_03'.png3x),
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
        SizedBox(height: 20.w,),
        Image(image: 'life_b_04'.png3x),
        Builder(
          builder: (context) {
            final sp = StackPosition(
              designWidth: 750,
              designHeight: 5382,
              deviceWidth: 1.sw,
            );
            return SizedBox(
              width: 1.sw,
              height: sp.deviceHeight,
              child: Stack(
                children: [
                  Image(
                    image: 'life_b_05'.png3x,
                    width: 1.sw,
                    height: sp.deviceHeight,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 150.w,
                    left: 0,
                    right: 0,
                    height: 240.w,
                    child: Container().withOnTap(onTap: () {
                      Get.to(() => FixedNavPage(), arguments: {
                        'image': 'zysy',
                        'title': '中银善源',
                        'centerTitle': false,
                        'rightWidget': [
                          CommonNavButtonUtil.xcxButton(),
                        ],
                      });
                    }),
                  ),
                  StackPositionGridWidget.custom(
                    stackPosition: sp,
                    x: 0,
                    y: 770,
                    bottomMargin: 3119,
                    rightMargin: 0,
                    crossCount: 2,
                    itemCount: 6,
                    childBuilder: (_, __) =>
                        Container(color: Colors.transparent),
                    onItemTap: _openZysyPartnerGridNav,
                  ).build(),
                  StackPositionGridWidget.custom(
                    stackPosition: sp,
                    x: 0,
                    y: 2334,
                    bottomMargin: 2557,
                    rightMargin: 0,
                    crossCount: 2,
                    itemCount: 2,
                    childBuilder: (_, __) =>
                        Container(color: Colors.transparent),
                    onItemTap: _openZysyMallGridNav,
                  ).build(),
                  StackPositionWidget.fromDesign(
                    sp: sp,
                    x: 0,
                    y: 2824,
                    width: 750,
                    height: 493,
                  ).build(
                    onTap: () => Get.to(() => FixedNavPage(), arguments: {
                      'image': 'gcg',
                      'title': '国潮馆专区',
                      'centerTitle': false,
                      'rightWidget': [
                        CommonNavButtonUtil.xcxButton(),
                      ],
                    }),
                  ),
                  StackPositionGridWidget.custom(
                    stackPosition: sp,
                    x: 0,
                    y: 3317,
                    bottomMargin: 1070,
                    rightMargin: 0,
                    crossCount: 2,
                    itemCount: 4,
                    childBuilder: (_, __) =>
                        Container(color: Colors.transparent),
                    onItemTap: _openZysyHealthGridNav,
                  ).build(),
                  StackPositionWidget.fromDesign(
                    sp: sp,
                    x: 0,
                    y: 4393,
                    width: 750,
                    height: 490,
                  ).build(
                    onTap: () => Get.to(() => FixedNavPage(), arguments: {
                      'image': 'fhsc',
                      'title': '首页',
                      'centerTitle': false,
                      'rightWidget': [
                        CommonNavButtonUtil.xcxButton(),
                      ],
                    }),
                  ),
                  StackPositionGridWidget.custom(
                    stackPosition: sp,
                    x: 0,
                    y: 4888,
                    bottomMargin: 0,
                    rightMargin: 0,
                    crossCount: 2,
                    itemCount: 2,
                    childBuilder: (_, __) =>
                        Container(color: Colors.transparent),
                    onItemTap: _openZysyBottomGridNav,
                  ).build(),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  /// 中银善源下方 2×3 网格：设计稿 childIndex 0..5 先行后列。
  void _openZysyPartnerGridNav(int childIndex) {
    const entries = <(String image, String title)>[
      ('tbsg', '淘宝闪购'),
      ('jdcjs', '京东超级省'),
      ('cngg', '菜鸟裹裹'),
      ('sfsy', '顺丰速运 用中行'),
      ('hlcx', '哈罗优惠专区'),
      ('mt', '美团外面天天减'),
    ];
    if (childIndex < 0 || childIndex >= entries.length) return;
    final e = entries[childIndex];
    Get.to(() => FixedNavPage(), arguments: {
      'image': e.$1,
      'title': e.$2,
      'centerTitle': false,
      'rightWidget': [
        CommonNavButtonUtil.xcxButton(),
      ],
    });
  }

  /// life_b_05 第二行 2×1：云南白药 / 唯品会。
  void _openZysyMallGridNav(int childIndex) {
    const entries = <(String image, String title)>[
      ('ynbysc', '云南白药商城'),
      ('wph', '唯品会中行专区'),
    ];
    if (childIndex < 0 || childIndex >= entries.length) return;
    final e = entries[childIndex];
    Get.to(() => FixedNavPage(), arguments: {
      'image': e.$1,
      'title': e.$2,
      'centerTitle': false,
      'rightWidget': [
        CommonNavButtonUtil.xcxButton(),
      ],
    });
  }

  /// 底栏 2×1：送水到府 / 年终盛典。
  void _openZysyBottomGridNav(int childIndex) {
    const entries = <(String image, String title)>[
      ('nfsq', '送水到府'),
      ('qqsc', '年终盛典'),
    ];
    if (childIndex < 0 || childIndex >= entries.length) return;
    final e = entries[childIndex];
    Get.to(() => FixedNavPage(), arguments: {
      'image': e.$1,
      'title': e.$2,
      'centerTitle': false,
      'rightWidget': [
        CommonNavButtonUtil.xcxButton(),
      ],
    });
  }

  /// 2×2：国药 / 宠物 / 空位 / 龙江生活。
  void _openZysyHealthGridNav(int childIndex) {
    switch (childIndex) {
      case 0:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'gyzx',
          'title': '健康相伴，国药相随',
          'centerTitle': false,
          'rightWidget': [
            CommonNavButtonUtil.xcxButton(),
          ],
        });
        break;
      case 1:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'cwzq',
          'title': '宠物专区',
          'centerTitle': false,
          'rightWidget': [
            CommonNavButtonUtil.xcxButton(),
          ],
        });
        break;
      case 2:
        break;
      case 3:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'ljsh',
          'title': '首页｜龙江生活',
          'centerTitle': false,
          'rightWidget': [
            CommonNavButtonUtil.xcxButton(),
          ],
        });
        break;
    }
  }

  void jumpPage(String tag) {
    print(tag);
    int index = int.tryParse(tag) ?? -1;
    switch (index){
      case 0:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'zwfw',
          'title': '政务服务',
        });
        break;
      case 1:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'jnbyy',
          'title': '纪念币预约',
        });
        break;
      case 2:
        break;
      case 3:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'wdpd',
          'title': '网点排队',
        });
        break;
      case 4:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'swgjs',
          'title': '实物贵金属',
        });
        break;
      case 5:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'elm',
          'title': '外卖',
        });
        break;
      case 6:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'ybdzpz',
          'title': '电子医保凭证',
        });
        break;
      case 7:
        Get.to(() => ChangeNavPage(),
            arguments: {
              'image': 'zxqy',
              'title': '尊享权益'
            });
        break;
      case 8:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'zhst',
          'title': '智慧食堂',
        });
        break;
      case 9:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'dz3',
          'title': '更多',
        });
        break;
    }
  }
}

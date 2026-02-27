import 'package:boc/pages/tabs/home/component/ad_banner_widget.dart';
import 'package:boc/pages/tabs/home/component/function_banner_widget.dart';
import 'package:boc/pages/tabs/home/component/home_bottom_widget.dart';
import 'package:boc/pages/tabs/home/component/home_top_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../component/placeholder_search_widget.dart';
import '../../other/fixed_nav/fixed_nav_view.dart';
import '../../other/webview_page/webview_page_view.dart';
import 'home_logic.dart';
import 'home_state.dart';

class HomePage extends BaseStateless {
  HomePage({Key? key}) : super(key: key);

  final HomeLogic logic = Get.put(HomeLogic());
  final HomeState state = Get.find<HomeLogic>().state;

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
          _homeTag(img: 'ic_exit', name: '退出'),
          SizedBox(width: 16.w),
        ],
      );

  @override
  double? get lefItemWidth => 59.w;

  @override
  List<Widget>? get rightAction => [
        SizedBox(width: 10.w),
        _homeTag(img: 'ic_version', name: '版本').withOnTap(onTap: (){
          Get.to(() => FixedNavPage(), arguments: {
            'image': 'versionChange',
            'title': '切换版本',
          });
        }),
        SizedBox(width: 18.w),
        _homeTag(img: 'ic_ke', name: '客服').withOnTap(onTap: (){
          Get.to(() => WebViewPage(),
              arguments: {'routeName': '/customerService'});
        }),
        SizedBox(width: 18.w),
        _homeTag(img: 'ic_msg', name: '消息').withOnTap(onTap: (){
          Get.to(() => FixedNavPage(), arguments: {
            'image': 'myNews',
            'title': '我的消息',
          });
        }),
        SizedBox(width: 16.w),
      ];

  @override
  Function(bool change)? get onNotificationNavChange => (v) {
        logic.navActionColor.value = v ? Colors.black : Colors.white;
      };

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: const [
        HomeTopWidget(),
        FunctionBannerWidget(),
        AdBannerWidget(),
        HomeBottomWidget(),
      ],
    );
  }

  Widget _homeTag({
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
}

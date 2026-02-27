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

import '../../../utils/customButton.dart';
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
        Image(image: 'life_b_04'.png3x),
        Image(image: 'life_b_05'.png3x),
      ],
    );
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

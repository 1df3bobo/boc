import 'package:boc/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../component/placeholder_search_widget.dart';
import 'wdjf_logic.dart';
import 'wdjf_state.dart';

class WdjfPage extends BaseStateless {
  WdjfPage({Key? key}) : super(key: key);

  final WdjfLogic logic = Get.put(WdjfLogic());
  final WdjfState state = Get.find<WdjfLogic>().state;

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
  Widget? get leftItem => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 6.w),
        child: Obx(() => Row(
              children: [
                SizedBox(width: 12.w),
                Icon(
                  Icons.navigate_before,
                  size: 30.h,
                  color: logic.navActionColor.value,
                ).withOnTap(onTap: (){
                  Get.back();
                }),
                SizedBox(width: 6.w),
              ],
            )),
      );

  @override
  double? get lefItemWidth => 52.w;

  @override
  List<Widget>? get rightAction => [
        SizedBox(width: 10.w),
        _homeTag(img: 'shareWrite').withOnTap(onTap: () {}),
        SizedBox(width: 18.w),
        _homeTag(
          img: 'lingdang',
        ).withOnTap(onTap: () {}),
        SizedBox(width: 16.w),
      ];

  @override
  Function(bool change)? get onNotificationNavChange => (v) {
        logic.navActionColor.value = v ? Colors.black : Colors.white;
      };

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: 1.sw,
          height: ScreenUtil().statusBarHeight,
          color: Color(0xffFF6B6B),
        ),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Image(image: 'viewPoint'.png3x),
            Positioned(
              top: ScreenUtil().statusBarHeight + 35.w,
                child: BaseText(
              text: AppConfig.config.abcLogic.memberInfo.points.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white
                  ),
            ))
          ],
        )
      ],
    );
  }

  Widget _homeTag({
    required String img,
  }) {
    return Obx(() => Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 6.w),
          child: Image(
            image: img.png,
            width: 24.w,
            height: 24.w,
            color: logic.navActionColor.value,
          ),
        ));
  }
}

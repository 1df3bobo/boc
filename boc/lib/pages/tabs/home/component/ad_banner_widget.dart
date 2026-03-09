import 'package:boc/pages/other/fixed_nav/fixed_nav_view.dart';
import 'package:boc/utils/common_right_button.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({super.key});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image(
          image: 'img_ad'.png3x,
          width: 1.sw,
          fit: BoxFit.fitWidth,
        ).withPadding(
            all: 0.w
        ).withOnTap(onTap: () {
          Get.to(() => FixedNavPage(), arguments: {
            'image': 'home_ad_bg',
            'title': '中行惠出游支付领劵中心',
            'centerTitle': false,
            'rightWidget': [
              CommonNavButtonUtil.xcxButton(),
            ],
          });
        });
      },
      itemCount: 1,
      autoplay: true,
    ).withContainer(
      width: 1.sw,
      height: 120.w,
      color: Colors.white
    );
  }
}

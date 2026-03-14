import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:boc/pages/other/fixed_nav/fixed_nav_view.dart';
import 'package:boc/utils/common_right_button.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

class HomeBottomWidget extends StatefulWidget {
  const HomeBottomWidget({super.key});

  @override
  State<HomeBottomWidget> createState() => _HomeBottomWidgetState();
}

class _HomeBottomWidgetState extends State<HomeBottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: 'home_bottom1'.png3x,
          fit: BoxFit.fitWidth,
          width: 1.sw,
        ).withOnTap(onTap: () {
          Get.to(() => GestureDetector(
                onTap: () => Get.back(),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Image(
                      image: 'home_bottom1_bg'.png3x,
                      fit: BoxFit.fitWidth,
                      width: 1.sw,
                    ),
                  ],
                ),
              ));
        }),
        Image(
          image: 'home_bottom2'.png3x,
          fit: BoxFit.fitWidth,
          width: 1.sw,
        ).withOnTap(onTap: () {
          Get.to(() => FixedNavPage(), arguments: {
            'image': 'home_bottom2_bg',
            'title': '热门活动',
            'rightWidget': [
              CommonNavButtonUtil.icon(
                iconData: Icons.share,
                color: Colors.grey,
              ),
            ],
          });
        }),
        Image(
          image: 'home_bottom3'.png3x,
          fit: BoxFit.fitWidth,
          width: 1.sw,
        ).withOnTap(onTap: () {
          Get.to(() => GestureDetector(
                onTap: () => Get.back(),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Image(
                      image: 'home_bottom3_bg'.png3x,
                      fit: BoxFit.fitWidth,
                      width: 1.sw,
                    ),
                  ],
                ),
              ));
        }),
        Image(
          image: 'home_bottom4'.png3x,
          fit: BoxFit.fitWidth,
          width: 1.sw,
        ),
      ],
    );
  }
}

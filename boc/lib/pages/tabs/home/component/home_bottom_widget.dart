import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:boc/pages/other/fixed_nav/fixed_nav_view.dart';
import 'package:boc/utils/common_right_button.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:boc/pages/other/image_view_page.dart';


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
        Stack(
          children: [
            Image(
              image: 'home_bottom4'.png3x,
              fit: BoxFit.fitWidth,
              width: 1.sw,
            ),
            Positioned(
                left: 0.w,
                bottom: 30.w,
                child: Container(
                  width: 1.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 80.w,
                        height: 30.w,
                      ).withOnTap(onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Stack(
                              children: [
                                Image(
                                    image: 'yszc_sheet'.png3x,
                                    width: 1.sw,
                                    fit: BoxFit.fitWidth).withOnTap(onTap: () => Get.back()),
                              ],
                            );
                          },
                        );
                      }),
                      Container(
                        width: 80.w,
                        height: 30.w,
                      ).withOnTap(onTap: () {
                        Get.to(() => FixedNavPage(), arguments: {
                          'image': 'gywm',
                          'title': '关于我们',
                        });
                      }),
                      Container(
                        width: 80.w,
                        height: 30.w,
                      ).withOnTap(onTap: () {
                        Get.to(() => ImageViewPage(), arguments: {'image': 'tsqd'});
                      }),
                    ],
                  ),
                ))
          ],
        )
      ],
    );
  }
}

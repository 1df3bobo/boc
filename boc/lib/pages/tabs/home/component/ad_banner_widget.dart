import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          height: 120.w,
          fit: BoxFit.fill,
        ).withPadding(
            all: 12.w
        );
      },
      itemCount: 2,
      autoplay: true,
    ).withContainer(
      width: 1.sw,
      height: 120.w,
      color: Colors.white
    );
  }
}

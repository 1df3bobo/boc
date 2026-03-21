import 'package:boc/config/app_config.dart';
import 'package:boc/pages/other/change_nav/change_nav_view.dart';
import 'package:boc/pages/tabs/home/transfer/gjs/gjs_view.dart';
import 'package:boc/pages/tabs/home/transfer/transfer_view.dart';
import 'package:boc/utils/common_right_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/wb_base_widget.dart';
import 'package:boc/pages/tabs/home/ckgl/ckgl_view.dart';
import '../../../other/fixed_nav/fixed_nav_view.dart';
import 'home_more/home_more_view.dart';

class FunctionBannerWidget extends StatefulWidget {
  const FunctionBannerWidget({super.key});

  @override
  State<FunctionBannerWidget> createState() => _FunctionBannerWidgetState();
}

class _FunctionBannerWidgetState extends State<FunctionBannerWidget> {


  void jumpPage(String tag) {
    int index = int.tryParse(tag) ?? -1;
    switch (index) {
      case 0: // 账号转账
        Get.to(() => TransferPage());
        break;
      case 1: // 我的理财
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'home_lc',
          'title': '我的理财',
        });
        break;
      case 2: // 存款管理'
        Get.to(() => CkglPage());
        // Get.to(() => FixedNavPage(), arguments: {
        //   'image': 'xkgl',
        //   'title': '存款管理',
        //   'rightWidget': [
        //     CommonNavButtonUtil.image(
        //       imgPath: 'ic_ke',
        //       rightPadding: 12.w,
        //     ),
        //   ],
        // });
        break;
      case 3: // 话费充值
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'home_hfcz',
          'title': '话费充值',
          'top': 10.w,
        });
        break;
      case 4: // 贷款
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'jieqian',
          'title': '贷款',
        });
        break;
      case 5: // 马拉松专区
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'mlszq',
          'title': '马拉松专区',
          'rightWidget': [
            CommonNavButtonUtil.xcxButton(),
          ],
        });
        break;
      case 6: // 薪酬管家
        Get.to(() => ChangeNavPage(), arguments: {
          'image': 'xzgj',
          'title': '薪酬管家',
          'rightWidget': [
            CommonNavButtonUtil.iconTag(
              iconData: Icons.location_on_outlined,
              name: AppConfig.config.abcLogic.memberInfo.city,
              rightPadding: 12.w,
            ),
            CommonNavButtonUtil.tag(
              imgPath: 'ic_ke',
              name: '客服',
              rightPadding: 12.w,
            ),
            CommonNavButtonUtil.iconTag(
              iconData: Icons.share_outlined,
              name: '分享',
              rightPadding: 12.w,
            ),
          ],
        });
        break;
      case 7: // 活钱宝
        Get.to(() => Container(
          color: Colors.white,
          child: Column(
            children: [
              Image(image: "hqb".png3x, width: 1.sw, fit: BoxFit.fitWidth,).withOnTap(onTap: () {
                Get.back();
              }),
            ],
          ),
        ));        break;
      case 8: // 养老金融专区
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'yljr',
          'title': '养老金融',
          'rightWidget': [
            CommonNavButtonUtil.icon(
              iconData: Icons.share_outlined,
              rightPadding: 12.w,
            ),
            CommonNavButtonUtil.image(
              imgPath: 'ic_ke',
              rightPadding: 12.w,
              color: Colors.black
            ),
          ],
        });
        break;
      case 9: // 更多
        Get.to(() => HomeMorePage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
   return Stack(
     children: [
       Image(image: 'home_tag'.png3x,),
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
   ).withPadding(top: 12.w);
  }


}

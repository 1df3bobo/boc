import 'package:boc/pages/tabs/home/transfer/gjs/gjs_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/wb_base_widget.dart';
import 'package:get/get.dart';
import '../../../../utils/customButton.dart';
import '../../../other/fixed_nav/fixed_nav_view.dart';
import 'home_more/home_more_view.dart';

class FunctionBannerWidget extends StatefulWidget {
  const FunctionBannerWidget({super.key});

  @override
  State<FunctionBannerWidget> createState() => _FunctionBannerWidgetState();
}

class _FunctionBannerWidgetState extends State<FunctionBannerWidget> {


  void jumpPage(String tag) {
    print(tag);
    int index = int.tryParse(tag) ?? -1;
    switch (index){
      case 0:
        break;
      case 1:
       Get.to(() => GjsPage());
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'jieqian',
          'title': '随借随还',
        });
        break;
      case 5:
        break;
      case 6:
        Get.to(()=>FixedNavPage(),arguments: {
          'image':'home_lc',
          'title':'理财',
          'rightWidget':[
            CustomButton.rightServiceButton(
              color: Colors.grey,
              size: 24.w,
              icon: Icons.phone,
              onPressed:()=>print('点击了'),
            ),
            CustomButton.rightSearchButton(
              color: Colors.grey,
              size: 24.w, icon: Icons.search,
            ),
          ]
        });
        break;
      case 7:
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
        break;
      case 8:
        break;
      case 9:
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

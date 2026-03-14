import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import '../../tabs/home/bill/bill_view.dart';
import '../../tabs/home/transfer/record/record_view.dart';
import '../fixed_nav/fixed_nav_view.dart';
import '../tips_page/tips_page_view.dart';
import '../webview_page/webview_page_view.dart';
import 'kefu_logic.dart';
import 'kefu_state.dart';

class KefuPage extends BaseStateless {
  KefuPage({Key? key}) : super(key: key,title: '我的客服');

  final KefuLogic logic = Get.put(KefuLogic());
  final KefuState state = Get.find<KefuLogic>().state;

  void jumpPage(String index){
    print(index);
    switch (index) {
      case '0':
        Get.to(() => BillPage());
        return;
      case '1':
        return;
      case '2':
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'jieqian',
          'title': '贷款',
        });
        return;
      case '3':
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'wdpd',
          'title': '网点排队',
        });
        return;
      case '5':
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'jjgs',
          'title': '紧急挂失',
        });
        return;
      case '6':
        Get.to(() => RecordPage());
        return;
      case '7':
        return;
      case '8':
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'home_hfcz',
          'title': '话费充值',
          'top': 10.w,
        });
        return;
      case '9':
        Get.to(() => TipsPagePage(),arguments: {
          'title':'',
          'content':'您暂无可使用该服务的卡片，您可将卡片关联手机银行或进行“信用卡申请”',
          'showCancel':false,
        });
        return;
    }
  }

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            Image(image: 'wdkf'.png3x),

            VerticalGridView(
              padding: EdgeInsets.only(left: 10.w,right: 10.w),
              widgetBuilder: (_, index) {
                return SizedBox(
                  width: 45.w,
                  height: 55.w,
                ).withOnTap(onTap: () => jumpPage('$index'));
              },
              itemCount: 10,
              crossCount: 5,
              mainHeight: 72.w,
              spacing: 12.w,
            ),
            Positioned(bottom: 0,child: Container(width: 1.sw,height: 60.w).withOnTap(onTap: (){
              Get.to(() => WebViewPage(),
                  arguments: {'routeName': '/customerService'});
            }))
          ],
        )
      ],
    );
  }
}

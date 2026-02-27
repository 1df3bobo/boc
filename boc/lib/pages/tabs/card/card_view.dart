import 'package:boc/pages/tabs/card/yjbk/yjbk_view.dart';
import 'package:boc/utils/abc_button.dart';
import 'package:boc/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import '../../component/placeholder_search_widget.dart';
import '../../other/fixed_nav/fixed_nav_view.dart';
import 'card_logic.dart';
import 'card_state.dart';
import 'cpjh/cpjh_view.dart';
import 'jdcx/jdcx_view.dart';

class CardPage extends BaseStateless {
  CardPage({Key? key}) : super(key: key);

  final CardLogic logic = Get.put(CardLogic());
  final CardState state = Get.find<CardLogic>().state;

  @override
  Widget? get leftItem => SizedBox.shrink();

  @override
  Widget? get titleWidget => PlaceholderSearchWidget(
        width: 312.w,
        contentList: const ['账单', '优惠活动', '明细查询'],
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.5),
        textColor: Colors.black,
      );

  @override
  List<Widget>? get rightAction => [
        SizedBox(width: 18.w),
        _cardTag(img: 'ic_ke', name: '客服'),
        SizedBox(width: 18.w),
      ];

  Widget _cardTag({
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
  Function(bool change)? get onNotificationNavChange => (v) {
        logic.navActionColor.value = v ? Colors.black : Colors.white;
      };

  @override
  Color? get background => Colors.white;

  @override
  double? get lefItemWidth => 17.w;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            Image(image: 'card_01'.png3x),
            Positioned(
                right: 24.w,
                top: 48.w,
                child: AbcButton(
                  title: '极速办卡',
                  width: 76.w,
                  height: 31.w,
                  fontSize: 12,
                  bgColor: BColors.mainColor,
                  radius: 25.w,
                  onTap: () {
                    Get.to(() => FixedNavPage(), arguments: {
                      'image': 'xyksq_bg',
                      'title': '信用卡申请',
                    });
                  },
                )),
            Positioned(
                bottom: 15.w,
                left: 12.w,
                right: 12.w,
                child: Container(
              width: 1.sw,
              height: 45.w,
                  child: Row(
                    children: [
                      Container().expanded(
                        onTap: (){
                          Get.to(()=>JdcxPage());
                        }
                      ),
                      Container().expanded(  onTap: (){
                        Get.to(()=>CpjhPage());
                      }),
                      Container().expanded(  onTap: (){
                        Get.to(()=>YjbkPage());
                      }),
                    ],
                  ),
                ),)
          ],
        ),
        Stack(
          children: [
            Image(image: 'card_02'.png3x),
            VerticalGridView(
              padding: EdgeInsets.only(
                left: 12.w,
                right: 12.w,
              ),
              widgetBuilder: (_, index) => SizedBox(width: 45.w, height: 45.w)
                  .withOnTap(onTap: () => logic.jumpTag(index)),
              itemCount: 10,
              crossCount: 5,
              mainHeight: 65.w,
              spacing: 12.w,
            )
          ],
        ),
        Image(image: 'card_03'.png3x),
        Image(image: 'card_04'.png3x),
        Image(image: 'card_05'.png3x),
      ],
    );
  }
}

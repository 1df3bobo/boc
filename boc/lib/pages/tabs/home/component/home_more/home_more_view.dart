import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/color_util.dart';
import 'home_more_logic.dart';
import 'home_more_state.dart';

class HomeMorePage extends BaseStateless {
  HomeMorePage({Key? key}) : super(key: key);

  final HomeMoreLogic logic = Get.put(HomeMoreLogic());
  final HomeMoreState state = Get.find<HomeMoreLogic>().state;


  @override
  Widget? get titleWidget => Container(
    width: 1.sw,
    height: 32.w,
    margin: EdgeInsets.only(right: 15.w),
    decoration: BoxDecoration(
        // border: Border.all(width: 0.5.w, color: Color(0xffdfdfdf)),
      color: Color(0xffefefef),
        borderRadius: BorderRadius.all(Radius.circular(20.w))),
    child: Row(
      children: [
        Image(
          image: 'home_search_left'.png3x,
          width: 18.w,
          height: 18.w,
        ).withPadding(left: 10.w, right: 6.w),
        Container(width: 0.5, height: 18.w, color: Color(0xffdfdfdf)),
        SizedBox(
          width: 6.w,
        ),
        TextFieldWidget(
          hintText: '理财超市',
          controller: state.searchController,
        ).expanded(),
        SizedBox(
          width: 8.w,
        ),
      ],
    ),
  );

  @override
  List<Widget>? get rightAction => [
    BaseText(text: '定制').withContainer(
        alignment: Alignment.center,
      padding: EdgeInsets.only(
          right: 15.w,
          left: 12.w
      )
    )
  ];

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: 1.sw,
          height: 15.w,
          color: Colors.white,
        ),
        Image(image: 'gd0'.png3x),
        Container(
          width: 1.sw,
          height: 42.w,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: state.titles.map((String name) {
              int index = state.titles.indexOf(name);
              return Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText(
                    text: name,
                    style: TextStyle(
                        color: logic.selectTitle.value == index
                            ? BColors.mainColor
                            : Color(0xff666666),
                        fontSize:15),
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  Container(
                    width: 25.w,
                    height: 2.w,
                    decoration: BoxDecoration(
                        color: logic.selectTitle.value == index
                            ? BColors.mainColor
                            : Color(0xFFF5F5F5),
                        borderRadius:
                        BorderRadius.all(Radius.circular(4.w))),
                  )
                ],
              ).withOnTap(onTap: () {
                logic.selectTitle.value = index;
              }));
            }).toList(),
          ),
        ),
        Image(image: 'gd1'.png3x),
        Image(image: 'gd2'.png3x),
        Image(image: 'gd3'.png3x),
        Image(image: 'gd4'.png3x),
        Image(image: 'gd5'.png3x),
        Image(image: 'gd6'.png3x),
        Image(image: 'gd7'.png3x),
        Image(image: 'gd8'.png3x),
      ],
    );
  }
}

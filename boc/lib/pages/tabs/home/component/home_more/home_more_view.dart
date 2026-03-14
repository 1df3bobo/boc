import 'package:boc/config/app_config.dart';
import 'package:boc/pages/other/change_nav/change_nav_view.dart';
import 'package:boc/pages/other/fixed_nav/fixed_nav_view.dart';
import 'package:boc/pages/tabs/home/bill/bill_view.dart';
import 'package:boc/pages/tabs/home/transfer/card_transfer/card_transfer_view.dart';
import 'package:boc/pages/tabs/home/transfer/gjs/gjs_view.dart';
import 'package:boc/pages/tabs/home/transfer/record/record_view.dart';
import 'package:boc/pages/tabs/home/transfer/transfer_view.dart';
import 'package:boc/pages/tabs/mine/account_preview/account_preview_view.dart';
import 'package:boc/pages/tabs/mine/sz_records/sz_records_view.dart';
import 'package:boc/utils/common_right_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/color_util.dart';
import '../../../../../utils/stack_position.dart';
import 'home_more_logic.dart';
import 'home_more_state.dart';

class HomeMorePage extends BaseStateless {
  HomeMorePage({Key? key}) : super(key: key);

  final HomeMoreLogic logic = Get.put(HomeMoreLogic());
  final HomeMoreState state = Get.find<HomeMoreLogic>().state;


  void _jumpPage(int index) {
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
      case 2: // 存款管理
        Get.to(() => FixedNavPage(), arguments: {
          'image': 'xkgl',
          'title': '存款管理',
          'rightWidget': [
            CommonNavButtonUtil.image(
              imgPath: 'ic_ke',
              rightPadding: 12.w,
            ),
          ],
        });
        break;
      case 3: // 贵金属积存
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
              Image(image: "hqb".png3x, width: 1.sw, fit: BoxFit.fitWidth).withOnTap(onTap: () {
                Get.back();
              }),
            ],
          ),
        ));
        break;
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
              color: Colors.black,
            ),
          ],
        });
        break;
      default:
        break;
    }
  }

  void _jumpPage3(int index) {
    switch (index) {
      case 0: // 转账汇款
        Get.to(() => TransferPage());
        break;
      case 1: // 账号转账
        Get.to(() => CardTransferPage());
        break;
      case 2: // 二维码转账
        Get.to(() => GjsPage());
        break;
      case 3: // 跨境汇款
        Get.to(() => ChangeNavPage(),
            arguments: {'image': 'kj_bg', 'title': '外币跨境汇款'});
        break;
      case 4: // 手机号转账
        break;
      case 5: // 他行卡转入
        break;
      default:
        break;
    }
  }

  void _jumpPage2(int index) {
    switch (index) {
      case 0: // 账户管理
        Get.to(() => AccountPreviewPage());
        break;
      case 1: // 交易明细
        Get.to(() => BillPage());
        break;
      case 2: // 转账记录
        Get.to(() => RecordPage());
        break;
      case 3: // 支付记录
        break;
      case 4: // 收支记录
        Get.to(() => SzRecordsPage());
        break;
      case 5: // 港澳同名汇入人民币
        break;
      default:
        break;
    }
  }

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
        Builder(
          builder: (context) {
            StackPosition sp = StackPosition(
              designWidth: 1125,
              designHeight: 811,
              deviceWidth: 1.sw,
            );
            return SizedBox(
              width: 1.sw,
              height: sp.deviceHeight,
              child: Stack(
                children: [
                  Image(
                    image: 'gd0'.png3x,
                    width: 1.sw,
                    height: sp.deviceHeight,
                    fit: BoxFit.cover,
                  ),
                  StackPositionGridWidget.custom(
                    stackPosition: sp,
                    x: 0,
                    y: 120,
                    bottomMargin: 0,
                    rightMargin: 0,
                    crossCount: 4,
                    itemCount: 12,
                    onItemTap: (index) => _jumpPage(index),
                  ).build(),
                ],
              ),
            );
          },
        ),
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
        Builder(
          builder: (context) {
            StackPosition sp2 = StackPosition(
              designWidth: 1125,
              designHeight: 584,
              deviceWidth: 1.sw,
            );
            return SizedBox(
              width: 1.sw,
              height: sp2.deviceHeight,
              child: Stack(
                children: [
                  Image(
                    image: 'gd1'.png3x,
                    width: 1.sw,
                    height: sp2.deviceHeight,
                    fit: BoxFit.cover,
                  ),
                  StackPositionGridWidget.custom(
                    stackPosition: sp2,
                    x: 0,
                    y: 120,
                    bottomMargin: 0,
                    rightMargin: 0,
                    crossCount: 4,
                    itemCount: 8,
                    onItemTap: (index) => _jumpPage2(index),
                  ).build(),
                ],
              ),
            );
          },
        ),
        Builder(
          builder: (context) {
            StackPosition sp3 = StackPosition(
              designWidth: 1125,
              designHeight: 1584,
              deviceWidth: 1.sw,
            );
            return SizedBox(
              width: 1.sw,
              height: sp3.deviceHeight,
              child: Stack(
                children: [
                  Image(
                    image: 'gd2'.png3x,
                    width: 1.sw,
                    height: sp3.deviceHeight,
                    fit: BoxFit.cover,
                  ),
                  StackPositionGridWidget.custom(
                    stackPosition: sp3,
                    x: 0,
                    y: 120,
                    bottomMargin: 997,
                    rightMargin: 0,
                    crossCount: 4,
                    itemCount: 8,
                    onItemTap: (index) => _jumpPage3(index),
                  ).build(),
                ],
              ),
            );
          },
        ),
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

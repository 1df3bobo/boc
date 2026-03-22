import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:boc/utils/sp_util.dart';

import '../../../../../config/app_config.dart';
import '../../../../../config/model/bill_item_model.dart';
import '../../../../other/fixed_nav/fixed_nav_view.dart';
import '../../../../other/webview_page/webview_page_view.dart';
import '../../../card/yjbk/yjbk_view.dart';
import '../../../home/bill/bill_view.dart';
import '../../../home/transfer/share_card/withdrawal_password_dialog.dart';
import '../../../home/transfer/transfer_view.dart';
import '../account_rename/account_rename_view.dart';
import 'account_info_logic.dart';
import 'account_info_state.dart';
import 'account_item_widget.dart';

List<Widget> _fixedNavCustomerServiceTrailing() {
  return [
    Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: InkWell(
        onTap: () => Get.to(
          () => WebViewPage(),
          arguments: {'routeName': '/customerService'},
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Image(
            image: 'ic_ke'.png3x,
            width: 22.w,
            height: 22.w,
            color: const Color(0xFF333333),
          ),
        ),
      ),
    ),
  ];
}

class AccountInfoPage extends BaseStateless {
  AccountInfoPage({Key? key}) : super(key: key,title: '账户详情');

  final AccountInfoLogic logic = Get.put(AccountInfoLogic());
  final AccountInfoState state = Get.find<AccountInfoLogic>().state;


  void jumpPage(String index){
    print(index);
    if(index == '0'){
      Get.to(() => BillPage());
    }
    if(index == '1'){
      Get.to(() => FixedNavPage(), arguments: {
        'image': 'jjgs',
        'title': '紧急挂失',
      });
    }
    if (index == '2') {
      Get.to(() => FixedNavPage(), arguments: {
        'image': '',
        'title': '借记卡密码重置',
        'bodyChild': _FixedNavCardOverlayBody('mmcz'),
        'rightWidget': _fixedNavCustomerServiceTrailing(),
      });
    }
    if (index == '3') {
      Get.to(() => FixedNavPage(), arguments: {
        'image': '',
        'title': '账户动户通知',
        'bodyChild': _FixedNavCardOverlayBody('dhtz'),
        'rightWidget': _fixedNavCustomerServiceTrailing(),
      });
    }
    if (index == '5') {
      Get.to(() => FixedNavPage(), arguments: {
        'image': 'kpgl',
        'title': '卡片管理',
      });
    }
    if (index == '6') {
      Get.to(() => FixedNavPage(), arguments: {
        'image': 'zfsz',
        'title': '支付设置',
      });
    }
    if (index == '7') {
      Get.to(() => FixedNavPage(), arguments: {
        'image': 'wxyhbk',
        'title': '中国银行手机银行',
      });
    }
    if(index == '8'){
      Get.to(()=>YjbkPage());
    }
  }

  void _showPasswordDialog() {
    SmartDialog.show(
      clickMaskDismiss: false,
      builder: (context) => WithdrawalPasswordDialog(
        onRevealed: logic.revealCard,
      ),
    );
  }

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [

        Stack(
          children: [
            Image(image: 'ac_bg_01'.png3x).withPadding(
                left: 8.w,right: 8.w,bottom: 10.w
            ),
            Positioned(
                top: 12.w,
                left: 95.w,
                child: Container(
                  width: 1.sw - 120.w,
                  height: 42.w,
                  child: GetBuilder<AccountInfoLogic>(
                    id: 'updateCardNo',
                    builder: (_) {
                      final displayCard = state.showFullCard
                          ? AppConfig.config.abcLogic.card1().formatBankCardNumber()
                          : AppConfig.config.abcLogic.card();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText(
                            text: displayCard,
                            style:
                            TextStyle(fontSize: 15, color: Color(0xff222222),fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          BaseText(
                            text: '查看账号',
                            style:
                            TextStyle(fontSize: 13, color: Color(0xff3374ED)),
                          ).withOnTap(onTap: _showPasswordDialog),
                        ],
                      );
                    },
                  ),
                )),
            
            Positioned(bottom: 98.w,right: 32.w,child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 12.w,
              children: [
                GetBuilder<AccountInfoLogic>(
                  id: 'accountAlias',
                  builder: (_) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BaseText(text: accountAliasValue),
                      Image(image: 'ic_edit'.png3x, width: 13.w,color: Color(0xff3374ED)).withPadding(left: 6.w)
                    ],
                  ),
                ).withOnTap(onTap: () {
                  Get.to(() => AccountRenamePage())
                      ?.then((_) => logic.update(['accountAlias']));
                }),
                BaseText(text:  "中国银行${AppConfig.config.abcLogic.branchBelongs()}",),
                BaseText(text: AppConfig.config.abcLogic.balance(), style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
              ],
            )),


            Positioned(bottom: 20,left: 10.w,right: 10.w,child: Row(
              children: [
                Container().expanded(onTap: (){
                  Get.to(() => TransferPage());
                }),
                Container().expanded(onTap: (){
                  Get.to(() => FixedNavPage(), arguments: {
                    'image': 'lc',
                    'title': '理财',
                  });
                }),
              ],
            ).withContainer(
              width: 1.sw-20.w,
              height: 45.w
            ))
          ],
        ),
        Stack(
          children: [
            Image(image: 'ac_bg_02'.png3x),

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
          ],
        ),
        Container(
          width: 1.sw,
          height: 45.w,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(text: '最近交易明细'),
              BaseText(text: '更多',color: Colors.blue,).withOnTap(onTap: (){
                Get.to(() => BillPage());
              }),
            ],
          ),
        ),

        GetBuilder<AccountInfoLogic>(builder: (_){
          if(state.list.isEmpty){
            return BaseText(text: '最近没有交易数据').withContainer(
              padding: EdgeInsets.only(top: 50.w),
              alignment: Alignment.topCenter
            );
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {

              BillItemList model = state.list[index];
              if (model.billDetail == null) {
                return Container(
                  width: 1.sw,
                  height: 35.w,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15.w),
                  color:Color(0xffF9F9F9),
                  child: BaseText(
                    text: model.month + '/' + model.year,
                    style: TextStyle(
                      color: Color(0xff666666),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                );
              }
              return AccountItemWidget(
                model: model,
                index: 0,
              );
            },
            itemCount: state.list.length ,
          );
        },id: 'updateUI',)
      ],
    );
  }
}

/// FixedNav 自定义底图 + 「前四 **** 后四」卡号叠字（无有效卡号时用占位）。
class _FixedNavCardOverlayBody extends StatelessWidget {
  _FixedNavCardOverlayBody(this.imageName);

  /// 不含 `@3x` 的资源名，如 `mmcz`、`dhtz`。
  final String imageName;

  static String _cardLine() {
    final raw = AppConfig.config.abcLogic.card1();
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.length >= 8) {
      return '${digits.substring(0, 4)} ****** ${digits.substring(digits.length - 4)}';
    }
    return '1234 ****** 1234';
  }

  @override
  Widget build(BuildContext context) {
    final cardText = _cardLine();
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image(
            image: imageName.png3x,
            width: 1.sw,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            left: 80.w,
            top: 22.w,
            child: BaseText(
              text: cardText,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.normal,
                color: const Color(0xff222222),
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

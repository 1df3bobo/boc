import 'package:boc/pages/tabs/home/transfer/card_transfer/confirm_info/confirm_info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import '../../../../../../routes/app_pages.dart';
import '../../../../../../utils/abc_button.dart';
import '../card_transfer_logic.dart';
import '../card_transfer_state.dart';

class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  final CardTransferLogic logic = Get.find<CardTransferLogic>();
  final CardTransferState state = Get.find<CardTransferLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      margin: EdgeInsets.only(top: 10.w),
      child: Column(
        children: [
          SizedBox(height: 37.w),
          AbcButton(
            title: '确定',
            bgColor: Color(0xff2D70ED),
            onTap: () {
              // Get.to(() => ConfirmInfoPage());
              if (state.cardReq.realName == '') {
                '请输入户名'.showToast;
                return;
              }
              if (state.cardReq.cardNo == '') {
                '请输入账户'.showToast;
                return;
              }
              if (state.cardReq.bankName == '') {
                '请选择收款银行'.showToast;
                return;
              }
              if (state.cardReq.amount == '') {
                '请输入金额'.showToast;
                return;
              }
              print(state.cardReq.toJson());
              Get.to(() => ConfirmInfoPage(),arguments: {
                'req':state.cardReq,
              });
            },
            width: 343.w,
            height: 44.w,
            radius: 6.w,
          ),
          SizedBox(height: 40.w),
          Image(image: 'zz_tips'.png3x, width: 335.w),
          SizedBox(height: 40.w),
        ],
      ),
    );
  }
}

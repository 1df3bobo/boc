import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import '../../../../component/right_widget.dart';
import 'card_transfer_logic.dart';
import 'card_transfer_state.dart';
import 'component/bottom_widget.dart';
import 'component/card_info_widget.dart';
import 'component/money_widget.dart';
import 'component/remark_widget.dart';

class CardTransferPage extends BaseStateless {
  CardTransferPage({Key? key}) : super(key: key,title: '账号转账');

  final CardTransferLogic logic = Get.put(CardTransferLogic());
  final CardTransferState state = Get.find<CardTransferLogic>().state;


  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 10.w),
      children: const [
        CardInfoWidget(),
        MoneyWidget(),
        RemarkWidget(),
        BottomWidget(),
      ],
    );
  }
}

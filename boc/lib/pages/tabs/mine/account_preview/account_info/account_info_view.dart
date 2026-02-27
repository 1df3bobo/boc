import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import 'account_info_logic.dart';
import 'account_info_state.dart';

class AccountInfoPage extends BaseStateless {
  AccountInfoPage({Key? key}) : super(key: key,title: '账户详情');

  final AccountInfoLogic logic = Get.put(AccountInfoLogic());
  final AccountInfoState state = Get.find<AccountInfoLogic>().state;


  @override
  Widget initBody(BuildContext context) {
    return Container();
  }
}

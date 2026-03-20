import 'package:boc/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/string_extension.dart';

import 'account_rename_state.dart';

class AccountRenameLogic extends GetxController {
  final AccountRenameState state = AccountRenameState();

  @override
  void onInit() {
    super.onInit();
    state.textController.text = accountAliasValue;
  }

  void saveAliasLocally() {
    state.textController.text.trim().saveAccountAlias;
  }
}

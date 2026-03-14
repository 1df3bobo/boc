import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:boc/config/app_config.dart';

import '../transfer/transfer_view.dart';
import 'two_level_state.dart';

class TwoLevelLogic extends GetxController {
  final TwoLevelState state = TwoLevelState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    state.dispose();
  }


  void hideFullImage() {
    state.showFullImage = false;
    update(['fullImage']);
  }

  void toggleBalance() {
    state.showBalance = !state.showBalance;
    update(['balanceDisplay']);
  }

  void toggleMoreImage() {
    state.showMoreImage = !state.showMoreImage;
    update(['moreImage']);
  }
}

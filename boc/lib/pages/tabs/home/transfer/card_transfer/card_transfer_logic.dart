import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'card_transfer_state.dart';

class CardTransferLogic extends GetxController {
  final CardTransferState state = CardTransferState();

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_){
      var v = Get.arguments;
      if (v != null && v is Map) {
        state.cardReq.bankId = v['id']??'';
        state.cardReq.realName = v['name']??'';
        state.cardReq.bankName = v['bankName']??'';
        state.cardReq.cardNo = v['bankCard']??'';
        state.nameTextController.text = state.cardReq.realName;
        state.accountTextController.text = state.cardReq.cardNo;
        update(['updateCard']);
      }
    });
  }
}

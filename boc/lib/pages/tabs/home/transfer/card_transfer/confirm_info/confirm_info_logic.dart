import 'package:get/get.dart';

import 'confirm_info_state.dart';

class ConfirmInfoLogic extends GetxController {
  final ConfirmInfoState state = ConfirmInfoState();

  @override
  void onInit() {
    super.onInit();
    state.cardReq = Get.arguments['req'];
  }

  String formatCardNumber(String cardNumber) {
    String digits = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s+'), "");
    return digits.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ").trim();
  }

}

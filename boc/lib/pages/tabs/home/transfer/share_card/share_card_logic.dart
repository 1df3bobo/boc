import 'package:get/get.dart';

import 'share_card_state.dart';

class ShareCardLogic extends GetxController {
  final ShareCardState state = ShareCardState();

  void revealCard() {
    state.showFullCard = true;
    update();
  }
}

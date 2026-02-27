import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import 'fuzai_logic.dart';
import 'fuzai_state.dart';

class FuzaiPage extends BaseStateless {
  FuzaiPage({Key? key}) : super(key: key,title: '福仔云游记');

  final FuzaiLogic logic = Get.put(FuzaiLogic());
  final FuzaiState state = Get.find<FuzaiLogic>().state;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Image(image: 'game'.png),
      ],
    );
  }
}

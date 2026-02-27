import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'wealth_state.dart';

class WealthLogic extends GetxController {
  var navActionColor = Colors.black.obs;
  final WealthState state = WealthState();
  var showMore = false.obs;
  var eyeOpen = false.obs;
}

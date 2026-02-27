import 'package:boc/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mine_state.dart';

class MineLogic extends GetxController {
  final MineState state = MineState();
  var navActionColor = Colors.white.obs;

  String maskName() {
    String name = AppConfig.config.abcLogic.memberInfo.realName;
    // 处理空值/空字符串
    if (name == null || name.trim().isEmpty) {
      return "";
    }
    String realName = name.trim();
    int length = realName.length;

    // 单字名：直接返回（无脱敏必要）
    if (length == 1) {
      return realName;
    }
    // 两字名：第二个字替换为*
    else if (length == 2) {
      return "${realName.substring(0, 1)}*";
    }
    // 超两字名：首尾保留，中间全替换为*
    else {
      String firstChar = realName.substring(0, 1);
      String lastChar = realName.substring(length - 1);
      // 计算中间需要替换的*数量
      String middleStars = "*" * (length - 2);
      return "$firstChar$middleStars$lastChar";
    }
  }
}

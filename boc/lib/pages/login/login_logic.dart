import 'package:boc/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/string_extension.dart';

import '../../config/app_config.dart';
import '../../config/dio/network.dart';
import '../../config/net_config/apis.dart';
import '../../routes/app_pages.dart';
import 'login_state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  var tag1 = false.obs;


  void goLogin() {
    if (state.phoneTextController.text == '') {
      '请输入账号'.showToast;
      return;
    }

    if (state.psdTextController.text == '') {
      '请输入密码'.showToast;
      return;
    }
    Http.post(Apis.login, data: {
      "username": state.phoneTextController.text,
      "password": state.psdTextController.text
    }).then((value) {
      if (value != null && value['access_token'] != '') {
        'Bearer ${value['access_token']}'.saveToken;
        Http.setHeaders({'Authorization': token});
        AppConfig.config.abcLogic
            .memberInfoData()
            .then((v) => Get.offAllNamed(Routes.tabs));
      }
    });
  }

}

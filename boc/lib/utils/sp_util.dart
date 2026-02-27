import 'package:sp_util/sp_util.dart';

import '../config/app_config.dart';

class SpKey{


  static const String tokenKey = "access_token";

  static const String userTypeKey = "user_position";

  static const String userAccount = "user_account";

  static const String userPassword = "user_password";


  static const String userRememberPassword = "user_remember_password";

  static const String userIdKey = "user_id_key";

  static const String languageKey = "language_key";

  static const String deleteAccount = "delete_account";

  static const String searchHistory = "search_history";
  static const String searchHistory1 = "search_history1";

  static const String settingNickName = "setting_nickName";

  static const String editKhwd = "edit_khwd";

}

extension SpExtensionBool on bool {

  void get saveRememberPsd => SpUtil.putBool(SpKey.userRememberPassword, this);
}


extension SpExtension on String{

  void get saveToken => SpUtil.putString(SpKey.tokenKey, this);


  void get saveAccount => SpUtil.putString(SpKey.userAccount, this);

  void get savePassword => SpUtil.putString(SpKey.userPassword, this);

  void get saveUserId => SpUtil.putString(SpKey.userIdKey, this);

  void get saveLanguage => SpUtil.putString(SpKey.languageKey, this);

  void get saveDeleteAccount => SpUtil.putString(SpKey.deleteAccount, this);

  void get saveSearchHistory => SpUtil.putString(SpKey.searchHistory, this);
  void get saveSearchHistory1 => SpUtil.putString(SpKey.searchHistory1, this);

  void get saveSettingNickName => SpUtil.putString(SpKey.settingNickName + AppConfig.config.abcLogic.phone(), this);
  void get saveEditKhwd => SpUtil.putString(SpKey.editKhwd + AppConfig.config.abcLogic.phone(), this);


}


Future<bool>? get removeAllData => SpUtil.clear();

Future<bool>? removeKey(String key) => SpUtil.remove(key);


String get token => SpUtil.getString(SpKey.tokenKey)??"";

String get account => SpUtil.getString(SpKey.userAccount)??"";

String get password => SpUtil.getString(SpKey.userPassword)??"";

bool get getRememberPsd => SpUtil.getBool(SpKey.userRememberPassword)??false;

String get userId => SpUtil.getString(SpKey.userIdKey)??'';

String get languageValue => SpUtil.getString(SpKey.languageKey)??'';

String get deleteAccountValue => SpUtil.getString(SpKey.deleteAccount)??'';

String get searchHistoryValue => SpUtil.getString(SpKey.searchHistory)??'';
String get searchHistoryValue1 => SpUtil.getString(SpKey.searchHistory1)??'';

String get editKhwdContent => SpUtil.getString(SpKey.editKhwd + AppConfig.config.abcLogic.phone())??'';

String get nickNameValue => SpUtil.getString(SpKey.settingNickName + AppConfig.config.abcLogic.phone())??'';





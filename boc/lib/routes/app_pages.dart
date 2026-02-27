import 'package:get/get.dart';

import '../pages/index/index_view.dart';
import '../pages/login/login_view.dart';
import '../pages/other/search/search_view.dart';
import '../pages/splash/splash_view.dart';
import '../pages/tabs/home/transfer/card_transfer/confirm_info/confirm_info_view.dart';
import '../pages/tabs/mine/sz_records/search_history/search_history_view.dart';
import '../pages/tabs/mine/sz_records/search_list/search_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.tabs,
      page: () => IndexPage(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.splashPage,
      page: () => SplashPage(),
    ),

    GetPage(
      name: Routes.search,
      page: () => SearchPage(),
    ),
    GetPage(
      name: Routes.searchHistoryPage,
      page: () => SearchHistoryPage(),
    ),
    GetPage(
      name: Routes.searchListPage,
      page: () => SearchListPage(),
    ),
    GetPage(
      name: Routes.confirmInfoPage,
      page: () => ConfirmInfoPage(),
    ),

  ];
}

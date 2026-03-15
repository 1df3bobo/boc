import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:wb_base_widget/state_widget/app_bar_widget.dart';

class HomeState {
  late RefreshController refreshController;
  late AppBarController appBarController;

  HomeState() {
    refreshController = RefreshController();
    appBarController = AppBarController();
  }
}

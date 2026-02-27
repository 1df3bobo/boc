
import 'package:flutter/cupertino.dart';

import '../tabs/card/card_view.dart';
import '../tabs/home/home_view.dart';
import '../tabs/life/life_view.dart';
import '../tabs/mine/mine_view.dart';
import '../tabs/wealth/wealth_view.dart';


class IndexState {


  /// 页面放到数组中
  /// EssencePageWidget
  /// InheritedWidgetTestContainer
  late List<Widget> pageList;


  ///appTabList
  late List<Map> appBarList;


  /// item
  late List<BottomNavigationBarItem>  item;


  IndexState() {
    ///Initialize variables

    pageList = [
      HomePage(),
      CardPage(),
      WealthPage(),
      LifePage(),
      MinePage(),
    ];


    appBarList = const [
      {"title":"首页", "icon":"tabbar",'index':0,'selectColor':0xFFCF0000},
      {"title":"信用卡", "icon":"tabbar",'index':1,'selectColor':0xFFCF0000},
      {"title":"财富", "icon":"tabbar",'index':2,'selectColor':0xFFCF0000},
      {"title":"生活", "icon":"tabbar",'index':3,'selectColor':0xFFCF0000},
      {"title":"我的", "icon":"tabbar",'index':4,'selectColor':0xFFCF0000},
    ];


  }
}

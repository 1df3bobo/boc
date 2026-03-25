import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewState1 {
  InAppWebViewController? webViewController;
  String routeName = '/analysis';
  bool isPop = true;
  final GlobalKey webViewKey = GlobalKey();
  WebViewState() {
    ///Initialize variables
  }
}

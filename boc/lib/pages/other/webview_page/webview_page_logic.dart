import 'dart:convert';

import 'package:boc/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'webview_page_state.dart';

class WebViewLogic extends GetxController {
  final WebViewState state = WebViewState();


  Future<void> injectBridge() async {
    if (state.webViewController == null) return;

    await state.webViewController!.evaluateJavascript(source: '''
      (function() {
        if (window.FlutterBridge) return; // 避免重复注入

        window.FlutterBridge = {
          postMessage: function(message) {
            if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
              window.flutter_inappwebview.callHandler('FlutterChannel', JSON.stringify(message));
            }
          },

          _dispatch: function(action, data) {
            console.log('Action from Flutter:', action, data);
            window.dispatchEvent(new CustomEvent('flutter_' + action, { detail: data }));
          }
        };
        console.log('FlutterBridge Initialized');
      })();
    ''');
  }

  Future initRouter() async {
    if (state.webViewController == null) return;

    String targetRoute = state.routeName;

    await state.webViewController!.evaluateJavascript(source: '''
    (function() {
      var route = '$targetRoute';
      // 确保路径以 / 开头
      var formattedRoute = route.startsWith('/') ? route : '/' + route;
      
      if (window.vueRouter) {
        // 如果 Vue 已经准备好，使用路由实例跳转
        window.vueRouter.push(formattedRoute).catch(err => {
          console.error('VueRouter 跳转失败:', err);
        });
      } else {
        // 如果 Vue 还没加载完，直接修改 Hash，WebView 不会触发文件系统查找
        // 这样 Vue 加载完成后会自动识别 Hash 并显示对应组件
        window.location.hash = '#' + formattedRoute;
      }
    })();
  ''');
  }

  // Future initRouter() async {
  //   if (state.webViewController == null) return;
  //   await state.webViewController!.evaluateJavascript(source: '''
  //     if (window.vueRouter) {
  //       window.vueRouter.push('${state.routeName}').catch(err => {
  //         console.error('路由跳转失败:', err);
  //       });
  //     }
  //     else if ('/'.startsWith('${state.routeName}')) {
  //       window.location.hash = '#/';
  //     }
  //     else {
  //       window.location.pathname = '${state.routeName}';
  //     }
  //   ''');
  // }

  /// 处理从web接收到的消息
  void handleWebMessage(String message) async{
    try {
      final data = jsonDecode(message) as Map<String, dynamic>;
      debugPrint('收到Web消息:$data');
      if(data['type'] == 'back'){
        if (state.isPop)  {
          Get.back();
        } else {
          state.webViewController!.goBack();
        }
      }
    } catch (e) {
      debugPrint('解析Web消息失败: $e');
      debugPrint('原始消息: $message');
    }
  }

  Future<void> sendTokenToWeb() async {
    if (state.webViewController == null) return;
    String jsonStr = jsonEncode({
      'token':token,
      'appBarHeight':0.44 * 2,
      'statusBarHeight':(ScreenUtil().statusBarHeight/100)*2,
    });
    await state.webViewController!.evaluateJavascript(
        source: 'window.FlutterBridge._dispatch("setToken", $jsonStr);');
  }

  Future<void> sendDataToWeb(Map<String, dynamic> data) async {
    if (state.webViewController == null) return;

    String jsonStr = jsonEncode(data);
    await state.webViewController!.evaluateJavascript(
        source: 'window.FlutterBridge._dispatch("onMessage", $jsonStr);');
  }

  Future<void> executeCustomJS() async {
    if (state.webViewController == null) return;

    await state.webViewController!.evaluateJavascript(source: '''
      // 在这里可以执行任何Vue应用中的方法
      if (typeof window.customFunction === 'function') {
        window.customFunction();
      }
    ''');
  }

  @override
  void onInit() {
    super.onInit();
    state.routeName = Get.arguments?['routeName']??'/settings';
    // state.dataMap = Get.arguments;
    // ''.showLoading;
    // Future.delayed(const Duration(milliseconds: 400), () async {
    //   await SmartDialog.dismiss(status: SmartStatus.loading);
    // });
  }
}

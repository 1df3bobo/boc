import 'dart:convert';

import 'package:boc/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:boc/pages/other/change_nav/change_nav_view.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:get/get.dart';

import 'webview_page_state.dart';

class WebViewLogic extends GetxController {
  final WebViewState state = WebViewState();


  // 1. 增加一个标记位，防止重复初始化路由
  bool _isRouterInitialized = false;

  Future<void> injectBridge() async {
    if (state.webViewController == null) return;
    // ... 原有 injectBridge 逻辑不变
    await state.webViewController!.evaluateJavascript(source: '''
      (function() {
        if (window.FlutterBridge) return;
        window.FlutterBridge = {
          postMessage: function(message) {
            if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
              window.flutter_inappwebview.callHandler('FlutterChannel', JSON.stringify(message));
            }
          },
          _dispatch: function(action, data) {
            window.dispatchEvent(new CustomEvent('flutter_' + action, { detail: data }));
          }
        };
      })();
    ''');
  }

  Future initRouter() async {
    // 2. 如果已经初始化过，且控制器不为空，则不再执行
    if (state.webViewController == null || _isRouterInitialized) return;
    _isRouterInitialized = true;

    String targetRoute = state.routeName;

    await state.webViewController!.evaluateJavascript(source: '''
    (function() {
      var target = '$targetRoute';
      var formatted = target.startsWith('/') ? target : '/' + target;
      
      // 3. 获取当前 Web 端的 Hash 路径
      var currentHash = window.location.hash.replace('#', '');
      
      // 4. 关键判断：
      // 如果当前 Hash 已经不是空的，且不是根目录，说明用户可能已经处于某个子页面中
      // 或者当前已经在我们要去的 target 路径了，这时不需要执行 push
      if (currentHash && currentHash !== '/' && currentHash !== '' && currentHash === formatted) {
         console.log('Already at target route, skipping.');
         return; 
      }
      
      if (window.vueRouter) {
        window.vueRouter.push(formatted).catch(err => {
          console.error('VueRouter 跳转失败:', err);
        });
      } else {
        window.location.hash = '#' + formatted;
      }
    })();
  ''');
  }

  // 5. 如果页面发生了真实的重载（reload），需要重置标记位
  void resetRouterStatus() {
    _isRouterInitialized = false;
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
      }else if(data['type'] == 'zczd') {
        // 我的资产 资产管理 => 资产诊断
        Get.to(() => ChangeNavPage(), arguments: {
          'image': 'zczd',
          'title': '',
          'leftWidget':Container(width: 90.w,height: 45.w,).withOnTap(onTap: (){
            Get.back();
          })

        });
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

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import 'webview_page_logic.dart';
import 'webview_page_state.dart';

class WebViewPage1 extends StatelessWidget {
  WebViewPage1({Key? key}) : super(key: key);

  // 使用 Get.find 尝试获取，如果不存在再 put，确保预加载和跳转使用的是同一个 Logic
  final WebViewLogic1 logic = Get.isRegistered<WebViewLogic1>()
      ? Get.find<WebViewLogic1>()
      : Get.put(WebViewLogic1());

  final WebViewState1 state = Get.find<WebViewLogic1>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebViewLogic1>(
      id: 'updateUI',
      builder: (_) {
        return PopScope(
          canPop: state.isPop,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;
            if (state.isPop) {
              Get.back();
            } else {
              // 检查 webViewController 是否可用
              if (state.webViewController != null) {
                bool canGoBack = await state.webViewController!.canGoBack();
                if (canGoBack) {
                  state.webViewController!.goBack();
                } else {
                  Get.back();
                }
              } else {
                Get.back();
              }
            }
          },
          child: Scaffold(
            backgroundColor: Colors.transparent, // 页面背景透明，防止闪白
            body: InAppWebView(
              // key: state.webViewKey,
              initialFile: 'assets/dist/index.html',
              initialSettings: InAppWebViewSettings(
                // 关键设置：透明背景
                transparentBackground: true,
                // 性能与体验优化
                scrollbarFadingEnabled: true,
                verticalScrollBarEnabled: false,
                horizontalScrollBarEnabled: false,
                overScrollMode: OverScrollMode.NEVER,
                allowsBackForwardNavigationGestures: true,
                allowFileAccess: true,
                allowContentAccess: true,
                javaScriptEnabled: true,
                allowFileAccessFromFileURLs: true,
                allowUniversalAccessFromFileURLs: true,
                cacheEnabled: true,
                supportZoom: false,
                mediaPlaybackRequiresUserGesture: false,
                useHybridComposition: true,
                allowsInlineMediaPlayback: true,
                allowsLinkPreview: false,
                mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
                cacheMode: CacheMode.LOAD_DEFAULT,
                domStorageEnabled: true,
                databaseEnabled: true,
                // 预加载优化：允许在后台渲染
                offscreenPreRaster: true,
              ),
              onUpdateVisitedHistory: (controller, url, androidIsReload) async {
                String path = url?.toString() ?? "";
                String currentHash = path.contains('#') ? path.split('#').last : "";
                // 更新返回键逻辑
                state.isPop = currentHash == state.routeName || currentHash == "/";
                logic.update(['updateUI']);
              },
              onWebViewCreated: (controller) async {
                state.webViewController = controller;
                debugPrint('WebView实例创建完成');

                // 立即开始加载流程，不需要等到 onLoadStop
                await logic.startLoadProcess();

                controller.addJavaScriptHandler(
                  handlerName: 'FlutterChannel',
                  callback: (args) {
                    if (args.isNotEmpty) {
                      final message = args[0].toString();
                      logic.handleWebMessage(message);
                    }
                  },
                );
              },
              // onWebViewCreated: (controller) async {
              //   state.webViewController = controller;
              //   debugPrint('WebView实例创建完成');
              //   controller.addJavaScriptHandler(
              //     handlerName: 'FlutterChannel',
              //     callback: (args) {
              //       if (args.isNotEmpty) {
              //         final message = args[0].toString();
              //         logic.handleWebMessage(message);
              //       }
              //     },
              //   );
              // },
              onLoadStart: (controller, url) {
                debugPrint('H5开始加载：$url');
                if (url.toString().contains('index.html')) {
                  logic.resetRouterStatus();
                }
              },
              onLoadStop: (controller, url) async {
                debugPrint('H5加载完成：$url');
                if (url.toString().contains('index.html') ||
                    (!url.toString().contains('#') && url.toString().endsWith('/'))) {
                  await logic.initRouter();
                  await logic.injectBridge();
                  await logic.sendTokenToWeb();
                }
              },
              onReceivedError: (controller, request, error) {
                debugPrint('H5加载失败：${request.url} | ${error.description}');
              },
              onConsoleMessage: (controller, consoleMessage) {
                debugPrint('Vue控制台：${consoleMessage.message}');
              },
            ),
          ),
        );
      },
    );
  }
}
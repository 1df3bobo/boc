import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import 'webview_page_logic.dart';
import 'webview_page_state.dart';

class WebViewPage extends StatelessWidget {
  WebViewPage({Key? key}) : super(key: key);

  final WebViewLogic logic = Get.put(WebViewLogic());
  final WebViewState state = Get.find<WebViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebViewLogic>(
      builder: (_) {
        return PopScope(
          canPop: state.isPop,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;
            if (state.isPop) {
              Get.back();
            } else {
              state.webViewController!.goBack();
            }
          },
          child: Scaffold(
              body: InAppWebView(
            initialFile: 'assets/dist/index.html',
            initialSettings: InAppWebViewSettings(
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
            ),
            onUpdateVisitedHistory: (controller, url, androidIsReload) async {
              String path = url?.toString() ?? "";
              String currentHash =
                  path.contains('#') ? path.split('#').last : "";
              if (currentHash == state.routeName) {
                state.isPop = true;
              } else {
                state.isPop = false;
              }
              logic.update(['updateUI']);
            },
            onWebViewCreated: (controller) async {
              state.webViewController = controller;
              debugPrint('WebView创建完成');
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
            onLoadStart: (controller, url) {
              debugPrint('开始加载：$url');
            },
            onLoadStop: (controller, url) async {
              debugPrint('加载完成：$url');
              if (url.toString().contains('index.html') ||
                  (!url.toString().contains('#') &&
                      url.toString().endsWith('/'))) {
                await logic.initRouter();
                await logic.injectBridge();
                await logic.sendTokenToWeb();
                // Future.delayed(const Duration(milliseconds: 200),() async{
                //   var map = Get.arguments;
                //   await logic.sendDataToWeb(map);
                // });
              }
            },
            onReceivedError: (controller, request, error) {
              debugPrint('加载失败：${request.url} | ${error.description}');
            },
            onConsoleMessage: (controller, consoleMessage) {
              debugPrint('Vue控制台：${consoleMessage.message}');
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              return NavigationActionPolicy.ALLOW;
            },
          )),
        );
      },
      id: 'updateUI',
    );
  }
}

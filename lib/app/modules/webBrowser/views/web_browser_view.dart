import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/web_browser_controller.dart';

class WebBrowserView extends GetView<WebBrowserController> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(controller.title.value),
      ),
      child: SafeArea(
        child: WebView(
          initialUrl: controller.url.value,
          //JS执行模式 是否允许JS执行
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (webController) {
            controller.webViewController = webController;
          },
          onPageFinished: (url) {
            controller.webViewController
                .evaluateJavascript("document.title")
                .then((result) {
              controller.title.value = result;
            });
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith("myapp://")) {
              print("即将打开 ${request.url}");

              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          javascriptChannels: <JavascriptChannel>{
            JavascriptChannel(
                name: "share",
                onMessageReceived: (JavascriptMessage message) {
                  print("参数： ${message.message}");
                }),
          },
        ),
      ),
    );
  }
}

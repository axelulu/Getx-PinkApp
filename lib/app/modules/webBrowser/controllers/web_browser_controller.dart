import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebBrowserController extends GetxController {
  //TODO: Implement WebBrowserController
  var url = "".obs;
  var title = "".obs;
  late WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    url.value = Get.parameters["url"]!;
    if (GetPlatform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

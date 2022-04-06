import 'package:get/get.dart';

import '../controllers/web_browser_controller.dart';

class WebBrowserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebBrowserController>(
      () => WebBrowserController(),
    );
  }
}

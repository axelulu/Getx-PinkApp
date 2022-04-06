import 'package:get/get.dart';

import '../controllers/about_app_controller.dart';

class AboutAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutAppController>(
      () => AboutAppController(),
    );
  }
}

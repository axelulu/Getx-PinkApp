import 'package:get/get.dart';

import '../controllers/dark_mode_controller.dart';

class DarkModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DarkModeController>(
      () => DarkModeController(),
    );
  }
}

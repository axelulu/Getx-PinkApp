import 'package:get/get.dart';

import '../controllers/reg_controller.dart';

class RegBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegController>(
      () => RegController(),
    );
  }
}

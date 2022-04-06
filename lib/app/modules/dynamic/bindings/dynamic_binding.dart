import 'package:get/get.dart';

import '../controllers/dynamic_controller.dart';

class DynamicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DynamicController>(
      () => DynamicController(),
    );
  }
}

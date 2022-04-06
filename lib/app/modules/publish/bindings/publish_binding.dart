import 'package:get/get.dart';

import '../controllers/publish_controller.dart';

class PublishBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublishController>(
      () => PublishController(),
    );
  }
}

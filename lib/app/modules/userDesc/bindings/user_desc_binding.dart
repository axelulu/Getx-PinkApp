import 'package:get/get.dart';

import '../controllers/user_desc_controller.dart';

class UserDescBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDescController>(
      () => UserDescController(),
    );
  }
}

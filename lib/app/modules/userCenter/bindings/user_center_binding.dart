import 'package:get/get.dart';

import '../controllers/user_center_controller.dart';

class UserCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserCenterController>(
      () => UserCenterController(),
    );
  }
}

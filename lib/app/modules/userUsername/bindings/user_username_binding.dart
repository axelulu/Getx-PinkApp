import 'package:get/get.dart';

import '../controllers/user_username_controller.dart';

class UserUsernameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserUsernameController>(
      () => UserUsernameController(),
    );
  }
}

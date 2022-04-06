import 'package:get/get.dart';

import '../controllers/user_email_controller.dart';

class UserEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserEmailController>(
      () => UserEmailController(),
    );
  }
}

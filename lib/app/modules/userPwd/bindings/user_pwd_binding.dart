import 'package:get/get.dart';

import '../controllers/user_pwd_controller.dart';

class UserPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPwdController>(
      () => UserPwdController(),
    );
  }
}

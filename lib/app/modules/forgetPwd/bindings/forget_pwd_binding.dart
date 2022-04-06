import 'package:get/get.dart';

import '../controllers/forget_pwd_controller.dart';

class ForgetPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPwdController>(
      () => ForgetPwdController(),
    );
  }
}

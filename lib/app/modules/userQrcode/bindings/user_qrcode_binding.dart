import 'package:get/get.dart';

import '../controllers/user_qrcode_controller.dart';

class UserQrcodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserQrcodeController>(
      () => UserQrcodeController(),
    );
  }
}

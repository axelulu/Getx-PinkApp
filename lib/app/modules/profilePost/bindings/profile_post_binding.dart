import 'package:get/get.dart';

import '../controllers/profile_post_controller.dart';

class ProfilePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePostController>(
      () => ProfilePostController(),
    );
  }
}

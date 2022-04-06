import 'package:get/get.dart';

import '../controllers/profile_follow_controller.dart';

class ProfileFollowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileFollowController>(
      () => ProfileFollowController(),
    );
  }
}

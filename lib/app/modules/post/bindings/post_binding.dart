import 'package:get/get.dart';

import '../controllers/post_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(
      () => PostController(),
    );
  }
}

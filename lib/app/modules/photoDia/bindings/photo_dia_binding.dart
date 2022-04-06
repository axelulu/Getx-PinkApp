import 'package:get/get.dart';

import '../controllers/photo_dia_controller.dart';

class PhotoDiaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoDiaController>(
      () => PhotoDiaController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/rank_controller.dart';

class RankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RankController>(
      () => RankController(),
    );
  }
}

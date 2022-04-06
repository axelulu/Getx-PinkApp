import 'package:get/get.dart';
import 'package:pink_acg/app/data/user_center_mo.dart';

class UserUsernameController extends GetxController {
  //TODO: Implement UserUsernameController
  var profileMo = UserMeta().obs;

  @override
  void onInit() {
    profileMo.value = (Get.arguments as Map)["profileMo"];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

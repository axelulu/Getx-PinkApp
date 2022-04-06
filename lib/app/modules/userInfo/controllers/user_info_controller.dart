import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/user_center_mo.dart';
import 'package:pink_acg/app/http/dao/user_update_dao.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_net/core/pink_error.dart';

class UserInfoController extends GetxController {
  //TODO: Implement UserInfoController
  ScrollController scrollController = ScrollController();
  var profileMo = UserMeta().obs;

  Future<void> updateInfo(String slug, String value) async {
    try {
      var result = await UserUpdateDao.update(slug, value);
      if (result["code"] == 1000) {
        showToast("修改成功");
      } else {
        showToast("修改失败");
      }
    } on NeedLogin catch (e) {
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    }
  }

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
  void onClose() {
    scrollController.dispose();
  }
}

import 'package:get/get.dart';
import 'package:pink_acg/app/http/dao/login_dao.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_net/core/pink_error.dart';

import '../../../util/string_util.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  var protect = false.obs;
  var loginEnable = false.obs;
  late String email;
  late String password;

  void checkInput() {
    var enable;
    if (isEmail(email) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    loginEnable.value = enable;
  }

  void send() async {
    try {
      var result = await LoginDao.login(email, password);
      if (result['code'] == 1000) {
        showToast("登录成功");
        // 登录用户账号
        Get.offAllNamed("/index");
      } else {
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      showWarnToast(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

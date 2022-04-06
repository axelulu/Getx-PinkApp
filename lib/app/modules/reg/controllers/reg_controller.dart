import 'package:get/get.dart';
import 'package:pink_acg/app/http/dao/email_validate_code_dao.dart';
import 'package:pink_acg/app/http/dao/login_dao.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_net/core/pink_error.dart';

import '../../../util/string_util.dart';

class RegController extends GetxController {
  //TODO: Implement RegController
  var protect = false.obs;
  var loginEnable = false.obs;
  var userName;
  var email = "".obs;
  var validateCode;
  var password;
  var rePassword;

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword)) {
      enable = true;
    } else {
      enable = false;
    }
    this.loginEnable.value = enable;
  }

  void send() async {
    try {
      var result = await LoginDao.registration(
          userName, email.value, validateCode, password, rePassword);
      if (result['code'] == 1000) {
        showToast("注册成功");
        Get.offAllNamed("/login");
      } else {
        showWarnToast(result['msg']);
      }
    } on NeedLogin catch (e) {}
  }

  void sendRegEmail() async {
    try {
      if (isEmail(email.value)) {
        var result = await RegEmailValidateCodeDao.get(email.value);
        if (result['code'] == 1000) {
          showToast("验证码发送成功");
        } else {
          showWarnToast(result['msg']);
        }
      } else {
        showWarnToast("邮箱格式错误");
      }
    } on NeedLogin catch (e) {}
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = "二次密码不一致";
      showWarnToast(tips);
      return;
    }
    send();
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

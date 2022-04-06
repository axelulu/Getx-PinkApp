import 'package:get/get.dart';
import 'package:pink_acg/app/data/user_center_mo.dart';
import 'package:pink_acg/app/http/dao/email_validate_code_dao.dart';
import 'package:pink_acg/app/http/dao/user_update_dao.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_net/core/pink_error.dart';

import '../../../util/string_util.dart';

class UserEmailController extends GetxController {
  //TODO: Implement UserEmailController
  var profileMo = UserMeta().obs;
  var protect = false.obs;
  var loginEnable = false.obs;
  var newEmail = "".obs;
  late String validateCode;

  void checkInput() {
    bool enable;
    if (isNotEmpty(newEmail.value) && isNotEmpty(validateCode)) {
      enable = true;
    } else {
      enable = false;
    }
    this.loginEnable.value = enable;
  }

  void checkParams() {
    send();
  }

  void send() async {
    try {
      var result =
          await UserUpdateDao.updateEmail(newEmail.value, validateCode);
      if (result['code'] == 1000) {
        showToast("修改成功");
        Get.back();
      } else {
        showWarnToast(result['msg']);
      }
    } on NeedLogin catch (e) {}
  }

  void sendForgetEmail() async {
    try {
      if (isEmail(newEmail.value)) {
        var result = await ChangeEmailValidateCodeDao.get(newEmail.value);
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

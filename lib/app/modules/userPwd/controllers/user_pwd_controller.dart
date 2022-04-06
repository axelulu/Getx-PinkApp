import 'package:get/get.dart';
import 'package:pink_acg/app/data/user_center_mo.dart';
import 'package:pink_acg/app/http/dao/email_validate_code_dao.dart';
import 'package:pink_acg/app/http/dao/user_update_dao.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_net/core/pink_error.dart';

import '../../../util/string_util.dart';

class UserPwdController extends GetxController {
  //TODO: Implement UserPwdController
  var profileMo = UserMeta().obs;
  var protect = false.obs;
  var loginEnable = false.obs;
  late String oldPassword;
  late String validateCode;
  late String newPassword;
  late String reNewPassword;

  void checkInput() {
    bool enable;
    if (isNotEmpty(oldPassword) &&
        isNotEmpty(validateCode) &&
        isNotEmpty(newPassword) &&
        isNotEmpty(reNewPassword)) {
      enable = true;
    } else {
      enable = false;
    }
    this.loginEnable.value = enable;
  }

  void checkParams() {
    String? tips;
    if (newPassword != reNewPassword) {
      tips = "二次密码不一致";
      showWarnToast(tips);
      return;
    }
    send();
  }

  void send() async {
    try {
      var result = await UserUpdateDao.updatePassword(oldPassword,
          profileMo.value.email, validateCode, newPassword, reNewPassword);
      if (result['code'] == 1000) {
        showToast("修改成功");
        Get.back();
      } else {
        showWarnToast(result['msg']);
      }
    } on NeedLogin catch (e) {}
  }

  void sendForgetPwdEmail() async {
    try {
      if (isEmail(profileMo.value.email)) {
        var result =
            await ChangePwdEmailValidateCodeDao.get(profileMo.value.email);
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

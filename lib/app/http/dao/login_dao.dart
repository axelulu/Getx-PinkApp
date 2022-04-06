import 'package:get_storage/get_storage.dart';
import 'package:pink_acg/app/http/request/base_request.dart';
import 'package:pink_acg/app/http/request/forget_pwd_request.dart';
import 'package:pink_acg/app/http/request/login_request.dart';
import 'package:pink_acg/app/http/request/registration_request.dart';
import 'package:pink_acg/pink_constants.dart';
import 'package:pink_net/pink_net.dart';

class LoginDao {
  static login(String email, String password) {
    return _send(email, password);
  }

  static registration(String userName, String email, String validateCode,
      String password, String rePassword) {
    return _send(email, password,
        rePassword: rePassword, validateCode: validateCode, userName: userName);
  }

  static forgetPwd(String email, String validateCode, String password,
      String rePassword) async {
    ForgetPwdRequest request = ForgetPwdRequest();
    request
        .add("email", email)
        .add("validate_code", validateCode)
        .add("password", password)
        .add("re_password", rePassword);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }

  static _send(String email, String password,
      {rePassword, validateCode, userName}) async {
    BaseRequest request;
    if (rePassword != null || validateCode != null) {
      request = RegistrationRequest();
      request
          .add("email", email)
          .add("validate_code", validateCode)
          .add("username", userName)
          .add("password", password)
          .add("re_password", rePassword);
    } else {
      request = LoginRequest();
      request.add("email", email).add("password", password);
    }
    var result = await PinkNet.getInstance().fire(request);
    if (result['code'] == 1000 && result['data'] != null) {
      //保存登录令牌
      GetStorage().write(PinkConstants.authorization, result['data']);
    }
    return result;
  }

  static getBoardingPass() {
    return GetStorage().read(PinkConstants.authorization);
  }
}

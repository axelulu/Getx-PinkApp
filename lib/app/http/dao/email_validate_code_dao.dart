import 'package:pink_acg/app/http/request/email_validate_code_request.dart';
import 'package:pink_net/pink_net.dart';

class RegEmailValidateCodeDao {
  static get(String email) async {
    RegEmailValidateCodeRequest request = RegEmailValidateCodeRequest();
    request.add("email", email);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }
}

class ForgetPwdEmailValidateCodeDao {
  static get(String email) async {
    ForgetPwdEmailValidateCodeRequest request =
        ForgetPwdEmailValidateCodeRequest();
    request.add("email", email);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }
}

class ChangePwdEmailValidateCodeDao {
  static get(String email) async {
    ChangePwdEmailValidateCodeRequest request =
        ChangePwdEmailValidateCodeRequest();
    request.add("email", email);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }
}

class ChangeEmailValidateCodeDao {
  static get(String email) async {
    ChangeEmailValidateCodeRequest request = ChangeEmailValidateCodeRequest();
    request.add("email", email);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }
}

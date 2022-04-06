import 'package:pink_acg/app/http/request/user_update_request.dart';
import 'package:pink_net/pink_net.dart';

class UserUpdateDao {
  static update(String slug, String value) async {
    UserInfoUpdateRequest request = UserInfoUpdateRequest();
    request.add("slug", slug);
    request.add("value", value);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }

  static updatePassword(String oldPassword, String email, String validateCode,
      String newPassword, String reNewPassword) async {
    UserPasswordUpdateRequest request = UserPasswordUpdateRequest();
    request.add("old_password", oldPassword);
    request.add("email", email);
    request.add("validate_code", validateCode);
    request.add("new_password", newPassword);
    request.add("re_new_password", reNewPassword);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }

  static updateEmail(
    String newEmail,
    String validateCode,
  ) async {
    UserEmailUpdateRequest request = UserEmailUpdateRequest();
    request.add("new_email", newEmail);
    request.add("validate_code", validateCode);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }
}

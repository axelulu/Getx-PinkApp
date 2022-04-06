import 'package:pink_acg/app/data/user_center_mo.dart';
import 'package:pink_acg/app/http/request/user_center_request.dart';
import 'package:pink_net/pink_net.dart';

class UserCenterDao {
  static get(String userId) async {
    UserCenterRequest request = UserCenterRequest();
    request.pathParams = userId;
    var result = await PinkNet.getInstance().fire(request);
    return UserCenterMo.fromJson(result["data"]);
  }

  static getUserMeta(String userId) async {
    UserMetaRequest request = UserMetaRequest();
    request.pathParams = userId;
    var result = await PinkNet.getInstance().fire(request);
    return UserMeta.fromJson(result["data"]);
  }
}

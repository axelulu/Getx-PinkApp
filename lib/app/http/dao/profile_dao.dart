import 'package:pink_acg/app/data/user_center_mo.dart';
import 'package:pink_acg/app/http/request/profile_request.dart';
import 'package:pink_net/pink_net.dart';

class ProfileDao {
  static get() async {
    ProfileRequest request = ProfileRequest();
    var result = await PinkNet.getInstance().fire(request);
    return UserMeta.fromJson(result["data"]);
  }
}

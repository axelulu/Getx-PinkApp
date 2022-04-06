import 'package:pink_acg/app/data/dynamic_mo.dart';
import 'package:pink_acg/app/http/request/user_post_request.dart';
import 'package:pink_net/pink_net.dart';

class UserPostDao {
  static get(int userId, String type, int page, int size) async {
    UserPostRequest request = UserPostRequest();
    request.add("user_id", userId);
    request.add("post_type", type);
    request.add("page", page);
    request.add("size", size);
    var result = await PinkNet.getInstance().fire(request);
    return DynamicMo.fromJson(result["data"]);
  }
}

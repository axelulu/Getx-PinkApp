import 'package:pink_acg/app/http/request/follow_request.dart';
import 'package:pink_net/pink_net.dart';

class FollowDao {
  static get(int followId) async {
    FollowRequest request = FollowRequest();
    request.add("follow_id", followId);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }

  static remove(int followId) async {
    UnFollowRequest request = UnFollowRequest();
    request.add("follow_id", followId);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }

  static status(int followId) async {
    FollowStatusRequest request = FollowStatusRequest();
    request.pathParams = followId;
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }
}

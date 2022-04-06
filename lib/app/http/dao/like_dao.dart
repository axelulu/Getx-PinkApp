import 'package:pink_acg/app/http/request/like_request.dart';
import 'package:pink_net/pink_net.dart';

class LikeDao {
  static get(int postId) async {
    LikeRequest request = LikeRequest();
    request.add("post_id", postId);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }

  static remove(int postId) async {
    UnLikeRequest request = UnLikeRequest();
    request.add("post_id", postId);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }
}

import 'package:pink_acg/app/http/request/post_view_request.dart';
import 'package:pink_net/pink_net.dart';

class PostViewDao {
  static get(int postId) async {
    PostViewRequest request = PostViewRequest();
    request.pathParams = postId;
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }
}

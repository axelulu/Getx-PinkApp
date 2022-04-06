import 'package:pink_acg/app/http/request/favorite_request.dart';
import 'package:pink_net/pink_net.dart';

class FavoriteDao {
  static get(int postId) async {
    FavoriteRequest request = FavoriteRequest();
    request.add("post_id", postId);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }

  static remove(int postId) async {
    UnFavoriteRequest request = UnFavoriteRequest();
    request.add("post_id", postId);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }
}

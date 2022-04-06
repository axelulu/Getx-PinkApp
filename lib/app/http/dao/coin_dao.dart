import 'package:pink_acg/app/http/request/coin_request.dart';
import 'package:pink_net/pink_net.dart';

class CoinDao {
  static get(int postId) async {
    CoinRequest request = CoinRequest();
    request.add("coin", "1").add("post_id", postId);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }
}

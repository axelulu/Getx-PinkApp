import 'package:pink_acg/app/data/dynamic_mo.dart';
import 'package:pink_acg/app/http/request/await_watch_request.dart';
import 'package:pink_net/pink_net.dart';

class AwaitWatchDao {
  static get(String awaitWatchIds, {int page = 1, int size = 10}) async {
    AwaitWatchRequest request = AwaitWatchRequest();
    request.add("postIds", awaitWatchIds).add("page", page).add("size", size);
    var result = await PinkNet.getInstance().fire(request);
    return DynamicMo.fromJson(result["data"]);
  }
}

import 'package:pink_acg/app/data/dynamic_mo.dart';
import 'package:pink_acg/app/http/request/dynamic_request.dart';
import 'package:pink_net/pink_net.dart';

class DynamicDao {
  static get(String dynamic, {int page = 1, size = 10}) async {
    DynamicRequest request = DynamicRequest();
    request.add("dynamic", dynamic).add("page", page).add("size", size);
    var result = await PinkNet.getInstance().fire(request);
    return DynamicMo.fromJson(result["data"]);
  }
}

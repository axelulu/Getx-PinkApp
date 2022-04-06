import 'package:pink_acg/app/data/follow_list_mo.dart';
import 'package:pink_acg/app/http/request/follow_list_request.dart';
import 'package:pink_net/pink_net.dart';

class FollowListDao {
  static followList(int page) async {
    FollowListRequest request = FollowListRequest();
    request.add("page", page);
    var result = await PinkNet.getInstance().fire(request);
    print(result);
    return FansListMo.fromJson(result['data']);
  }

  static fansList(int page) async {
    FansListRequest request = FansListRequest();
    request.add("page", page);
    var result = await PinkNet.getInstance().fire(request);
    return FansListMo.fromJson(result['data']);
  }
}

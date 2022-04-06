import 'package:pink_acg/app/data/ranking_mo.dart';
import 'package:pink_acg/app/http/request/ranking_request.dart';
import 'package:pink_net/pink_net.dart';

class RankingDao {
  static get(String ranking, {int page = 1, size = 10}) async {
    RankingRequest request = RankingRequest();
    request.add("ranking", ranking).add("page", page).add("size", size);
    var result = await PinkNet.getInstance().fire(request);
    return RankingMo.fromJson(result["data"]);
  }
}

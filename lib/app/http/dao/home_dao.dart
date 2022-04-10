import 'package:pink_acg/app/data/home_mo.dart';
import 'package:pink_acg/app/http/request/home_request.dart';
import 'package:pink_net/pink_net.dart';

import '../../data/recommend_mo.dart';
import '../request/reco_posts_request.dart';

class HomeDao {
  static get(int categoryId,
      {int size = 10, int page = 1, String sort = "rand"}) async {
    HomeRequest request = HomeRequest();
    request
        .add("category_id", categoryId)
        .add("page", page)
        .add("size", size)
        .add("sort", sort)
        .add("cSize", size);
    var result = await PinkNet.getInstance().fire(request);
    return HomeMo.fromJson(result['data']);
  }

  static getRecoPosts(int categoryId,
      {int size = 10, int time_stamp = 1649412155013}) async {
    RecoPostsRequest request = RecoPostsRequest();
    request
        .add("category_id", categoryId)
        .add("time_stamp", time_stamp)
        .add("article_num", size);
    var result = await PinkNet.getInstance().fire(request);
    print("--------------------------------");
    print(categoryId);
    print(time_stamp);
    print(result);
    return RecommendMo.fromJson(result['data']);
  }
}

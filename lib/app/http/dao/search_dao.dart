import 'package:pink_acg/app/data/search.dart';
import 'package:pink_acg/app/http/request/search_request.dart';
import 'package:pink_net/pink_net.dart';

class SearchDao {
  static get(String type, String word,
      {String postType = "post", int page = 1, int size = 10}) async {
    SearchRequest request = SearchRequest();
    if (type == "all") {
      request
          .add("type", "all")
          .add("word", word)
          .add("page", page)
          .add("size", size);
    } else if (type == "post" || type == "video") {
      request
          .add("type", type)
          .add("word", word)
          .add("page", page)
          .add("size", size);
    } else if (type == "user") {
      request
          .add("type", type)
          .add("word", word)
          .add("page", page)
          .add("size", size);
    }
    var result = await PinkNet.getInstance().fire(request);
    return SearchPostMo.fromJson(result["data"]);
  }
}

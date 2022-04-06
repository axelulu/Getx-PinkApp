import 'package:pink_acg/app/http/request/publish_post_request.dart';
import 'package:pink_net/pink_net.dart';

class PublishPostDao {
  static get(String title, String content, String cover, int categoryId,
      String type, String video) async {
    PublishPostRequest request = PublishPostRequest();
    request
        .add("title", title)
        .add("content", content)
        .add("cover", cover)
        .add("post_type", type)
        .add("video", video)
        .add("category_id", categoryId);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }
}

import 'package:pink_acg/app/data/comment_mo.dart';
import 'package:pink_acg/app/http/request/comment_request.dart';
import 'package:pink_net/pink_net.dart';

class CommentDao {
  static get(int postId, int page, int size) async {
    CommentRequest request = CommentRequest();
    request.add("page", page);
    request.add("size", size);
    request.add("post_id", postId);
    var result = await PinkNet.getInstance().fire(request);
    print(result);
    return CommentMo.fromJson(result["data"]);
  }

  static post(int postId, String content, String type,
      {String parent = "0"}) async {
    CommentCreateRequest request = CommentCreateRequest();
    request.add("post_id", postId);
    request.add("content", content);
    request.add("type", type);
    request.add("parent", parent);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }
}

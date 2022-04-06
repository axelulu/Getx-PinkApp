import 'package:pink_acg/app/data/chat_mo.dart';
import 'package:pink_acg/app/http/request/chat_request.dart';
import 'package:pink_net/pink_net.dart';

class ChatDao {
  static get(int sid, {int page = 1, int size = 10}) async {
    ChatRequest request = ChatRequest();
    request.add("sid", sid).add("page", page).add("size", size);
    var result = await PinkNet.getInstance().fire(request);
    return ChatList.fromJson(result["data"]);
  }
}

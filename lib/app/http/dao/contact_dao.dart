import 'package:pink_acg/app/data/contact.dart';
import 'package:pink_acg/app/http/request/contact_request.dart';
import 'package:pink_net/pink_net.dart';

class ContactDao {
  static get() async {
    ContactRequest request = ContactRequest();
    var result = await PinkNet.getInstance().fire(request);
    print(result);
    return ContactMo.fromJson(result["data"]);
  }

  static getItem(String sendId) async {
    ContactItemRequest request = ContactItemRequest();
    request.pathParams = sendId;
    var result = await PinkNet.getInstance().fire(request);
    print(result);
    return ContactList.fromJson(result["data"]);
  }

  static post(String sid) async {
    ContactAddRequest request = ContactAddRequest();
    request.add("send_id", sid);
    var result = await PinkNet.getInstance().fire(request);
    return result;
  }
}

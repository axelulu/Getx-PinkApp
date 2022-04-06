import 'dart:convert';

import 'package:pink_acg/app/http/request/log_request.dart';
import 'package:pink_net/pink_net.dart';

class LogDao {
  static post(dynamic param,
      {required String readTime, required int categoryId}) async {
    LogRequest request = LogRequest();
    request
        .add("param", jsonEncode(param))
        .add("readTime", readTime)
        .add("categoryId", categoryId);
    var result = await PinkNet.getInstance().fire(request);
    print(result);
    return result;
  }
}

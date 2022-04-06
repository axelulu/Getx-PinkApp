import 'dart:convert';

import 'package:dio/dio.dart';

Future<String> getHttp(url) async {
  FormData formData = FormData.fromMap({"url": url});
  var response = await Dio().post(
      "https://www.daimadog.com/wp-content/themes/mytheme/action/dyjx.php",
      data: formData);
  var data = jsonDecode(response.toString());
  return data["playurl"][0];
}

Future<String> getHttp2(url) async {
  var response = await Dio()
      .get("https://tenapi.cn/bilivideo/", queryParameters: {"url": url});
  var data = jsonDecode(response.toString());
  return data["url"];
}

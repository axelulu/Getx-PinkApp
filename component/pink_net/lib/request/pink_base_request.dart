import 'package:dio/dio.dart';

enum HttpMethod { GET, POST, DELETE }

/// 基础请求

abstract class PinkBaseRequest {
  var pathParams;
  var useHttps = false;
  String authority() {
    return "localhost";
  }

  HttpMethod httpMethod();
  String path();
  String url() {
    Uri uri;
    var pathStr = path();
    // 拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    // http和https切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    return uri.toString();
  }

  bool needLogin();
  Map<String, String> params = Map();
  FormData? file;

  ///添加参数
  PinkBaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = {};

  ///添加header
  PinkBaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}

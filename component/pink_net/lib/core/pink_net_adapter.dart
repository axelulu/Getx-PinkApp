import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pink_net/request/pink_base_request.dart';

///网络请求抽象类
abstract class PinkNetAdapter {
  ProgressCallback? sendProgress;
  Future<PinkNetResponse<T>> send<T>(PinkBaseRequest request);
}

///统一网络层返回格式
class PinkNetResponse<T> {
  T? data;
  PinkBaseRequest request;
  int? statusCode;
  String? statusMessage;
  late dynamic extra;

  PinkNetResponse(
      {this.data,
      required this.request,
      this.statusCode,
      this.statusMessage,
      this.extra});

  @override
  String toString() {
    if (data is Map) {
      return jsonEncode(data);
    }
    return data.toString();
  }
}

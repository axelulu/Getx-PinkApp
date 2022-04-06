import 'package:dio/dio.dart';
import 'package:pink_net/request/pink_base_request.dart';

import 'core/dio_adapter.dart';
import 'core/pink_error.dart';
import 'core/pink_net_adapter.dart';

class PinkNet {
  PinkNet._();
  static PinkNet? _instance;
  static PinkNet getInstance() {
    _instance ??= PinkNet._();
    return _instance!;
  }

  Future fire(PinkBaseRequest request) async {
    late PinkNetResponse response;
    var error;
    try {
      response = await send(request);
    } on PinkNetError catch (e) {
      error = e;
      response = e.data;
    } catch (e) {
      error = e;
    }
    if (response == null) {
      print(error);
    }
    var result = response.data;
    var status = response.statusCode;
    print(response);
    switch (status) {
      case 200:
        return result;
      case 401:
        return NeedLogin();
      case 403:
        return NeedAuth(result.toString(), data: result);
      default:
        throw PinkNetError(status!, result.toString(), data: result);
    }
  }

  ProgressCallback sendProgress = (int count, int total) {};

  Future<dynamic> send<T>(PinkBaseRequest request) async {
    PinkNetAdapter adapter = DioAdapter();
    if (request.file != null) {
      adapter.sendProgress = sendProgress;
    }
    return adapter.send(request);
  }

  void printLog(log) {}
}

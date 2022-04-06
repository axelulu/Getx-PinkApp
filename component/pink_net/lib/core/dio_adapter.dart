import 'package:dio/dio.dart';
import 'package:pink_net/request/pink_base_request.dart';

import 'pink_error.dart';
import 'pink_net_adapter.dart';

///Dio适配器
class DioAdapter extends PinkNetAdapter {
  @override
  ProgressCallback? sendProgress;

  @override
  Future<PinkNetResponse<T>> send<T>(PinkBaseRequest request) async {
    // TODO: implement send
    var response, options = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        print(request.url());
        print(request.params);
        print(options);
        if (request.file != null) {
          response = await Dio().post(request.url(),
              options: options,
              data: request.file,
              onSendProgress: sendProgress);
        } else {
          response = await Dio()
              .post(request.url(), options: options, data: request.params);
        }
        print("------------");
        print(response);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), options: options, data: request.params);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      ///抛出PinkNetError
      throw PinkNetError(response?.statusCode ?? -1, error.toString(),
          data: await buildRes(response, request));
    }
    return buildRes(response, request);
  }

  /// 构建PinkNetResponse
  Future<PinkNetResponse<T>> buildRes<T>(
      Response? response, PinkBaseRequest request) {
    return Future.value(
      PinkNetResponse(
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response,
      ),
    );
  }
}

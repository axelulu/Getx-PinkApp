///需要登录异常
class NeedLogin extends PinkNetError {
  NeedLogin({int code: 401, String message: '需要登录'}) : super(code, message);
}

///需要授权异常
class NeedAuth extends PinkNetError {
  NeedAuth(String message, {int code: 403, dynamic data})
      : super(code, message, data: data);
}

///网络异常统一格式类
class PinkNetError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  PinkNetError(this.code, this.message, {this.data});
}

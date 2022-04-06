import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pink_acg/app/data/chat_mo.dart';
import 'package:pink_acg/pink_constants.dart';
import 'package:web_socket_channel/io.dart';

///负责与后端进行websocket通信
class Socket implements ISocket {
  final Map<String, dynamic> headers;
  var url = "ws://" + PinkConstants.domain + ":8080/api/v1/chat";
  late IOWebSocketChannel _channel;
  late ValueChanged<ChatMo> _callBack;

  ///心跳间隔秒数，根据服务器实际timeout进行调整
  int _intervalSeconds = 50;

  Socket(this.headers);

  @override
  void close() {
    if (_channel != null) {
      _channel.sink.close();
    }
  }

  @override
  ISocket open() {
    _channel = IOWebSocketChannel.connect(url,
        headers: headers, pingInterval: Duration(seconds: _intervalSeconds));
    _channel.stream.handleError((error) {
      print(error);
    }).listen((event) {
      _handleMessage(event);
    });
    return this;
  }

  @override
  ISocket listen(ValueChanged<ChatMo> callBack) {
    _callBack = callBack;
    return this;
  }

  @override
  ISocket send(String message, int userId, int sendId) {
    Map msg = {
      "cmd": 10,
      "send_id": sendId,
      "user_id": userId,
      "content": message,
      "media": 1,
    };
    _channel.sink.add(jsonEncode(msg));
    return this;
  }

  ///处理服务端的返回
  void _handleMessage(event) {
    event = jsonDecode(event);
    ChatMo result = ChatMo.fromJson(event);
    if (result != null && _callBack != null) {
      _callBack(result);
    }
  }
}

abstract class ISocket {
  ///和服务器建立连接
  ISocket open();

  ///发送弹幕
  ISocket send(String message, int userId, int sendId);

  ///关闭连接
  void close();

  ///接受弹幕
  ISocket listen(ValueChanged<ChatMo> callBack);
}

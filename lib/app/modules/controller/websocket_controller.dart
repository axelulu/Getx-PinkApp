import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/chat_mo.dart';
import 'package:pink_acg/app/http/dao/login_dao.dart';
import 'package:pink_acg/pink_constants.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketController extends GetxController {
  /// webSocket
  var url = "ws://" + PinkConstants.domain + ":8080/api/v1/chat";
  late IOWebSocketChannel _channel;
  late ValueChanged<ChatMo> _callBack;

  ///心跳间隔秒数，根据服务器实际timeout进行调整
  int _intervalSeconds = 50;

  void close() {
    if (_channel != null) {
      _channel.sink.close();
    }
  }

  open() {
    _channel = IOWebSocketChannel.connect(url,
        headers: {
          PinkConstants.authorization: "Bearer " + LoginDao.getBoardingPass()
        },
        pingInterval: Duration(seconds: _intervalSeconds));
    _channel.stream.handleError((error) {
      print(error);
    }).listen((event) {
      _handleMessage(event);
    });
  }

  listen(ValueChanged<ChatMo> callBack) {
    _callBack = callBack;
  }

  send(String message, String pic, int userId, int sendId, int media) {
    Map msg = {
      "cmd": 10,
      "send_id": sendId,
      "user_id": userId,
      "content": message,
      "pic": pic,
      "media": media,
    };
    _channel.sink.add(jsonEncode(msg));
  }

  ///处理服务端的返回
  void _handleMessage(event) {
    event = jsonDecode(event);
    ChatMo result = ChatMo.fromJson(event);
    if (result != null && _callBack != null) {
      _callBack(result);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    open();
  }
}

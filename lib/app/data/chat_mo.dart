class ChatList {
  late List<ChatMo> list;
  late int total;

  ChatList({required this.list, required this.total});

  ChatList.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ChatMo>[];
      json['list'].forEach((v) {
        list.add(ChatMo.fromJson(v));
      });
    } else {
      list = <ChatMo>[];
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class ChatMo {
  late int userId;
  late int cmd;
  late int sendId;
  late String content;
  late String pic;
  late int media;

  ChatMo(
      {this.userId = 0,
      this.cmd = 0,
      this.sendId = 0,
      this.content = "",
      this.pic = "",
      this.media = 0});

  ChatMo.fromJson(Map<String, dynamic> json) {
    if (json['user_id'] != null) {
      userId = json['user_id'];
    } else {
      userId = 0;
    }
    if (json['cmd'] != null) {
      cmd = json['cmd'];
    } else {
      cmd = 0;
    }
    if (json['send_id'] != null) {
      sendId = json['send_id'];
    } else {
      sendId = 0;
    }
    if (json['content'] != null) {
      content = json['content'];
    } else {
      content = "";
    }
    if (json['pic'] != null) {
      pic = json['pic'];
    } else {
      pic = "";
    }
    if (json['media'] != null) {
      media = json['media'];
    } else {
      media = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = userId;
    data['cmd'] = cmd;
    data['send_id'] = sendId;
    data['content'] = content;
    data['pic'] = pic;
    data['media'] = media;
    return data;
  }
}

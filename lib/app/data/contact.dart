import 'package:pink_acg/app/data/user_center_mo.dart';

import '../data/chat_mo.dart';

class ContactMo {
  late List<ContactList>? list;
  late int total;

  ContactMo({this.list, this.total = 0});

  ContactMo.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ContactList>[];
      json['list'].forEach((v) {
        list!.add(new ContactList.fromJson(v));
      });
    } else {
      list = <ContactList>[];
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class ContactList {
  late int userId;
  late int sendId;
  late UserMeta? sendUserMeta;
  late ChatMo? chatMo;
  late String updateTime;

  ContactList(
      {this.userId = 0,
      this.sendId = 0,
      this.sendUserMeta,
      this.chatMo,
      this.updateTime = ""});

  ContactList.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    sendId = json['send_id'];
    sendUserMeta = (json['send_user_meta'] != null
        ? new UserMeta.fromJson(json['send_user_meta'])
        : null)!;
    chatMo = (json['msg'] != null ? new ChatMo.fromJson(json['msg']) : null)!;
    updateTime = json['update_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['send_id'] = this.sendId;
    if (this.sendUserMeta != null) {
      data['send_user_meta'] = this.sendUserMeta!.toJson();
    }
    if (this.chatMo != null) {
      data['msg'] = this.chatMo!.toJson();
    }
    data['update_time'] = this.updateTime;
    return data;
  }
}

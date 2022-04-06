import 'package:pink_acg/app/data/user_center_mo.dart';

class CommentMo {
  late List<CommentList> list;
  late int total;

  CommentMo({required this.list, required this.total});

  CommentMo.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CommentList>[];
      json['list'].forEach((v) {
        list.add(CommentList.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['list'] = list.map((v) => v.toJson()).toList();
    data['total'] = total;
    return data;
  }
}

class CommentList {
  late UserMeta owner;
  late int postId;
  late int userId;
  late String content;
  late String type;
  late int parent;
  late int likeNum;
  late String updatedTime;

  CommentList(
      {required this.owner,
      required this.postId,
      required this.userId,
      required this.content,
      required this.type,
      required this.parent,
      required this.likeNum,
      required this.updatedTime});

  CommentList.fromJson(Map<String, dynamic> json) {
    owner = (json['owner'] != null ? UserMeta.fromJson(json['owner']) : null)!;
    postId = json['post_id'];
    userId = json['user_id'];
    content = json['content'];
    type = json['type'];
    parent = json['parent'];
    likeNum = json['like_num'];
    updatedTime = json['update_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['owner'] = owner.toJson();
    data['post_id'] = postId;
    data['user_id'] = userId;
    data['content'] = content;
    data['type'] = type;
    data['parent'] = parent;
    data['like_num'] = likeNum;
    data['update_time'] = updatedTime;
    return data;
  }
}

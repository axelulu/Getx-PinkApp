import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/data/user_center_mo.dart';

class SearchPostMo {
  late List<PostMo> post;
  late String type;

  SearchPostMo({required this.post, required this.type});

  SearchPostMo.fromJson(Map<String, dynamic> json) {
    if (json['post'] != null) {
      post = <PostMo>[];
      json['post'].forEach((v) {
        post.add(new PostMo.fromJson(v));
      });
    } else {
      post = <PostMo>[];
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['post'] = this.post.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}

class SearchUserMo {
  late String type;
  late List<UserMeta> user;

  SearchUserMo({required this.type, required this.user});

  SearchUserMo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['user'] != null) {
      user = <UserMeta>[];
      json['user'].forEach((v) {
        user.add(new UserMeta.fromJson(v));
      });
    } else {
      user = <UserMeta>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.user != null) {
      data['user'] = this.user.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

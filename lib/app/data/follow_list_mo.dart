import 'package:pink_acg/app/data/user_center_mo.dart';

class FansListMo {
  late List<FansList> list;
  late int total;

  FansListMo({required this.list, required this.total});

  FansListMo.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <FansList>[];
      json['list'].forEach((v) {
        list.add(new FansList.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class FansList {
  late bool isFollow;
  late UserMeta userMeta;

  FansList({required this.isFollow, required this.userMeta});

  FansList.fromJson(Map<String, dynamic> json) {
    isFollow = json['IsFollow'];
    userMeta = (json['UserMeta'] != null
        ? UserMeta.fromJson(json['UserMeta'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsFollow'] = this.isFollow;
    if (this.userMeta != null) {
      data['UserMeta'] = this.userMeta.toJson();
    }
    return data;
  }
}

class FollowListMo {
  late List<UserMeta> list;
  late int total;

  FollowListMo({required this.list, required this.total});

  FollowListMo.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <UserMeta>[];
      json['list'].forEach((v) {
        list.add(new UserMeta.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

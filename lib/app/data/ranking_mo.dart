import 'package:pink_acg/app/data/post_mo.dart';

class RankingMo {
  late List<PostMo> list;
  late int total;

  RankingMo({required this.list, required this.total});

  RankingMo.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <PostMo>[];
      json['list'].forEach((v) {
        list.add(new PostMo.fromJson(v));
      });
    } else {
      list = <PostMo>[];
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

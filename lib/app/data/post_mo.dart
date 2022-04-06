import 'dart:convert';

import 'package:pink_acg/app/data/user_center_mo.dart';
import 'package:pink_acg/app/data/video_detail_mo.dart';

class PostMo {
  late UserMeta? userMeta;
  late int postId;
  late int authorId;
  late String postType;
  late int categoryId;
  late String title;
  late String content;
  late int reply;
  late int favorite;
  late int likes;
  late int un_likes;
  late int coin;
  late int share;
  late int view;
  late String cover;
  late Collection video;
  late String download;
  late String createTime;
  late String updateTime;

  PostMo(
      {this.postId = 0,
      this.userMeta,
      this.authorId = 0,
      this.postType = "",
      this.categoryId = 0,
      this.title = "",
      this.content = "",
      this.reply = 0,
      this.favorite = 0,
      this.likes = 0,
      this.un_likes = 0,
      this.coin = 0,
      this.share = 0,
      this.view = 0,
      this.cover = "",
      required this.video,
      this.download = "",
      this.createTime = "",
      this.updateTime = ""});

  PostMo.fromJson(Map<String, dynamic> json) {
    userMeta =
        (json['owner'] != null ? UserMeta.fromJson(json['owner']) : null)!;
    postId = json['post_id'];
    authorId = json['author_id'];
    postType = json['post_type'];
    categoryId = json['category_id'];
    title = json['title'];
    content = json['content'];
    reply = json['reply'];
    favorite = json['favorite'];
    likes = json['likes'];
    un_likes = json['un_likes'];
    coin = json['coin'];
    share = json['share'];
    view = json['view'];
    cover = json['cover'];
    video = (json['video'] != null
        ? Collection.fromJson(jsonDecode(json['video']))
        : null)!;
    download = json['download'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userMeta != null) {
      data['owner'] = userMeta!.toJson();
    }
    data['post_id'] = postId;
    data['author_id'] = authorId;
    data['post_type'] = postType;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['content'] = content;
    data['reply'] = reply;
    data['favorite'] = favorite;
    data['likes'] = likes;
    data['un_likes'] = un_likes;
    data['coin'] = coin;
    data['share'] = share;
    data['view'] = view;
    data['cover'] = cover;
    data['video'] = video.toJson();
    data['download'] = download;
    data['create_time'] = createTime;
    data['update_time'] = updateTime;
    return data;
  }
}

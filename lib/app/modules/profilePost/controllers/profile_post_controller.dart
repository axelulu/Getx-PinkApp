import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfilePostController extends GetxController {
  //TODO: Implement ProfilePostController
  ScrollController scrollController = ScrollController();
  late String postType;
  late int userId;

  String title() {
    var title;
    if (postType == "star") {
      title = "收藏";
    } else if (postType == "like") {
      title = "喜欢";
    } else if (postType == "unlike") {
      title = "不喜欢";
    } else if (postType == "coin") {
      title = "投币";
    } else if (postType == "dynamic") {
      title = "动态";
    } else if (postType == "video") {
      title = "视频";
    } else if (postType == "post") {
      title = "文章";
    } else if (postType == "await_watch") {
      title = "稍后观看";
    } else if (postType == "history_watch") {
      title = "观看历史";
    }
    return title;
  }

  @override
  void onInit() {
    postType = (Get.arguments as Map)["postType"];
    userId = (Get.arguments as Map)["userId"];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }
}

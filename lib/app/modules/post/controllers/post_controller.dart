import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/data/video_detail_mo.dart';
import 'package:pink_acg/app/http/dao/comment_dao.dart';
import 'package:pink_acg/app/http/dao/video_detail_dao.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_net/core/pink_error.dart';

class PostController extends GetxController with SingleGetTickerProviderMixin {
  //TODO: Implement PostController
  GlobalKey repaintKey = GlobalKey();
  late Map<String, dynamic> qrContent = Map<String, dynamic>();
  late ScrollController controller;
  final contentDetailModel = VideoDetailMo().obs;
  final contentModel = PostMo(
      video: Collection(video: <VideoCollection>[
    VideoCollection(list: [CollectionList()])
  ])).obs;
  late TabController tabController;
  late TextEditingController textEditingController;
  var categoryList = [
    "评论",
    "转发",
  ];
  var showBarColor = false.obs;
  var random = 0.obs;

  Future<void> loadDetail() async {
    try {
      VideoDetailMo result =
          await VideoDetailDao.get(contentModel.value.postId.toString());
      contentDetailModel.value = result;
      contentModel.value = result.postInfo!;
      addPostView(contentModel.value.postId);
    } on NeedLogin catch (e) {
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    }
  }

  Future<void> send(String value) async {
    try {
      if (value.isNotEmpty) {
        textEditingController.text = "";
        var result =
            await CommentDao.post(contentModel.value.postId, value, "post");
        if (result["code"] == 1000) {
          random.value = Random().nextInt(100);
          showToast("评论成功");
        } else {
          showWarnToast(result['msg']);
        }
      } else {
        showWarnToast("评论不能为空");
      }
    } on NeedLogin catch (e) {
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    }
  }

  @override
  void onInit() {
    contentModel.value = (Get.arguments as Map)["contentModel"];
    var awaitWatch = GetStorage().read("historyWatchPost");
    if (awaitWatch != null && awaitWatch.length > 0) {
      if (!awaitWatch.contains("${contentModel.value.postId}")) {
        awaitWatch.insert(0, "${contentModel.value.postId}");
      }
      GetStorage().write("historyWatchPost", awaitWatch);
    } else {
      GetStorage().write("historyWatchPost", ["${contentModel.value.postId}"]);
    }
    textEditingController = TextEditingController();
    tabController = TabController(length: categoryList.length, vsync: this);
    controller = ScrollController();
    controller.addListener(() {
      if (controller.position.pixels > setHeight(200) && !showBarColor.value) {
        showBarColor.value = true;
      }
      if (controller.position.pixels < setHeight(200) && showBarColor.value) {
        showBarColor.value = false;
      }
    });
    loadDetail();
    qrContent["type"] = "post";
    qrContent["id"] = contentModel.value.postId.toString();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    controller.dispose();
    tabController.dispose();
    textEditingController.dispose();
  }
}

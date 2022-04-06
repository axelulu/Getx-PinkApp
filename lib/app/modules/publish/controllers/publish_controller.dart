import 'dart:convert';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/category_mo.dart';
import 'package:pink_acg/app/data/home_mo.dart';
import 'package:pink_acg/app/data/video_detail_mo.dart';
import 'package:pink_acg/app/http/dao/category_dao.dart';
import 'package:pink_acg/app/http/dao/publish_post_dao.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:rich_editor/rich_editor.dart';

class PublishController extends GetxController {
  //TODO: Implement PublishController
  /// 编辑器
  late FocusNode focusNode;
  GlobalKey<RichEditorState> keyEditor = GlobalKey();
  var category = <CategoryMo>[].obs;
  late String type;
  // FijkPlayer实例
  var player = FijkPlayer().obs;

  var isActive = true.obs;

  var cover = "".obs;

  var title = "".obs;

  var contents = "".obs;

  var categoryId = 0.obs;

  var progressBar = 0.0.obs;

  var collection = Collection(video: <VideoCollection>[
    VideoCollection(list: [CollectionList()])
  ]).obs;

  void publish() async {
    String? postHtml = await keyEditor.currentState?.getHtml();
    if (!isActive.value) {
      showWarnToast("请等待上传完成");
      return;
    }
    if (type == "dynamic" && contents.value.isEmpty) {
      showWarnToast("请填写完整内容");
      return;
    }
    if (type == "post" &&
        (cover.value.isEmpty || title.value.isEmpty || postHtml!.isEmpty)) {
      showWarnToast("请填写完整内容");
      return;
    }
    if (type == "video" &&
        (cover.value.isEmpty ||
            title.value.isEmpty ||
            collection.value.video[0].list[0].url.isEmpty)) {
      showWarnToast("请填写完整内容");
      return;
    }
    if (type == "collection" &&
        (cover.value.isEmpty ||
            title.value.isEmpty ||
            collection.value.video[0].list[0].url.isEmpty ||
            collection.value.video[0].list[0].name.isEmpty)) {
      showWarnToast("请填写完整内容");
      return;
    }
    if (type != "dynamic" && type != "video" && type != "collection") {
      contents.value = postHtml!;
    }
    collection.value.video[0].name = title.value;
    var result = await PublishPostDao.get(
        title.value,
        contents.value,
        cover.value,
        categoryId.value,
        type,
        jsonEncode(collection.value.toJson()));
    if (result["code"] == 1000) {
      showToast("文章发布成功");
      Future.delayed(Duration(milliseconds: 1000), () {
        Get.offAllNamed("/index");
      });
    } else {
      showWarnToast(result['msg']);
    }
  }

  _loadData() async {
    CategoryModel result = await CategoryDao.get(20);
    category.value = result.data;
  }

  @override
  void onInit() {
    type = (Get.arguments as Map)["type"];

    /// 编辑器
    focusNode = FocusNode();

    _loadData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    player.value.dispose();
    focusNode.dispose();
  }
}

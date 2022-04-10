import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/home_mo.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/data/user_center_mo.dart';
import 'package:pink_acg/app/http/dao/home_dao.dart';
import 'package:pink_acg/app/http/dao/profile_dao.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_acg/app/util/update.dart';
import 'package:pink_net/core/pink_error.dart';

import '../../../data/recommend_mo.dart';

class RecommendController extends GetxController
    with SingleGetTickerProviderMixin {
  //TODO: Implement RecommendController
  var listener;
  late TabController controller;
  List<CategoryMo> categoryList = [];
  List<PostMo> bannerList = [];
  var avatar = "".obs;

  var isLoading = true.obs;
  late Widget currentPage;
  var Update = false.obs;
  var serverAndroidVersion = "";
  var serverAndroidUrl = "";
  var serverAndroidMsg = "";

  @override
  void onInit() {
    ///初始化应用信息
    super.onInit();
    controller = TabController(length: categoryList.length, vsync: this);
    userAvatar();
    checkUpdate();
    loadData();
  }

  userAvatar() async {
    try {
      UserMeta result = await ProfileDao.get();
      avatar.value = result.avatar;
    } on NeedAuth catch (e) {
      showToast(e.message);
    } on NeedLogin catch (e) {
      showToast(e.message);
    } on PinkNetError catch (e) {
      showToast(e.message);
    }
  }

  void checkUpdate() async {
    Map res = await UpdateUtil.getUpgrade();
    if (res["update"] == true) {
      Update.value = true;
      serverAndroidVersion = res["version"];
      serverAndroidMsg = res["msg"];
      serverAndroidUrl = res["url"];
    }
  }

  void loadData() async {
    try {
      RecommendMo result = await HomeDao.getRecoPosts(1);
      if (result.category != null) {
        controller =
            TabController(length: result.category!.length, vsync: this);
      }
      categoryList = result.category!;
      bannerList = result.banner!;
      isLoading.value = false;
    } on NeedAuth catch (e) {
      isLoading.value = false;
      showWarnToast(e.message);
    } on PinkNetError catch (e) {
      isLoading.value = false;
      showWarnToast(e.message);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

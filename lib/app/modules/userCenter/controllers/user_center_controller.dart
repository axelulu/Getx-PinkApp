import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/user_center_mo.dart';
import 'package:pink_acg/app/http/dao/follow_dao.dart';
import 'package:pink_acg/app/http/dao/profile_dao.dart';
import 'package:pink_acg/app/http/dao/user_center_dao.dart';
import 'package:pink_acg/app/http/dao/user_update_dao.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_net/core/pink_error.dart';

class UserCenterController extends GetxController
    with SingleGetTickerProviderMixin {
  //TODO: Implement UserCenterController
  late TabController tabController;
  var userCenterMo = UserCenterMo().obs;
  var profileMo = UserMeta().obs;
  var isFollow = 3.obs;
  var categoryList = [
    {"key": "main", "name": "主页"},
    {"key": "dynamic", "name": "动态"},
    {"key": "post", "name": "文章"},
    {"key": "video", "name": "视频"},
  ];
  double headerHight = setHeight(420);
  var showDetail = false.obs;
  late ScrollController controller;
  var showBarColor = false.obs;
  var userMeta = UserMeta().obs;

  currentUserMeta() async {
    try {
      UserMeta result = await ProfileDao.get();
      userMeta.value = result;
    } on NeedAuth catch (e) {
      showToast(e.message);
    } on NeedLogin catch (e) {
      showToast(e.message);
    } on PinkNetError catch (e) {
      showToast(e.message);
    }
  }

  Future<void> updateInfo(String slug, String value) async {
    try {
      var result = await UserUpdateDao.update(slug, value);
      if (result["code"] == 1000) {
        showToast("修改成功");
      } else {
        showToast("修改失败");
      }
    } on NeedLogin catch (e) {
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    }
  }

  Future<void> loadUserCenter() async {
    try {
      UserCenterMo result =
          await UserCenterDao.get(profileMo.value.userId.toString());
      profileMo.value = result.user!;
      userCenterMo.value = result;
    } on NeedLogin catch (e) {
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    }
  }

  void loadFollowStatus() async {
    try {
      var result = await FollowDao.status(profileMo.value.userId);
      isFollow.value = result["data"];
    } on NeedLogin catch (e) {
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    }
  }

  @override
  void onInit() {
    currentUserMeta();
    profileMo.value = (Get.arguments as Map)["profileMo"];
    tabController = TabController(length: categoryList.length, vsync: this);
    loadUserCenter();
    loadFollowStatus();

    controller = ScrollController();
    controller.addListener(() {
      if (controller.position.pixels > setHeight(200) + headerHight &&
          !showBarColor.value) {
        showBarColor.value = true;
      }
      if (controller.position.pixels < setHeight(200) + headerHight &&
          showBarColor.value) {
        showBarColor.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    controller.dispose();
  }
}

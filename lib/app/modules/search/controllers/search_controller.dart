import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SearchController extends GetxController
    with SingleGetTickerProviderMixin {
  //TODO: Implement SearchController
  var categoryList = [
    {"key": "all", "name": "全部"},
    {"key": "video", "name": "视频"},
    {"key": "post", "name": "文章"},
    {"key": "user", "name": "用户"},
  ];
  late TabController controller;
  var searchWord = "".obs;
  var hasInput = true.obs;
  var allSearchHistorys = [].obs;

  var dataList = [
    "RNG小组第一",
    "王者荣耀六周年GG",
    "王者荣耀六周年GG",
    "王者荣耀六周年GG",
    "王者荣耀六周年GG",
    "王者荣耀六周年GG"
  ];

  var dataList2 = ["我怕", "王者荣耀", "王者年GG", "王者周年GG", "王者荣", "王G"];

  void setSearchHistory(String value) {
    var history = GetStorage().read("searchHistory");
    if (history != null) {
      history.add(value);
    } else {
      history = ["$value"];
    }
    GetStorage().write("searchHistory", history);
    hasInput.value = false;
  }

  @override
  void onInit() {
    allSearchHistorys.value = GetStorage().read("searchHistory") ?? [];
    controller = TabController(length: categoryList.length, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    controller.dispose();
  }
}

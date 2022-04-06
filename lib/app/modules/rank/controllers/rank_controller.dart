import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RankController extends GetxController with SingleGetTickerProviderMixin {
  //TODO: Implement RankController
  var tabs = [
    {"key": "likes", "name": "最热"},
    {"key": "create_time", "name": "最新"},
    {"key": "favorite", "name": "收藏"},
  ];
  late TabController controller;

  @override
  void onInit() {
    controller = TabController(length: tabs.length, vsync: this);
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

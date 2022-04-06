import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/http/dao/ranking_dao.dart';

class DynamicController extends GetxController
    with SingleGetTickerProviderMixin {
  //TODO: Implement DynamicController
  var tabs = [
    {"key": "video", "name": "视频"},
    {"key": "all", "name": "综合"},
  ];
  late TabController controller;

  @override
  void onInit() {
    controller = TabController(length: tabs.length, vsync: this);
    RankingDao.get("likes");
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

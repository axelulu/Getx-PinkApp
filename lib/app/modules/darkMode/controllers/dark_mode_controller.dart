import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DarkModeController extends GetxController {
  //TODO: Implement DarkModeController
  var items = [
    {"name": "跟随系统", "mode": "system"},
    {"name": "夜间模式", "mode": "dark"},
    {"name": "白天模式", "mode": "light"},
  ];

  var currentTheme = "".obs;

  void switchTheme(int index) {
    currentTheme.value = items[index]["mode"] as String;
    GetStorage().write("dark_mode", currentTheme.value);
    Get.changeTheme(
        currentTheme.value == "dark" ? ThemeData.dark() : ThemeData.light());
  }

  @override
  void onInit() {
    currentTheme.value =
        GetStorage().read("dark_mode") == "dark" ? "dark" : "light";
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

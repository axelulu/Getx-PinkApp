import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/util/color.dart';

class IndexController extends GetxController {
  //TODO: Implement IndexController
  final defaultColor = Color.fromRGBO(86, 91, 97, 1);
  final activeColor = primary;
  var currentIndex = 0.obs;
  static int initialPage = 0;
  final PageController controller = PageController(initialPage: initialPage);
  late List<Widget> pages;
  bool hasBuild = false;

  @override
  void onInit() {
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

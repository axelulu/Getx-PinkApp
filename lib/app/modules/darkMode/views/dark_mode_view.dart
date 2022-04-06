import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/app/widget/setting_choose_item.dart';

import '../controllers/dark_mode_controller.dart';

class DarkModeView extends GetView<DarkModeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            _navigatorBar(),
            _content(context),
          ],
        ),
      ),
    );
  }

  Widget _navigatorBar() {
    return NavigationBars(
      height: setHeight(150),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _content(context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.items.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() => SettingChooseItem(
                  onTap: () {
                    controller.switchTheme(index);
                  },
                  flag: controller.currentTheme ==
                      controller.items[index]["mode"],
                  text: controller.items[index]["name"] as String,
                ));
          }),
    );
  }
}

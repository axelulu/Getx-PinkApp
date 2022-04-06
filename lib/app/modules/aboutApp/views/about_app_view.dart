import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/clipboard_tool.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';

import '../controllers/about_app_controller.dart';

class AboutAppView extends GetView<AboutAppController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            _navigationBar(),
            hiSpace(height: setHeight(20)),
            ..._content()
          ],
        ),
      ),
    );
  }

  Widget _navigationBar() {
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

  List<Widget> _content() {
    return [
      settingItemButton(() {
        ClipboardTool.setDataToast(controller.version.value);
      },
          "App版本",
          Obx(() => Text(
                controller.version.value,
                style: TextStyle(fontSize: setSp(38), color: Colors.grey),
              )),
          isShowIcon: false),
      settingItemButton(() {
        ClipboardTool.setDataToast(controller.appName.value);
      },
          "App名称",
          Obx(() => Text(
                controller.appName.value,
                style: TextStyle(fontSize: setSp(38), color: Colors.grey),
              )),
          isShowIcon: false),
      settingItemButton(() {
        ClipboardTool.setDataToast(controller.buildNumber.value);
      },
          "App构建号",
          Obx(() => Text(
                controller.buildNumber.value,
                style: TextStyle(fontSize: setSp(38), color: Colors.grey),
              )),
          isShowIcon: false),
      settingItemButton(() {
        ClipboardTool.setDataToast(controller.packageName.value);
      },
          "App包名",
          Obx(() => Text(
                controller.packageName.value,
                style: TextStyle(fontSize: setSp(38), color: Colors.grey),
              )),
          isShowIcon: false),
    ];
  }
}

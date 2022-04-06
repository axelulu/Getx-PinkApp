import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/loading_container.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/app/widget/pink_tab.dart';
import 'package:pink_acg/app/widget/tab/home_tab_page.dart';
import 'package:pink_acg/app/widget/update.dart';
import 'package:r_upgrade/r_upgrade.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
        body: Container(
      color: Color.fromRGBO(238, 239, 240, 1),
      child: Stack(
        children: [
          Obx(() => LoadingContainer(
                top: setHeight(1000),
                child: Column(
                  children: [_navigatorBar(), _tabBar(), _content()],
                ),
                isLoading: controller.isLoading.value,
              )),
          _updateApp(),
        ],
      ),
    ));
  }

  _tabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100]!,
            offset: Offset(0, 5), //xy轴偏移
            blurRadius: 5.0, //阴影模糊程度
            spreadRadius: 1, //阴影扩散程度
          )
        ],
      ),
      child: PinkTab(
        tabs: controller.categoryList.map<Tab>((tab) {
          return Tab(
            text: tab.categoryName,
          );
        }).toList(),
        controller: controller.controller,
        labelFontSize: setSp(42),
        unselectedFontSize: setSp(42),
        borderWidth: setWidth(8),
        unselectedLabelColor: Color.fromRGBO(96, 101, 106, 1),
        insets: setWidth(10),
      ),
    );
  }

  Widget _navigatorBar() {
    return NavigationBars(
      height: setHeight(180),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: setWidth(45), right: setWidth(45)),
            child: InkWell(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(setRadius(100)),
                child: cachedImage(controller.avatar.value,
                    width: setR(100), height: setR(100)),
              ),
            ),
          ),
          Container(
            height: setHeight(90),
            width: setWidth(490),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(setRadius(90)),
              child: InkWell(
                onTap: () {
                  Get.toNamed("/search");
                },
                child: Container(
                  padding: EdgeInsets.only(left: setWidth(20)),
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.search,
                    color: Color.fromRGBO(182, 186, 191, 1),
                    size: setSp(54),
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(238, 239, 240, 1),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: setWidth(30), left: setWidth(47)),
            child: InkWell(
              onTap: () {
                Get.toNamed("/web-browser",
                    parameters: {"url": "https://baidu.com"});
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(setRadius(86)),
                child: cachedImage(controller.avatar.value,
                    width: setR(86), height: setR(86)),
              ),
            ),
          ),
          appBarButton("assets/icon/message.png", () {}),
          appBarButton("assets/icon/scan.png", () async {
            PermissionStatus status = await Permission.storage.request();
            if (status.isDenied) {
              openAppSettings(); // 没有权限打开设置页面
            }
            Get.toNamed("/scan");
          }),
        ],
      ),
      color: Colors.white,
      statusStyle: StatusStyle.DARK_CONTENT,
    );
  }

  Widget _content() {
    return Flexible(
        child: TabBarView(
      controller: controller.controller,
      children: controller.categoryList.map((tab) {
        return HomeTabPage(
          categoryId: tab.categoryId,
          bannerList: tab.categoryId == 0 ? controller.bannerList : null,
        );
      }).toList(),
    ));
  }

  Widget _updateApp() {
    return Obx(() =>
        (controller.Update.value && GetStorage().read("update_time") == null) ||
                (controller.Update.value &&
                    GetStorage().read("update_time") <
                        DateTime.now().millisecondsSinceEpoch)
            ? Update(
                serverAndroidMsg: controller.serverAndroidMsg,
                serverAndroidVersion: controller.serverAndroidVersion,
                close: () {
                  controller.Update.value = false;
                  GetStorage().write("update_time",
                      DateTime.now().millisecondsSinceEpoch + 86400000);
                },
                update: () async {
                  controller.Update.value = false;
                  await RUpgrade.upgrade(controller.serverAndroidUrl,
                      fileName: 'app-release.apk', isAutoRequestInstall: true);
                },
              )
            : Container());
  }
}

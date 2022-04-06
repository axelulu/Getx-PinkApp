import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_acg/app/modules/contact/views/contact_view.dart';
import 'package:pink_acg/app/modules/dynamic/views/dynamic_view.dart';
import 'package:pink_acg/app/modules/home/views/home_view.dart';
import 'package:pink_acg/app/modules/profile/views/profile_view.dart';
import 'package:pink_acg/app/modules/rank/views/rank_view.dart';
import 'package:pink_acg/app/util/screenutil.dart';

import '../controllers/index_controller.dart';

class IndexView extends GetView<IndexController> {
  @override
  Widget build(BuildContext context) {
    controller.pages = [
      HomeView(),
      RankView(),
      DynamicView(),
      ContactView(),
      ProfileView(),
    ];
    return Scaffold(
      body: PageView(
        controller: controller.controller,
        children: controller.pages,
        onPageChanged: (index) => _onJumpTo(index),
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        height: Platform.isIOS ? setHeight(178) : setHeight(136),
        child: Obx(() => BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: controller.currentIndex.value,
              onTap: (index) => _onJumpTo(index),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: controller.activeColor,
              selectedFontSize: setSp(26),
              unselectedFontSize: setSp(26),
              iconSize: setWidth(66),
              items: [
                _bottomItem("首页", Icons.home, 0),
                _bottomItem("排行", Icons.local_fire_department_outlined, 1),
                _bottomItem("动态", Icons.sports_volleyball_outlined, 2),
                _bottomItem("消息", Icons.notifications_outlined, 3),
                _bottomItem("我的", Icons.account_circle_outlined, 4)
              ],
            )),
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: bottomItemIcon(icon, index, color: controller.defaultColor),
      activeIcon: bottomItemIcon(icon, index, color: controller.activeColor),
      label: title,
    );
  }

  _onJumpTo(int index) {
    controller.controller.jumpToPage(index);
    controller.currentIndex.value = index;
  }

  bottomItemIcon(IconData icon, int index, {color}) {
    return Stack(
      children: [
        Icon(
          icon,
          color: color,
        ),
        Positioned(
          right: 0,
          child: index == 3 &&
                  GetStorage().read("contact_send_id_all") != null &&
                  GetStorage().read("contact_send_id_all") != 0
              ? Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    "${GetStorage().read("contact_send_id_all")}", //通知数量
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: setSp(28),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/app/widget/pink_tab.dart';
import 'package:pink_acg/app/widget/tab/dynamic_tab_page.dart';

import '../controllers/dynamic_controller.dart';

class DynamicView extends GetView<DynamicController> {
  @override
  Widget build(BuildContext context) {
    Get.put(DynamicController());
    return Scaffold(
        body: Container(
      color: Color.fromRGBO(242, 242, 242, 1),
      child: Column(
        children: [
          _navigationBar(),
          _buildTabView(),
        ],
      ),
    ));
  }

  Widget _navigationBar() {
    return NavigationBars(
      height: setHeight(175),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: bottomBoxShadow(),
            child: PinkTab(
              tabs: controller.tabs.map<Tab>((e) {
                return Tab(
                  text: e["name"],
                );
              }).toList(),
              labelFontSize: setSp(46),
              unselectedFontSize: setSp(40),
              borderWidth: setWidth(8),
              unselectedLabelColor: Color.fromRGBO(96, 101, 106, 1),
              controller: controller.controller,
            ),
          ),
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: appBarButton("assets/icon/edit.png", () {
                    Get.toNamed("/publish", arguments: {"type": "dynamic"});
                  }),
                ),
              ],
            ),
            right: setWidth(20),
            bottom: 0,
            top: 0,
          )
        ],
      ),
    );
  }

  Widget _buildTabView() {
    return Flexible(
      child: TabBarView(
        controller: controller.controller,
        children: controller.tabs.map((tab) {
          return DynamicTabPage(slug: tab['key'] as String);
        }).toList(),
      ),
    );
  }
}

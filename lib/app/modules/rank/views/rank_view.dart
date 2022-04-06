import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/app/widget/pink_tab.dart';
import 'package:pink_acg/app/widget/tab/ranking_tab_page.dart';

import '../controllers/rank_controller.dart';

class RankView extends GetView<RankController> {
  @override
  Widget build(BuildContext context) {
    Get.put(RankController());
    return Scaffold(
      body: Column(
        children: [
          _navigationBar(),
          _content(),
        ],
      ),
    );
  }

  _navigationBar() {
    return NavigationBars(
      height: setHeight(175),
      child: Container(
        alignment: Alignment.center,
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
        decoration: bottomBoxShadow(),
      ),
    );
  }

  _content() {
    return Flexible(
      child: TabBarView(
        controller: controller.controller,
        children: controller.tabs.map((tab) {
          return RankingTabPage(sort: tab['key'] as String);
        }).toList(),
      ),
    );
  }
}

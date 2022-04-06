import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/app/widget/tab/await_watch_page.dart';
import 'package:pink_acg/app/widget/tab/user_center_tab_page.dart';

import '../controllers/profile_post_controller.dart';

class ProfilePostView extends GetView<ProfilePostController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color.fromRGBO(242, 242, 242, 1),
      child: Column(
        children: [
          _navigationBar(),
          _content(),
        ],
      ),
    ));
  }

  _navigationBar() {
    return NavigationBars(
      height: setHeight(140),
      child: Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: setWidth(20)),
              child: appBarButton("assets/icon/back.png", () {
                Get.back();
              }),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(
                  right: controller.postType == "await_watch" ||
                          controller.postType == "history_watch"
                      ? setWidth(0)
                      : setWidth(60)),
              alignment: Alignment.center,
              child: Text(controller.title()),
            )),
            controller.postType == "await_watch" ||
                    controller.postType == "history_watch"
                ? Container(
                    margin: EdgeInsets.only(right: setWidth(30)),
                    child: appBarButton("assets/icon/del.png", () {
                      controller.postType == "await_watch"
                          ? GetStorage().write("awaitWatchPost", [])
                          : GetStorage().write("historyWatchPost", []);
                      showToast("删除成功");
                    }),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _content() {
    return Expanded(
      child: controller.postType == "await_watch" ||
              controller.postType == "history_watch"
          ? AwaitWatchTabPage(
              postType: controller.postType,
            )
          : UserCenterTabPage(
              slug: controller.postType,
              userId: controller.userId,
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/follow.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/app/widget/not_found.dart';

import '../controllers/profile_follow_controller.dart';

class ProfileFollowView extends GetView<ProfileFollowController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color.fromRGBO(242, 242, 242, 1),
      child: Column(
        children: [
          _navigationBar(),
          _content(context),
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
              margin: EdgeInsets.only(right: 30),
              alignment: Alignment.center,
              child: Text(controller.followType == "fans" ? "粉丝" : "关注"),
            )),
          ],
        ),
      ),
    );
  }

  _content(context) {
    return Expanded(
      child: Obx(() => RefreshIndicator(
            color: primary,
            onRefresh: controller.loadData,
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: controller.fansListMo.isNotEmpty
                    ? ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: setHeight(30), bottom: setHeight(30)),
                        itemCount: controller.fansListMo.length,
                        controller: controller.scrollController,
                        itemBuilder: (BuildContext context, int index) =>
                            _userMetaItem(controller.fansListMo[index].userMeta,
                                index: index))
                    : ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        itemCount: 1,
                        controller: controller.scrollController,
                        itemBuilder: (BuildContext context, int index) =>
                            NotFound())),
          )),
    );
  }

  _userMetaItem(userMeta, {index}) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(
              top: setWidth(22),
              bottom: setWidth(22),
              right: setWidth(30),
              left: setWidth(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed("/user-center",
                      arguments: {"profileMo": userMeta});
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(setRadius(150)),
                      child: cachedImage(userMeta.avatar,
                          height: setR(150), width: setR(150)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userMeta.username,
                            style: TextStyle(
                                fontSize: setSp(38),
                                color: primary,
                                fontWeight: FontWeight.bold),
                          ),
                          hiSpace(height: setHeight(10)),
                          Text(
                            userMeta.descr != ""
                                ? userMeta.descr
                                : "这个人很懒，什么都没写!",
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              controller.fansListMo[index].isFollow != null
                  ? followBtn(
                      controller.fansListMo[index].isFollow,
                      !controller.fansListMo[index].isFollow
                          ? () {
                              follow(userMeta.userId, () {});
                              controller.fansListMo[index].isFollow =
                                  !controller.fansListMo[index].isFollow;
                            }
                          : () {
                              unFollow(userMeta.userId, () {});
                              controller.fansListMo[index].isFollow =
                                  !controller.fansListMo[index].isFollow;
                            })
                  : Container()
            ],
          ),
        ),
        Divider(
          height: 0.5,
        )
      ],
    );
  }
}

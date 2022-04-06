import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pink_acg/app/data/contact.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/data/upload_mo.dart';
import 'package:pink_acg/app/http/dao/contact_dao.dart';
import 'package:pink_acg/app/http/dao/upload_dao.dart';
import 'package:pink_acg/app/modules/post/views/post_view.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/clipboard_tool.dart';
import 'package:pink_acg/app/util/follow.dart';
import 'package:pink_acg/app/util/image_picker.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/card/user_center_card.dart';
import 'package:pink_acg/app/widget/not_found.dart';
import 'package:pink_acg/app/widget/tab/user_center_tab_page.dart';
import 'package:pink_acg/pink_constants.dart';
import 'package:underline_indicator/underline_indicator.dart';

import 'package:pink_acg/app/util/color.dart';
import '../controllers/user_center_controller.dart';

class UserCenterView extends GetView<UserCenterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: controller.controller,
        headerSliverBuilder: (context, _) {
          return [
            Obx(() => SliverAppBar(
                  primary: true,
                  toolbarHeight: setHeight(200),
                  expandedHeight: GetPlatform.isIOS
                      ? setHeight(219)
                      : setHeight(330) + controller.headerHight,
                  pinned: true,
                  floating: true,
                  snap: false,
                  elevation: 0,
                  shadowColor: Colors.white,
                  backgroundColor: Colors.white,
                  title: controller.showBarColor.value
                      ? Text(
                          controller.profileMo.value.username,
                          style: TextStyle(
                              fontSize: setSp(32), color: Colors.black54),
                        )
                      : Container(),
                  centerTitle: true,
                  flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                      systemNavigationBarColor: Colors.white,
                      statusBarColor: Colors.transparent,
                    ),
                    child: _flexibleSpace(context),
                  ),
                  leading: userCenterIcon(
                      controller.showBarColor.value, Icons.arrow_back, () {
                    Get.back();
                  }),
                  actions: <Widget>[
                    controller.isFollow.value != 2
                        ? userCenterIcon(controller.showBarColor.value,
                            Icons.markunread_outlined, () async {
                            await ContactDao.post(
                                controller.profileMo.value.userId.toString());
                            ContactList sendUserMeta = await ContactDao.getItem(
                                controller.profileMo.value.userId.toString());
                            Get.toNamed("/chat", arguments: {
                              "currentUserMeta": controller.userMeta.value,
                              "sendUserMeta": sendUserMeta
                            });
                          })
                        : Container(),
                    userCenterIcon(controller.showBarColor.value, Icons.search,
                        () {
                      Get.toNamed("/search");
                    }),
                    userCenterIcon(
                        controller.showBarColor.value, Icons.more_horiz, () {
                      showWarnToast("开发中");
                    }),
                  ],
                )),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                child: _tabBar(),
              ),
            ),
          ];
        },
        body: Container(
          color: Color.fromRGBO(240, 240, 240, 1),
          child: TabBarView(
              controller: controller.tabController,
              children: controller.categoryList.map((value) {
                return value["key"] == "main"
                    ? _homePage(context)
                    : Obx(() => UserCenterTabPage(
                        slug: value["key"]!,
                        userId: controller.profileMo.value.userId,
                        refresh: true,
                        tabController: controller.controller));
              }).toList()),
        ),
      ),
    );
  }

  _tabBar() {
    var unselectedLabelColor = Colors.black54;
    return TabBar(
      controller: controller.tabController,
      labelColor: primary,
      unselectedLabelColor: unselectedLabelColor,
      labelStyle: TextStyle(fontSize: setSp(32)),
      indicator: UnderlineIndicator(
          strokeCap: StrokeCap.square,
          borderSide: BorderSide(color: primary, width: 3),
          insets: EdgeInsets.only(left: 15, right: 15)),
      tabs: controller.categoryList.map<Tab>((tab) {
        return Tab(
          text: tab["name"],
        );
      }).toList(),
    );
  }

  _homeTopBar(
      String name, int num, List<PostMo> posts, GestureTapCallback onTap) {
    return Container(
      height: 180,
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$name  $num",
                  style: TextStyle(color: Colors.grey, fontSize: setSp(32)),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: onTap,
                  child: Row(
                    children: [
                      Text(
                        "查看更多",
                        style:
                            TextStyle(color: Colors.grey, fontSize: setSp(32)),
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        color: Colors.grey,
                        size: 18,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            children: posts.map((post) {
              return UserCenterCard(contentModel: post);
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _homePage(context) {
    return RefreshIndicator(
        notificationPredicate: (notifation) {
          // 返回true即可
          return true;
        },
        child: Obx(() => Container(
              padding: EdgeInsets.only(
                  left: setWidth(20), right: setWidth(20), top: setHeight(30)),
              child: controller.userCenterMo.value != null &&
                      (controller.userCenterMo.value.starPostCount != 0 ||
                          controller.userCenterMo.value.coinPostCount != 0 ||
                          controller.userCenterMo.value.likePostCount != 0 ||
                          controller.userCenterMo.value.unLikePostCount != 0 ||
                          controller.userCenterMo.value.postCount != 0 ||
                          controller.userCenterMo.value.videoCount != 0 ||
                          controller.userCenterMo.value.dynamicCount != 0)
                  ? MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          controller.userCenterMo.value.starPostCount != 0
                              ? _homeTopBar(
                                  "收藏",
                                  controller.userCenterMo.value.starPostCount,
                                  controller.userCenterMo.value.starPosts!, () {
                                  moreHandleDialog(
                                      context,
                                      2000,
                                      Container(
                                        color: Colors.white,
                                        child: UserCenterTabPage(
                                          slug: "star",
                                          userId:
                                              controller.profileMo.value.userId,
                                        ),
                                      ));
                                })
                              : Container(),
                          controller.userCenterMo.value.coinPostCount != 0
                              ? _homeTopBar(
                                  "投币",
                                  controller.userCenterMo.value.coinPostCount,
                                  controller.userCenterMo.value.coinPosts!, () {
                                  moreHandleDialog(
                                      context,
                                      2000,
                                      Container(
                                        color: Colors.white,
                                        child: UserCenterTabPage(
                                          slug: "coin",
                                          userId:
                                              controller.profileMo.value.userId,
                                        ),
                                      ));
                                })
                              : Container(),
                          controller.userCenterMo.value.likePostCount != 0
                              ? _homeTopBar(
                                  "喜欢",
                                  controller.userCenterMo.value.likePostCount,
                                  controller.userCenterMo.value.likePosts!, () {
                                  moreHandleDialog(
                                      context,
                                      2000,
                                      Container(
                                        color: Colors.white,
                                        child: UserCenterTabPage(
                                          slug: "like",
                                          userId:
                                              controller.profileMo.value.userId,
                                        ),
                                      ));
                                })
                              : Container(),
                          controller.userCenterMo.value.unLikePostCount != 0
                              ? _homeTopBar(
                                  "讨厌",
                                  controller.userCenterMo.value.unLikePostCount,
                                  controller.userCenterMo.value.unLikePosts!,
                                  () {
                                  moreHandleDialog(
                                      context,
                                      2000,
                                      Container(
                                        color: Colors.white,
                                        child: UserCenterTabPage(
                                          slug: "unlike",
                                          userId:
                                              controller.profileMo.value.userId,
                                        ),
                                      ));
                                })
                              : Container(),
                          controller.userCenterMo.value.dynamicCount != 0
                              ? _homeTopBar(
                                  "动态",
                                  controller.userCenterMo.value.dynamicCount,
                                  controller.userCenterMo.value.dynamics!, () {
                                  controller.tabController.index = 1;
                                })
                              : Container(),
                          controller.userCenterMo.value.videoCount != 0
                              ? _homeTopBar(
                                  "视频",
                                  controller.userCenterMo.value.videoCount,
                                  controller.userCenterMo.value.videos!, () {
                                  controller.tabController.index = 3;
                                })
                              : Container(),
                          controller.userCenterMo.value.postCount != 0
                              ? _homeTopBar(
                                  "文章",
                                  controller.userCenterMo.value.postCount,
                                  controller.userCenterMo.value.posts!, () {
                                  controller.tabController.index = 2;
                                })
                              : Container()
                        ],
                      ))
                  : ListView(children: [NotFound()]),
            )),
        color: primary,
        onRefresh: controller.loadUserCenter);
  }

  _flexibleSpace(context) {
    return FlexibleSpaceBar(
      stretchModes: [StretchMode.zoomBackground, StretchMode.blurBackground],
      collapseMode: CollapseMode.parallax,
      titlePadding: EdgeInsets.only(left: 0),
      background: Column(
        children: [
          Stack(
            children: [
              Container(
                  height: setHeight(403),
                  width: Get.width,
                  color: Colors.grey,
                  child: cachedImage(controller.profileMo.value.background)),
              controller.isFollow.value == 2
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: setHeight(100),
                        width: setWidth(100),
                        margin: EdgeInsets.only(
                            bottom: setHeight(10), right: setWidth(10)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(setRadius(10)),
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                        ),
                        child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.wallpaper_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            List<AssetEntity>? fileList =
                                await getImagePicker(context, maxAssets: 1);
                            File? file = await fileList![0].file;
                            if (file == null) return null;
                            UplaodMo url =
                                await (new UploadDao()).uploadImg(file);
                            controller.profileMo.value.background = url.data;
                            controller.updateInfo("background",
                                controller.profileMo.value.background);
                          },
                        ),
                      ))
                  : Container(),
            ],
          ),
          Container(
            height: controller.headerHight,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Positioned(
                  top: setHeight(-16),
                  child: Container(
                    margin: EdgeInsets.only(left: setWidth(30)),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey[100]!),
                      borderRadius: BorderRadius.circular(75),
                    ),
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed("/photo-dia", parameters: {
                            "image": PinkConstants.ossDomain +
                                "/" +
                                controller.profileMo.value.avatar
                          });
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(75),
                          child: cachedImage(
                            controller.profileMo.value.avatar,
                            height: setR(230),
                            width: setR(230),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            color: Colors.white,
                            width: setWidth(660),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                mySpaceFollow(
                                    "${controller.profileMo.value.active}",
                                    "动态", onTap: () {
                                  Get.toNamed("/profile-post", arguments: {
                                    "postType": "dynamic",
                                    "userId": controller.profileMo.value.userId
                                  });
                                }),
                                longString(),
                                mySpaceFollow(
                                    "${controller.profileMo.value.fans}", "粉丝",
                                    onTap: controller.isFollow.value == 2
                                        ? () {
                                            Get.toNamed("/profile-follow",
                                                arguments: {
                                                  "followType": "fans",
                                                });
                                          }
                                        : () {}),
                                longString(),
                                mySpaceFollow(
                                    "${controller.profileMo.value.follows}",
                                    "关注",
                                    onTap: controller.isFollow.value == 2
                                        ? () {
                                            Get.toNamed("/profile-follow",
                                                arguments: {
                                                  "followType": "follows",
                                                });
                                          }
                                        : () {}),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: controller.isFollow.value == 2
                                ? InkWell(
                                    onTap: () {
                                      Get.toNamed("/user-info", arguments: {
                                        "profileMo": controller.profileMo.value
                                      });
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(top: 2, bottom: 2),
                                      margin: EdgeInsets.only(
                                          top: 5, right: setWidth(30)),
                                      alignment: Alignment.center,
                                      width: setWidth(660),
                                      height: setHeight(80),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              width: 1.5, color: primary)),
                                      child: Text(
                                        "编辑资料",
                                        style: TextStyle(
                                            fontSize: setSp(38),
                                            color: primary),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: controller.isFollow.value == 1
                                        ? () {
                                            unFollow(
                                                controller.profileMo.value
                                                    .userId, () {
                                              controller.isFollow.value = 3;
                                            });
                                          }
                                        : () {
                                            follow(
                                                controller.profileMo.value
                                                    .userId, () {
                                              controller.isFollow.value = 1;
                                            });
                                          },
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(top: 2, bottom: 2),
                                      margin: EdgeInsets.only(
                                          top: 5, right: setWidth(30)),
                                      alignment: Alignment.center,
                                      width: setWidth(660),
                                      height: setHeight(80),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: controller.isFollow.value == 1
                                              ? Colors.white
                                              : primary,
                                          border: Border.all(
                                              width: 1.5,
                                              color:
                                                  controller.isFollow.value == 1
                                                      ? primary
                                                      : Colors.white)),
                                      child: Text(
                                        controller.isFollow.value == 1
                                            ? "已关注"
                                            : "+ 关注",
                                        style: TextStyle(
                                            fontSize: setSp(38),
                                            color:
                                                controller.isFollow.value == 1
                                                    ? primary
                                                    : Colors.white),
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ],
                  ),
                  top: 0,
                  right: 0,
                ),
                Positioned(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: setWidth(40)),
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    controller.profileMo.value.username,
                                    style: TextStyle(
                                      fontSize: setSp(45),
                                      color: primary,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                controller.profileMo.value.isVip == "1"
                                    ? Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(left: 8),
                                        padding: EdgeInsets.only(
                                            bottom: 2, left: 2, right: 2),
                                        decoration: BoxDecoration(
                                            color: primary,
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                        child: Text(
                                          "年度大会员",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          hiSpace(height: 6),
                          Container(
                              width: Get.width,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: setWidth(40)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "LV5",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: setSp(30)),
                                          ),
                                          hiSpace(width: 6),
                                          Text(
                                            "${controller.profileMo.value.exp}/28800",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: setSp(32)),
                                          )
                                        ],
                                      ),
                                      hiSpace(height: 2),
                                      SizedBox(
                                        //限制进度条的高度
                                        height: 2.0,
                                        //限制进度条的宽度
                                        width: 100,
                                        child: LinearProgressIndicator(
                                            //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                                            value:
                                                controller.profileMo.value.exp /
                                                    28800,
                                            //背景颜色
                                            backgroundColor: Colors.grey,
                                            //进度颜色
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.red)),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          controller.showDetail.value =
                                              !controller.showDetail.value;
                                          if (controller.showDetail.value) {
                                            controller.headerHight =
                                                setHeight(550);
                                          } else {
                                            controller.headerHight =
                                                setHeight(420);
                                          }
                                        },
                                        child: Text(
                                          controller.showDetail.value
                                              ? "收起"
                                              : "详情",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.blue),
                                        ),
                                      ))
                                ],
                              )),
                          controller.showDetail.value
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 6,
                                          bottom: 6,
                                          left: setWidth(40)),
                                      child: Text(
                                        controller.profileMo.value.descr == ""
                                            ? "这个人很懒，什么都没写..."
                                            : controller.profileMo.value.descr,
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: setWidth(40)),
                                          child: Icon(
                                            controller.profileMo.value.gender ==
                                                    0
                                                ? Icons.male_outlined
                                                : Icons.female_outlined,
                                            color: controller.profileMo.value
                                                        .gender ==
                                                    0
                                                ? Colors.blue
                                                : primary,
                                            size: 12,
                                          ),
                                          padding: EdgeInsets.only(
                                              top: 2,
                                              right: 2,
                                              bottom: 2,
                                              left: 2),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  239, 239, 232, 1),
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 8),
                                          child: InkWell(
                                            child: Text(
                                              "uid:${controller.profileMo.value.userId}",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 10,
                                              ),
                                            ),
                                            onLongPress: () {
                                              ClipboardTool.setDataToast(
                                                  '${controller.profileMo.value.userId}');
                                            },
                                          ),
                                          padding: EdgeInsets.only(
                                              top: 2,
                                              right: 2,
                                              bottom: 2,
                                              left: 2),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  239, 239, 232, 1),
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      hiSpace(height: 8),
                    ],
                  ),
                  top: setHeight(245),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/follow.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/share_card.dart';
import 'package:pink_acg/app/widget/tab/comment_tab_page.dart';
import 'package:pink_acg/app/widget/video_header.dart';
import 'package:pink_acg/pink_constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:underline_indicator/underline_indicator.dart';

import '../controllers/post_controller.dart';

class PostView extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        RefreshIndicator(
            notificationPredicate: (notifation) {
              // 返回true即可
              return true;
            },
            color: primary,
            child: Container(
              color: Color.fromRGBO(242, 242, 242, 1),
              child: NestedScrollView(
                controller: controller.controller,
                headerSliverBuilder: (context, _) {
                  return [
                    _sliverAppBar(context),
                    _sliverList(),
                    _sliverPersistentHeader(),
                  ];
                },
                body:
                    TabBarView(controller: controller.tabController, children: [
                  Obx(() => CommentTabPage(
                        postId: controller.contentModel.value.postId,
                        content: "${controller.random.value}",
                        refresh: false,
                      )),
                  Container(
                    color: Colors.white,
                    child: Text("暂无"),
                  ),
                ]),
              ),
            ),
            onRefresh: controller.loadDetail),
        _publishComment(context)
      ],
    ));
  }

  Widget _sliverAppBar(context) {
    return SliverAppBar(
      toolbarHeight: setHeight(200),
      expandedHeight: setHeight(548),
      backgroundColor: primary,
      pinned: true,
      floating: false,
      snap: false,
      elevation: 0,
      shadowColor: Colors.white,
      centerTitle: true,
      title: Obx(() => controller.showBarColor.value
          ? Text(
              controller.contentModel.value.title,
              style: TextStyle(color: Colors.white, fontSize: setSp(50)),
            )
          : Container()),
      flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.transparent,
        ),
        child: FlexibleSpaceBar(
          stretchModes: [
            StretchMode.zoomBackground,
            StretchMode.blurBackground
          ],
          collapseMode: CollapseMode.parallax,
          titlePadding: EdgeInsets.only(left: 0),
          background: Container(
              height: setHeight(548),
              width: Get.width,
              color: Colors.grey,
              child:
                  Obx(() => cachedImage(controller.contentModel.value.cover))),
        ),
      ),
      leading: Obx(() =>
          userCenterIcon(controller.showBarColor.value, Icons.arrow_back, () {
            Get.back();
          })),
      actions: <Widget>[
        Obx(() =>
            userCenterIcon(controller.showBarColor.value, Icons.more_horiz, () {
              moreHandleDialog(context, 720,
                  ShareCard(postMo: controller.contentModel.value));
            })),
      ],
    );
  }

  Widget _sliverList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(bottom: setHeight(20)),
          color: Colors.white,
          child: Column(
            children: [
              Obx(() => controller.contentModel.value.postType == "post"
                  ? Container(
                      padding: EdgeInsets.only(
                        top: setHeight(54),
                        bottom: setHeight(10),
                        left: setWidth(45),
                        right: setWidth(45),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        controller.contentModel.value.title,
                        style: TextStyle(
                            height: 1.2,
                            fontSize: setSp(65),
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  : Container()),
              Container(
                margin: EdgeInsets.only(
                    left: setWidth(20),
                    right: setWidth(20),
                    top: setHeight(40),
                    bottom: setHeight(0)),
                child: Obx(() => VideoHeader(
                      userMeta: controller.contentModel.value.userMeta,
                      time: controller.contentModel.value.createTime,
                      isFollow: controller.contentDetailModel.value.isFollow,
                      isSelf: controller.contentDetailModel.value.isSelf,
                      onFollow: controller.contentDetailModel.value.isFollow
                          ? () {
                              unFollow(
                                  controller
                                      .contentModel.value.userMeta!.userId, () {
                                controller.contentDetailModel.update((val) {
                                  val!.isFollow = false;
                                });
                              });
                            }
                          : () {
                              follow(
                                  controller
                                      .contentModel.value.userMeta!.userId, () {
                                controller.contentDetailModel.update((val) {
                                  val!.isFollow = true;
                                });
                              });
                            },
                    )),
              ),
              Obx(() => controller.contentModel.value.postType == "post"
                  ? Container(
                      padding: EdgeInsets.only(
                        top: setHeight(35),
                        bottom: 10,
                        left: setWidth(35),
                        right: setWidth(35),
                      ),
                      child: Html(
                          data: controller.contentModel.value.content,
                          onImageTap: (String? url,
                              RenderContext context,
                              Map<String, String> attributes,
                              dom.Element? element) {
                            Get.toNamed("/photo-dia",
                                parameters: {"image": url!});
                          }),
                    )
                  : Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      child: Text(controller.contentModel.value.content),
                    )),
              Container(
                padding: EdgeInsets.only(
                  top: setHeight(35),
                  left: setWidth(35),
                  right: setWidth(35),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RepaintBoundary(
                          key: controller.repaintKey,
                          child: Container(
                            height: setHeight(240),
                            width: setWidth(240),
                            color: Colors.white,
                            child: Obx(() => QrImage(
                                  data: jsonEncode(controller.qrContent),
                                  version: QrVersions.auto,
                                  size: 320,
                                  gapless: false,
                                  embeddedImage: NetworkImage(
                                      PinkConstants.ossDomain +
                                          '/' +
                                          controller.contentModel.value.cover),
                                  embeddedImageStyle: QrEmbeddedImageStyle(
                                    size: Size(10, 10),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: setWidth(35),
                    right: setWidth(35),
                    top: setHeight(20),
                    bottom: setHeight(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                          "${controller.contentModel.value.view}阅读",
                          style: TextStyle(
                              color: Colors.grey, fontSize: setSp(32)),
                        )),
                    Text(
                      "文本禁止转载",
                      style: TextStyle(color: Colors.grey, fontSize: setSp(32)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      childCount: 1,
    ));
  }

  Widget _sliverPersistentHeader() {
    var unselectedLabelColor = Colors.black54;
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyTabBarDelegate(
        child: TabBar(
          controller: controller.tabController,
          labelColor: primary,
          isScrollable: true,
          unselectedLabelColor: unselectedLabelColor,
          labelStyle: TextStyle(fontSize: setSp(38)),
          indicator: UnderlineIndicator(
              strokeCap: StrokeCap.square,
              borderSide: BorderSide(color: primary, width: setHeight(6)),
              insets: EdgeInsets.only(left: setWidth(40), right: setWidth(40))),
          tabs: controller.categoryList.map<Tab>((tab) {
            return Tab(
              text: tab,
            );
          }).toList(),
        ),
      ),
    );
  }

  void showCommentDialog() {
    Get.bottomSheet(Container(
      child: Column(
        children: [
          //空白区域点击关闭
          Expanded(
              child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              color: Colors.transparent,
            ),
          )),
          Container(
            color: Colors.white,
            child: Row(
              children: [hiSpace(width: 15), _buildInput(), _buildSendBtn()],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildInput() {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(26)),
      child: TextField(
        autofocus: true,
        controller: controller.textEditingController,
        onSubmitted: (value) {
          controller.send(value);
        },
        cursorColor: primary,
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
          hintText: "发送一条评论!",
        ),
      ),
    ));
  }

  Widget _buildSendBtn() {
    return InkWell(
      onTap: () {
        var text = controller.textEditingController.text.isNotEmpty
            ? controller.textEditingController.text.trim()
            : "";
        controller.send(text);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.send_rounded,
          color: primary,
        ),
      ),
    );
  }

  Widget _publishComment(context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: setHeight(114),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                height: setHeight(86),
                width: setWidth(300),
                margin:
                    EdgeInsets.only(left: setWidth(40), right: setWidth(40)),
                child: InkWell(
                  onTap: () {
                    showCommentDialog();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          hiSpace(width: 5),
                          Text(
                            "发送一条友善的消息",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(color: Colors.grey[100]),
                    ),
                  ),
                ),
              )),
              Container(
                padding: EdgeInsets.only(right: 12, left: 12),
                child: InkWell(
                  onTap: () {
                    showCommentDialog();
                  },
                  child: Image.asset(
                    "assets/icon/comment.png",
                    width: setWidth(60),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(right: 12, left: 12),
                  child: Obx(() => InkWell(
                        onTap: () {
                          onFavorite(
                              controller.contentDetailModel.value.isFavorite,
                              controller.contentModel.value.postId, () {
                            if (controller
                                .contentDetailModel.value.isFavorite) {
                              controller.contentDetailModel.update((val) {
                                val!.isFavorite = false;
                              });
                              if (controller.contentModel.value.favorite >= 1) {
                                controller.contentModel.update((val) {
                                  val!.favorite -= 1;
                                });
                              }
                              showToast("取消收藏成功!");
                            } else {
                              controller.contentDetailModel.update((val) {
                                val!.isFavorite = true;
                              });
                              if (controller.contentModel.value.favorite >= 0) {
                                controller.contentModel.update((val) {
                                  val!.favorite += 1;
                                });
                              }
                              showToast("收藏成功!");
                            }
                          });
                        },
                        child: Icon(
                          Icons.star_border_outlined,
                          size: 22,
                          color: controller.contentDetailModel.value.isFavorite
                              ? primary
                              : Color.fromRGBO(117, 117, 117, 1),
                        ),
                      ))),
              Container(
                  padding: EdgeInsets.only(right: 12, left: 12),
                  child: InkWell(
                    onTap: () {
                      moreHandleDialog(
                          context,
                          720,
                          Obx(() => ShareCard(
                              postMo: controller.contentModel.value)));
                    },
                    child: Image.asset(
                      "assets/icon/share.png",
                      width: setWidth(55),
                    ),
                  )),
              Container(
                  padding: EdgeInsets.only(right: 12, left: 12),
                  child: Obx(() => InkWell(
                        onTap: () {
                          doLike(controller.contentModel.value.postId, () {
                            controller.contentDetailModel.update((val) {
                              val!.isLike = true;
                            });
                            controller.contentDetailModel.update((val) {
                              val!.isUnLike = false;
                            });
                            if (controller.contentModel.value.likes >= 0) {
                              controller.contentModel.update((val) {
                                val!.likes += 1;
                              });
                            }
                            if (controller.contentModel.value.un_likes >= 1) {
                              controller.contentModel.update((val) {
                                val!.un_likes -= 1;
                              });
                            }
                          });
                        },
                        child: Image.asset(
                          "assets/icon/star.png",
                          width: setWidth(55),
                          color: controller.contentDetailModel.value.isLike
                              ? primary
                              : Color.fromRGBO(117, 117, 117, 1),
                        ),
                      )))
            ],
          ),
        ));
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Color.fromRGBO(244, 244, 244, 1),
                  ),
                  bottom: BorderSide(
                    width: 1,
                    color: Color.fromRGBO(244, 244, 244, 1),
                  ))),
          width: Get.width,
          height: 40,
          child: child,
        ),
      ],
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

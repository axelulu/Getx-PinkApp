import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/format_util.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/pink_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    controller.color = Colors.white;
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: controller.loadData,
      color: primary,
      child: ListView(
        children: [_navigatorBar(), _content(context)],
      ),
    ));
  }

  Widget _navigatorBar() {
    return NavigationBars(
      height: setHeight(160),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          appBarButton("assets/icon/dark_mode_1.png", () {
            Get.toNamed("/dark-mode");
          }),
          Container(
            margin: EdgeInsets.only(right: setWidth(20)),
            child: appBarButton("assets/icon/theme.png", () {}),
          ),
        ],
      ),
    );
  }

  Widget _content(context) {
    return Container(
      color: controller.color,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: setWidth(32),
                right: setWidth(32),
                top: setHeight(20),
                bottom: setHeight(20)),
            child: InkWell(
              onTap: () {
                Get.toNamed("/user-center",
                    arguments: {"profileMo": controller.profileMo.value});
              },
              child: Obx(() => controller.profileMo.value != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(setRadius(170)),
                              child: cachedImage(
                                  controller.profileMo.value.avatar,
                                  width: setR(170),
                                  height: setR(170))),
                        ),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: setWidth(30)),
                                  child: Text(
                                    "${controller.profileMo.value.username}",
                                    style: TextStyle(
                                        color:
                                            controller.profileMo.value.isVip ==
                                                    "1"
                                                ? primary
                                                : Colors.black,
                                        fontSize: setSp(45),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                hiSpace(width: 2),
                                Icon(
                                  Icons.male_outlined,
                                  size: 14,
                                  color: Colors.blue,
                                ),
                                hiSpace(width: 2),
                                Text(
                                  "LV5",
                                  style: TextStyle(
                                      fontSize: setSp(28),
                                      color: Colors.red,
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            ),
                            controller.profileMo.value.isVip == "1"
                                ? Container(
                                    margin: EdgeInsets.only(
                                        left: setWidth(30), top: setHeight(10)),
                                    padding: EdgeInsets.only(
                                        left: 2, right: 2, top: 0, bottom: 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: primary,
                                    ),
                                    child: Text(
                                      "年度大会员",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: setSp(30)),
                                    ),
                                  )
                                : Container(),
                            Container(
                              margin: EdgeInsets.only(
                                  left: setWidth(30), top: setHeight(10)),
                              child: Text(
                                "B币：${controller.profileMo.value.coin}    硬币：${controller.profileMo.value.coin}",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: setSp(32)),
                              ),
                            ),
                          ],
                        )),
                        Text(
                          "空间",
                          style: TextStyle(
                              fontSize: setSp(32), color: Colors.grey),
                        ),
                        Container(
                          child: Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.grey,
                            size: setSp(80),
                          ),
                        )
                      ],
                    )
                  : Container()),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: setHeight(45), bottom: setHeight(45)),
            child: Obx(() => controller.profileMo.value != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      mySpaceFollow(
                          controller.profileMo.value.active.toString(), "动态",
                          onTap: () {
                        Get.toNamed("/profile-post", arguments: {
                          "postType": "dynamic",
                          "userId": controller.profileMo.value.userId
                        });
                      }),
                      longString(),
                      mySpaceFollow(
                          controller.profileMo.value.fans.toString(), "粉丝",
                          onTap: () {
                        Get.toNamed("/profile-follow", arguments: {
                          "followType": "fans",
                        });
                      }),
                      longString(),
                      mySpaceFollow(
                          controller.profileMo.value.follows.toString(), "关注",
                          onTap: () {
                        Get.toNamed("/profile-follow", arguments: {
                          "followType": "follows",
                        });
                      }),
                    ],
                  )
                : Container()),
          ),
          _myServer(),
          _creationCenter(context),
          _moreServer()
        ],
      ),
    );
  }

  Widget _creationCenter(context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(
                top: 20, left: setWidth(30), right: setWidth(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "创作中心",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: setSp(40)),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                      onTap: () {
                        moreHandleDialog(
                            context,
                            2248,
                            Container(
                              color: Color.fromRGBO(242, 242, 242, 1),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 30,
                                    left: 5,
                                    right: 5,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: Get.width / 2 - 21,
                                              margin: EdgeInsets.all(8),
                                              child: publishButton("发布文章",
                                                  Icons.post_add_outlined, () {
                                                Get.back();
                                                Get.toNamed("/publish",
                                                    arguments: {
                                                      "type": "post"
                                                    });
                                              }, isSpace: true),
                                            ),
                                            Container(
                                              width: Get.width / 2 - 21,
                                              margin: EdgeInsets.all(8),
                                              child: publishButton(
                                                  "发布视频", Icons.movie_outlined,
                                                  () {
                                                Get.back();
                                                Get.toNamed("/publish",
                                                    arguments: {
                                                      "type": "video"
                                                    });
                                              }, isSpace: true),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: Get.width / 3 - 19.33,
                                              margin: EdgeInsets.all(8),
                                              child: publishButton("写动态",
                                                  Icons.dynamic_feed_outlined,
                                                  () {
                                                Get.back();
                                                Get.toNamed("/publish",
                                                    arguments: {
                                                      "type": "dynamic"
                                                    });
                                              }),
                                            ),
                                            Container(
                                              width: Get.width / 3 - 19.33,
                                              margin: EdgeInsets.all(8),
                                              child: publishButton("发音乐",
                                                  Icons.music_note_outlined,
                                                  () {
                                                showWarnToast("开发中");
                                              }),
                                            ),
                                            Container(
                                              width: Get.width / 3 - 19.34,
                                              margin: EdgeInsets.all(8),
                                              child: publishButton("发剧集",
                                                  Icons.video_call_outlined,
                                                  () {
                                                Get.back();
                                                Get.toNamed("/publish",
                                                    arguments: {
                                                      "type": "collection"
                                                    });
                                              }),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      top: 30,
                                      left: 10,
                                      child: TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Icon(Icons.close_outlined),
                                        style: ButtonStyle(
                                          //定义文本的样式 这里设置的颜色是不起作用的
                                          textStyle: MaterialStateProperty.all(
                                              TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white)),
                                          //设置按钮上字体与图标的颜色
                                          //foregroundColor: MaterialStateProperty.all(Colors.deepPurple),
                                          //更优美的方式来设置
                                          foregroundColor:
                                              MaterialStateProperty.resolveWith(
                                            (states) {
                                              if (states.contains(
                                                      MaterialState.focused) &&
                                                  !states.contains(
                                                      MaterialState.pressed)) {
                                                //获取焦点时的颜色
                                                return Colors.grey[400];
                                              } else if (states.contains(
                                                  MaterialState.pressed)) {
                                                //按下时的颜色
                                                return Colors.grey[400];
                                              }
                                              //默认状态使用灰色
                                              return Colors.grey[400];
                                            },
                                          ),
                                          //背景颜色
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) {
                                            //设置按下时的背景颜色
                                            if (states.contains(
                                                MaterialState.pressed)) {
                                              return Colors.grey[300];
                                            }
                                            //默认不使用背景颜色
                                            return Colors.grey[300];
                                          }),
                                          //设置水波纹颜色
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.grey[300]),
                                          //设置阴影  不适用于这里的TextButton
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          //设置按钮内边距
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.all(4)),
                                          //设置按钮的大小
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(20, 20)),

                                          //外边框装饰 会覆盖 side 配置的样式
                                          shape: MaterialStateProperty.all(
                                              StadiumBorder()),
                                        ),
                                      ))
                                ],
                              ),
                            ));
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: setHeight(15),
                              bottom: setHeight(15),
                              left: setWidth(40),
                              right: setWidth(40)),
                          color: primary,
                          child: Row(
                            children: [
                              Icon(
                                Icons.file_upload,
                                color: Colors.white,
                                size: setSp(50),
                              ),
                              Text(
                                "发布",
                                style: TextStyle(
                                    fontSize: setSp(35),
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                            ],
                          ))),
                )
              ],
            )),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconText(Icons.article_outlined, "稿件管理",
                  onClick: () {}, tint: true),
              _buildIconText(Icons.people_alt_outlined, "我的粉丝", onClick: () {
                Get.toNamed("/profile-follow", arguments: {
                  "followType": "fans",
                });
              }, tint: true),
              _buildIconText(Icons.supervised_user_circle, "我的关注", onClick: () {
                Get.toNamed("/profile-follow", arguments: {
                  "followType": "follows",
                });
              }, tint: true),
              _buildIconText(Icons.star_border_outlined, "我的收藏", onClick: () {
                Get.toNamed("/profile-post", arguments: {
                  "postType": "star",
                  "userId": controller.profileMo.value.userId
                });
              }, tint: true),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconText(Icons.thumb_up_alt_outlined, "我的喜欢", onClick: () {
                Get.toNamed("/profile-post", arguments: {
                  "postType": "like",
                  "userId": controller.profileMo.value.userId
                });
              }, tint: true),
              _buildIconText(Icons.thumb_down_alt_outlined, "我的讨厌",
                  onClick: () {
                Get.toNamed("/profile-post", arguments: {
                  "postType": "unlike",
                  "userId": controller.profileMo.value.userId
                });
              }, tint: true),
              _buildIconText(Icons.monetization_on_outlined, "我的投币",
                  onClick: () {
                Get.toNamed("/profile-post", arguments: {
                  "postType": "coin",
                  "userId": controller.profileMo.value.userId
                });
              }, tint: true),
              _buildIconText(Icons.drive_file_move_outline, "我的视频",
                  onClick: () {
                Get.toNamed("/profile-post", arguments: {
                  "postType": "video",
                  "userId": controller.profileMo.value.userId
                });
              }, tint: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _myServer() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText(Icons.cloud_download_outlined, "离线缓存",
              onClick: () {}, tint: false),
          _buildIconText(Icons.restore_outlined, "历史记录", onClick: () {
            Get.toNamed("/profile-post", arguments: {
              "postType": "history_watch",
              "userId": controller.profileMo.value.userId
            });
          }, tint: false),
          _buildIconText(Icons.star_outline, "我的收藏", onClick: () {
            Get.toNamed("/profile-post", arguments: {
              "postType": "star",
              "userId": controller.profileMo.value.userId
            });
          }, tint: false),
          _buildIconText(Icons.watch_later_outlined, "稍后再看", onClick: () {
            Get.toNamed("/profile-post", arguments: {
              "postType": "await_watch",
              "userId": controller.profileMo.value.userId
            });
          }, tint: false),
        ],
      ),
    );
  }

  Widget _moreServer() {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(
                top: 20, left: setWidth(30), right: setWidth(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "更多服务",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: setSp(40)),
                ),
              ],
            )),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              _bottomMenu("提交bug或建议", Icons.support_agent_outlined, () async {
                // android 和 ios 的 QQ 启动 url scheme 是不同的
                var url;
                if (Platform.isAndroid) {
                  url =
                      'mqqwpa://im/chat?chat_type=wpa&uin=${PinkConstants.qq}';
                } else {
                  url =
                      'mqq://im/chat?chat_type=wpa&uin=${PinkConstants.qq}&version=1&src_type=web';
                }
                // 确认一下url是否可启动
                if (await canLaunch(url)) {
                  await launch(url); // 启动QQ
                } else {
                  // 自己封装的一个 Toast
                  showWarnToast('无法启动QQ');
                }
              }),
              _bottomMenu("设置", Icons.settings_outlined, () {
                Get.toNamed("/setting");
              })
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconText(IconData iconData, text, {onClick, bool tint = false}) {
    if (text is int) {
      text = countFormat(text);
    } else {
      text ??= "";
    }
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Icon(
            iconData,
            size: setSp(80),
            color: tint ? primary : Color.fromRGBO(71, 156, 220, 1),
          ),
          hiSpace(height: setHeight(10)),
          Text(
            text,
            style: TextStyle(color: Colors.grey, fontSize: setSp(32)),
          )
        ],
      ),
    );
  }

  Widget _bottomMenu(String text, IconData icon, GestureTapCallback onTap) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              size: 26,
              color: primary,
            ),
            hiSpace(width: 10),
            Expanded(child: Text(text)),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

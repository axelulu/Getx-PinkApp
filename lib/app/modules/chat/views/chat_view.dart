import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pink_acg/app/data/upload_mo.dart';
import 'package:pink_acg/app/http/dao/upload_dao.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/clipboard_tool.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/emoji.dart';
import 'package:pink_acg/app/util/image_picker.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/app/widget/pink_tab.dart';
import 'package:pink_acg/pink_constants.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildNavigationBar(),
          Expanded(
            child: _buildTabView(context),
          )
        ],
      ),
    );
  }

  _appBar() {
    return Container(
      decoration: bottomBoxShadow(),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: setWidth(20)),
            child: appBarButton("assets/icon/back.png", () {
              Get.back();
            }),
          ),
          hiSpace(width: 15),
          Expanded(child: Text(controller.sendUserMeta.sendUserMeta!.username)),
          Container(
            margin: EdgeInsets.only(right: setWidth(20)),
            child: appBarButton("assets/icon/user.png", () {
              Get.toNamed("/user-center", arguments: {
                "profileMo": controller.sendUserMeta.sendUserMeta,
              });
            }),
          ),
        ],
      ),
    );
  }

  _buildNavigationBar() {
    return NavigationBars(
      height: setHeight(150),
      child: _appBar(),
    );
  }

  _buildTabView(context) {
    return Container(
      color: Color.fromRGBO(242, 242, 242, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: MediaQuery.removePadding(
                removeTop: true,
                removeBottom: true,
                context: context,
                child: Obx(() => ListView(
                      reverse: true,
                      controller: controller.controller,
                      children: [
                        controller.dataList.length > 0
                            ? _chatList(context)
                            : Container(
                                child: Text(
                                  "发个消息聊聊呗!",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: setSp(40)),
                                ),
                                padding: EdgeInsets.only(bottom: setHeight(50)),
                                alignment: Alignment.center,
                              )
                      ],
                    ))),
          ),
          _bottomSendBar(context),
          Obx(() => controller.showEmoji.value
              ? Container(
                  height: setHeight(800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          color: Color.fromRGBO(242, 242, 242, 1),
                          child: TabBarView(
                            controller: controller.tabController,
                            children: controller.categoryList.map((tab) {
                              return Container(
                                padding: EdgeInsets.only(
                                  left: setWidth(36),
                                  right: setWidth(36),
                                ),
                                child: MediaQuery.removePadding(
                                  removeTop: true,
                                  context: context,
                                  child: EmojiExpression(
                                    (e) {
                                      controller.msg.value += "[${e.name}]";
                                    },
                                    crossAxisCount: 7,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Container(
                          width: setWidth(1080),
                          height: setHeight(120),
                          padding: EdgeInsets.only(
                              left: setWidth(10), right: setWidth(10)),
                          color: Colors.white,
                          child: EmojiTab(
                            tabs: controller.categoryList.map<Tab>((tab) {
                              return Tab(
                                icon: Icon(tab),
                              );
                            }).toList(),
                            controller: controller.tabController,
                          ))
                    ],
                  ),
                )
              : Container())
        ],
      ),
    );
  }

  _chatAvatar(bool isSelf) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              offset: Offset(5, 5), //xy轴偏移
              blurRadius: 5.0, //阴影模糊程度
              spreadRadius: 1, //阴影扩散程度
            )
          ],
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(35)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: InkWell(
          onTap: () {
            Get.toNamed("/user-center", arguments: {
              "profileMo": isSelf
                  ? controller.currentUserMeta
                  : controller.sendUserMeta.sendUserMeta,
            });
          },
          child: cachedImage(
              isSelf
                  ? controller.currentUserMeta.avatar
                  : controller.sendUserMeta.sendUserMeta!.avatar,
              width: 35,
              height: 35),
        ),
      ),
    );
  }

  _chatBubble(context, value) {
    return InkWell(
      onLongPress: () {
        ClipboardTool.setDataToast(value.content);
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                offset: Offset(5, 5), //xy轴偏移
                blurRadius: 5.0, //阴影模糊程度
                spreadRadius: 1, //阴影扩散程度
              )
            ],
            color: value.userId == controller.currentUserMeta.userId
                ? Color.fromRGBO(235, 249, 255, 1)
                : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                  value.userId == controller.currentUserMeta.userId ? 20 : 0),
              topRight: Radius.circular(
                  value.userId == controller.currentUserMeta.userId ? 0 : 20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            )),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: setWidth(700),
            // minWidth: double.infinity, // //宽度尽可能大
          ),
          child: Column(
            children: [
              ExpressionText(value.content, TextStyle(color: Colors.black)),
              if (value.media == 4)
                Container(
                  child: InkWell(
                      onTap: () {
                        Get.toNamed("/photo-dia", parameters: {
                          "image": PinkConstants.ossDomain + "/" + value.pic
                        });
                      },
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: setWidth(400), minHeight: setHeight(100)
                            // minWidth: double.infinity, // //宽度尽可能大
                            ),
                        child: Image.network(
                          PinkConstants.ossDomain + "/" + value.pic,
                          width: setWidth(400),
                        ),
                      )),
                )
            ],
          ),
        ),
      ),
    );
  }

  _chatList(context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: controller.dataList.map((value) {
          return Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Row(
              children: [
                value.userId == controller.currentUserMeta.userId
                    ? Container()
                    : _chatAvatar(
                        value.userId == controller.currentUserMeta.userId),
                Expanded(
                    child: Row(
                  mainAxisAlignment:
                      value.userId == controller.currentUserMeta.userId
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment:
                          value.userId == controller.currentUserMeta.userId
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                      crossAxisAlignment:
                          value.userId == controller.currentUserMeta.userId
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Text(
                            value.userId == controller.currentUserMeta.userId
                                ? "${controller.currentUserMeta.username}"
                                : "${controller.sendUserMeta.sendUserMeta!.username}",
                            style: TextStyle(
                                fontSize: setSp(32), color: Colors.grey),
                          ),
                        ),
                        _chatBubble(context, value)
                      ],
                    )
                  ],
                )),
                value.userId == controller.currentUserMeta.userId
                    ? _chatAvatar(
                        value.userId == controller.currentUserMeta.userId)
                    : Container(),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  _bottomSendBar(context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          appBarButton("assets/icon/pic.png", () async {
            List<AssetEntity>? fileList =
                await getImagePicker(context, maxAssets: 9);
            for (var i = 0; i < fileList!.length; i++) {
              File? file = await fileList[i].file;
              if (file == null) return null;
              var uploadDao = UploadDao();
              UplaodMo url = await uploadDao.uploadImg(file);
              controller.sendMsg(controller.msg.value, pic: url.data, media: 4);
            }
          }),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: setWidth(20), right: setWidth(90)),
                    height: 32,
                    alignment: Alignment.center,
                    child: Obx(() => TextField(
                          onTap: () {
                            controller.showEmoji.value = false;
                          },
                          onSubmitted: (value) {
                            controller.sendMsg(controller.msg.value);
                          },
                          onChanged: (value) {
                            controller.emoji.value = value;
                          },
                          keyboardType: TextInputType.text,
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text: controller.msg.value, //判断keyword是否为空
                                  // 保持光标在最后

                                  selection: TextSelection.fromPosition(
                                      TextPosition(
                                          affinity: TextAffinity.downstream,
                                          offset:
                                              controller.msg.value.length)))),
                          decoration: InputDecoration(
                              hintText: "发个消息聊聊呗!",
                              hintStyle: TextStyle(fontSize: setSp(36)),
                              isCollapsed: true,
                              //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              //内容内边距，影响高度

                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        )),
                    decoration: BoxDecoration(color: Colors.grey[100]),
                  ),
                  Positioned(
                    right: 0,
                    bottom: setHeight(20),
                    child: appBarButton("assets/icon/emoji.png", () {
                      controller.msg.value = controller.emoji.value;
                      if (MediaQuery.of(context).viewInsets.bottom > 0) {
                        Future.delayed(Duration(seconds: 0), () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      }
                      Future.delayed(Duration(seconds: 0), () {
                        controller.showEmoji.value =
                            !controller.showEmoji.value;
                      });
                    }),
                  )
                ],
              ),
            ),
          )),
          InkWell(
            onTap: () {
              controller.msg.value = controller.emoji.value;
              controller.sendMsg(controller.msg.value);
              controller.emoji.value = "";
            },
            child: Padding(
              padding: EdgeInsets.only(left: setWidth(10), right: setWidth(0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding:
                      EdgeInsets.only(left: setWidth(20), right: setWidth(20)),
                  height: 32,
                  alignment: Alignment.center,
                  child: Text(
                    "发送",
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(color: primary),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

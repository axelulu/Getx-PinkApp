import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_acg/app/http/dao/contact_dao.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/contact.dart';
import 'package:pink_acg/app/util/emoji.dart';
import 'package:pink_acg/app/util/format_util.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/getx_dialog_button.dart';
import 'package:pink_acg/app/widget/getx_dialog_input.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/app/widget/not_found.dart';
import 'package:vibration/vibration.dart';

import '../controllers/contact_controller.dart';

class ContactView extends GetView<ContactController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ContactController());
    return Scaffold(
      body: Material(
        color: Color.fromRGBO(242, 242, 242, 1),
        child: Column(
          children: [
            _navigationBar(),
            _headerMenu(),
            hiSpace(height: 10),
            ..._content(context),
          ],
        ),
      ),
    );
  }

  _navigationBar() {
    return NavigationBars(
      height: setHeight(200),
      child: Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            hiSpace(width: setWidth(20)),
            appBarButton("assets/icon/add.png", () async {
              Get.defaultDialog(
                  title: "添加对话",
                  radius: setRadius(40),
                  cancel: GetxDialogButton(
                    text: "取消",
                    onTap: () {
                      Get.back();
                    },
                    flag: true,
                  ),
                  confirm: GetxDialogButton(
                    text: "确定",
                    onTap: () async {
                      if (controller.uidController.text.isEmpty) {
                        showWarnToast("请输入uid");
                        return;
                      }
                      var result =
                          await ContactDao.post(controller.uidController.text);
                      if (result["code"] == 1000) {
                        controller.loadData();
                        showToast("添加成功!");
                      } else {
                        showWarnToast(result['msg']);
                        Get.back();
                      }
                    },
                    flag: false,
                  ),
                  content: GetxDialogInput(
                    controller: controller.uidController,
                  ));
            }),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Text(
                "消息",
                style:
                    TextStyle(fontSize: setSp(42), fontWeight: FontWeight.w600),
              ),
            )),
            Container(
              margin: EdgeInsets.only(right: setWidth(20)),
              child: appBarButton("assets/icon/user.png", () {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerMenu() {
    return Row(
      children: [
        headerTextButton(
            "回复我的", "assets/icon/msg.png", Color.fromRGBO(62, 211, 159, 1)),
        headerTextButton("@我", "assets/icon/aite.png", Colors.yellow),
        headerTextButton("收到的赞", "assets/icon/re_star.png", Colors.red),
        headerTextButton(
            "系统通知", "assets/icon/noti.png", Color.fromRGBO(66, 200, 229, 1)),
      ],
    );
  }

  List<Widget> _content(context) {
    return [
      Container(
        width: Get.width,
        color: Colors.white,
        padding: EdgeInsets.only(
            top: setHeight(15), left: setWidth(25), bottom: setHeight(15)),
        child: Text(
          "聊天列表",
          style: TextStyle(fontSize: setSp(40), fontWeight: FontWeight.w500),
        ),
      ),
      Divider(
        color: Color.fromRGBO(242, 242, 242, 1),
        height: 1,
      ),
      Expanded(
        child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Obx(() => RefreshIndicator(
                color: primary,
                child: _contactLists(),
                onRefresh: controller.loadData))),
      )
    ];
  }

  Widget _contactLists() {
    return controller.contactList.value.list != null &&
            controller.contactList.value.list!.isNotEmpty
        ? Container(
            color: Colors.white,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              children: controller.contactList.value.list!.map((contactMeta) {
                return _contactItem(contactMeta);
              }).toList(),
            ),
          )
        : ListView(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [NotFound()],
          );
  }

  Widget _getNoReadMsg(int sendId) {
    return GetStorage().read("contact_send_id_$sendId") != null &&
            GetStorage().read("contact_send_id_$sendId") != 0
        ? Container(
            child: Text(
              GetStorage().read("contact_send_id_$sendId") != null &&
                      GetStorage().read("contact_send_id_$sendId") != 0
                  ? "${GetStorage().read("contact_send_id_$sendId")}"
                  : "",
              style: TextStyle(color: Colors.white, fontSize: setSp(28)),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40), color: Colors.red),
            padding: EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
            margin: EdgeInsets.only(top: 5),
          )
        : Container();
  }

  Widget _contactItem(contactMeta) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onLongPress: () async {
          //检查是否支持振动
          bool? hasVi = await Vibration.hasVibrator();
          if (hasVi!) {
            Vibration.vibrate(duration: 10);
          }
        },
        onTap: () {
          Get.toNamed("/chat", arguments: {
            "currentUserMeta": controller.userMeta,
            "sendUserMeta": contactMeta
          });
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: setHeight(28),
                bottom: setHeight(24),
                left: setWidth(26),
                right: setWidth(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: setWidth(40)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(setRadius(130)),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(setRadius(130)),
                      child: cachedImage(contactMeta.sendUserMeta!.avatar,
                          width: setR(130), height: setR(130)),
                    ),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              contactMeta.sendUserMeta!.username,
                              style: TextStyle(
                                  fontSize: setSp(40),
                                  color: primary,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          hiSpace(height: setHeight(15)),
                          Container(
                            child: contactMeta.chatMo!.media == 1
                                ? ExpressionText(contactMeta.chatMo!.content,
                                    TextStyle(color: Colors.black))
                                : contactMeta.chatMo!.media == 0 &&
                                        contactMeta.chatMo!.userId == 0 &&
                                        contactMeta.chatMo!.sendId == 0
                                    ? Text(
                                        "暂无消息",
                                        style: TextStyle(
                                            fontSize: setSp(35),
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      )
                                    : Text(
                                        "[图片]",
                                        style: TextStyle(
                                            fontSize: setSp(35),
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            formatDate(DateTime.parse(
                                contactMeta.updateTime.substring(0, 19))),
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                          _getNoReadMsg(contactMeta.sendUserMeta!.userId),
                        ],
                      ),
                    ],
                  )),
                ],
              ),
            ),
            Divider(
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}

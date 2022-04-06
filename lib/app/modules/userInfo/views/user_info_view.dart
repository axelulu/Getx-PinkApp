import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pink_acg/app/data/upload_mo.dart';
import 'package:pink_acg/app/http/dao/upload_dao.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/clipboard_tool.dart';
import 'package:pink_acg/app/util/image_picker.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../controllers/user_info_controller.dart';

class UserInfoView extends GetView<UserInfoController> {
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
      height: setHeight(150),
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
              child: Text("账号资料"),
            )),
          ],
        ),
      ),
    );
  }

  _content(context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Divider(
              height: 0.5,
            ),
            settingItemButton(
              () async {
                var type =
                    await showModalActionSheet(context: context, actions: [
                  SheetAction(label: "从相册选择", key: 0),
                  SheetAction(label: "拍照选择", key: 1),
                ]);
                File? file;
                if (type == 0) {
                  List<AssetEntity>? fileList =
                      await getImagePicker(context, maxAssets: 1);
                  file = await fileList![0].file;
                } else if (type == 1) {
                  AssetEntity? fileList = await getImageCamera(context);
                  file = await fileList!.file;
                }
                if (file == null) return;
                UplaodMo url = await (UploadDao()).uploadImg(file);
                controller.profileMo.update((val) {
                  val!.avatar = url.data;
                });
                controller.updateInfo(
                    "avatar", controller.profileMo.value.avatar);
              },
              "头像",
              Obx(() => ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: cachedImage(controller.profileMo.value.avatar,
                        width: 60, height: 60),
                  )),
            ),
            settingItemButton(
              () {
                Get.toNamed("/user-username",
                    arguments: {"profileMo": controller.profileMo.value});
              },
              "昵称",
              Obx(() => Text(
                    controller.profileMo.value.username,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )),
            ),
            settingItemButton(
              () async {
                var text = (await showModalActionSheet(
                    context: context,
                    actions: [
                      SheetAction(label: "男", key: 0),
                      SheetAction(label: "女", key: 1)
                    ]))!;
                controller.profileMo.update((val) {
                  val!.gender = text;
                });
                controller.updateInfo(
                    "gender", controller.profileMo.value.gender.toString());
              },
              "性别",
              Obx(() => Text(
                    controller.profileMo.value.gender == 0 ? "男" : "女",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )),
            ),
            settingItemButton(
              () async {
                var text = await showDatePicker(
                    cancelText: "关闭",
                    confirmText: "确定",
                    context: context,
                    initialDate: DateTime(
                        int.parse(
                            controller.profileMo.value.birth.substring(0, 4)),
                        int.parse(
                            controller.profileMo.value.birth.substring(5, 7)),
                        int.parse(
                            controller.profileMo.value.birth.substring(8, 10))),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
                if (text != null) {
                  controller.profileMo.update((val) {
                    val!.birth = text.toString();
                  });
                  controller.updateInfo(
                      "birth", controller.profileMo.value.birth);
                }
              },
              "出生年月",
              Obx(() => Text(
                    controller.profileMo.value.birth.substring(0, 10),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )),
            ),
            settingItemButton(
              () {
                Get.toNamed("/user-desc",
                    arguments: {"profileMo": controller.profileMo.value});
              },
              "个性签名",
              Obx(() => Text(
                    controller.profileMo.value.descr == ""
                        ? "介绍一下自己吧!"
                        : controller.profileMo.value.descr,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )),
            ),
            settingItemButton(() {
              Get.toNamed("/user-pwd",
                  arguments: {"profileMo": controller.profileMo.value});
            }, "修改密码", Container()),
            settingItemButton(() {
              Get.toNamed("/user-email",
                  arguments: {"profileMo": controller.profileMo.value});
            }, "修改邮箱", Container()),
            hiSpace(height: 10),
            Divider(
              height: 0.5,
            ),
            settingItemButton(() {
              ClipboardTool.setDataToast(
                  controller.profileMo.value.userId.toString());
            },
                "UID",
                Text(
                  "${controller.profileMo.value.userId}",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                isShowIcon: false),
            settingItemButton(() {
              Get.toNamed("/user-qrcode",
                  arguments: {"profileMo": controller.profileMo.value});
            }, "二维码名片", Container()),
            settingItemButton(() {
              showToast("正在开发中");
            }, "购买邀请码", Container()),
          ],
        ),
      ),
    );
  }
}

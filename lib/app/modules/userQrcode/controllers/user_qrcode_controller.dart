import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pink_acg/app/data/user_center_mo.dart';
import 'package:pink_acg/app/util/toast.dart';

class UserQrcodeController extends GetxController {
  //TODO: Implement UserQrcodeController
  GlobalKey repaintKey = GlobalKey();
  late Map<String, dynamic> qrContent = new Map<String, dynamic>();
  var profileMo = UserMeta().obs;

  Future getPerm() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    var status = await Permission.storage.status;
    if (status.isDenied) {
      openAppSettings(); // 没有权限打开设置页面
    } else {
      capturePng(); // 已有权限开始保存
    }
  }

  Future<String?> capturePng() async {
    try {
      RenderRepaintBoundary? boundary = repaintKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final result =
          await ImageGallerySaver.saveImage(byteData!.buffer.asUint8List());
      showToast("保存成功");
    } catch (e) {
      showToast("保存失败");
    }
    return null;
  }

  @override
  void onInit() {
    profileMo.value = (Get.arguments as Map)["profileMo"];
    qrContent["type"] = "user_center";
    qrContent["id"] = profileMo.value.userId.toString();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

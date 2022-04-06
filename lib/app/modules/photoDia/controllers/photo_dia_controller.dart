import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pink_acg/app/util/toast.dart';

class PhotoDiaController extends GetxController {
  //TODO: Implement PhotoDiaController
  var image = "".obs;

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
      File file = await DefaultCacheManager().getSingleFile(image.value);
      await ImageGallerySaver.saveImage(file.readAsBytesSync());
      showToast("保存成功");
    } catch (e) {
      showToast("保存失败");
    }
    return null;
  }

  @override
  void onInit() {
    image.value = Get.parameters["image"]!;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

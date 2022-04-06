import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/user_center_mo.dart';
import 'package:pink_acg/app/data/video_detail_mo.dart';
import 'package:pink_acg/app/http/dao/user_center_dao.dart';
import 'package:pink_acg/app/http/dao/video_detail_dao.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_net/core/pink_error.dart';
import 'package:scan/scan.dart' as ScanCard;

class ScanController extends GetxController {
  //TODO: Implement ScanController
  late StateSetter stateSetter;
  IconData lightIcon = Icons.flash_on;
  var controller = ScanCard.ScanController();

  Future<UserMeta?> getUserMeta(String qrContent) async {
    var res = jsonDecode(qrContent);
    if (res["type"] == "user_center") {
      try {
        UserMeta result = await UserCenterDao.getUserMeta(res["id"]);
        Get.back();
        Get.toNamed("/user-center", arguments: {"profileMo": result});
      } on NeedLogin catch (e) {
        showWarnToast(e.message);
      } on NeedAuth catch (e) {
        showWarnToast(e.message);
      }
    } else if (res["type"] == "post") {
      try {
        VideoDetailMo result = await VideoDetailDao.get(res["id"]);
        Get.back();
        result.postInfo!.postType == "video"
            ? Get.toNamed("/user-center",
                arguments: {"profileMo": result.postInfo!})
            : Get.toNamed("/user-center",
                arguments: {"profileMo": result.postInfo!});
      } on NeedLogin catch (e) {
        showWarnToast(e.message);
      } on NeedAuth catch (e) {
        showWarnToast(e.message);
      }
    } else {
      showWarnToast("请使用本app的二维码");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

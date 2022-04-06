import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/user_center_mo.dart';
import 'package:pink_acg/app/http/dao/profile_dao.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_net/core/pink_error.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final profileMo = UserMeta().obs;
  Color color = Colors.white;

  Future<void> loadData() async {
    try {
      UserMeta result = await ProfileDao.get();
      profileMo.value = result;
    } on NeedAuth catch (e) {
      showToast(e.message);
    } on NeedLogin catch (e) {
      showToast(e.message);
    } on PinkNetError catch (e) {
      showToast(e.message);
    }
  }

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

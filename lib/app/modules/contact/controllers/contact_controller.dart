import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/contact.dart';
import 'package:pink_acg/app/data/user_center_mo.dart';
import 'package:pink_acg/app/http/dao/contact_dao.dart';
import 'package:pink_acg/app/http/dao/profile_dao.dart';
import 'package:pink_acg/app/modules/controller/websocket_controller.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_net/core/pink_error.dart';

class ContactController extends GetxController
    with SingleGetTickerProviderMixin {
  final _websocket = Get.put(WebsocketController());
  //TODO: Implement ContactController
  var tabs = [
    {"key": "likes", "name": "消息"},
    {"key": "update_time", "name": "通知"},
  ];
  late TabController controller;
  late UserMeta? userMeta;
  final contactList = ContactMo().obs;
  TextEditingController uidController = TextEditingController();

  Future<void> loadData() async {
    try {
      ContactMo result = await ContactDao.get();
      contactList.value = result;
    } on NeedAuth catch (e) {
      showToast(e.message);
    } on NeedLogin catch (e) {
      showToast(e.message);
    } on PinkNetError catch (e) {
      showToast(e.message);
    }
  }

  userAvatar() async {
    try {
      UserMeta result = await ProfileDao.get();
      userMeta = result;
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
    controller = TabController(length: tabs.length, vsync: this);
    _websocket.listen((value) {});
    loadData();
    userAvatar();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    controller.dispose();
  }
}

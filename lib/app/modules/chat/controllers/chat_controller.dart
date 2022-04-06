import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_acg/app/data/chat_mo.dart';
import 'package:pink_acg/app/data/contact.dart';
import 'package:pink_acg/app/data/user_center_mo.dart';
import 'package:pink_acg/app/http/dao/chat_dao.dart';
import 'package:pink_acg/app/modules/controller/websocket_controller.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_net/core/pink_error.dart';

class ChatController extends GetxController with SingleGetTickerProviderMixin {
  final _websocket = Get.put(WebsocketController());

  //TODO: Implement ChatController
  var msg = "".obs;
  var emoji = "".obs;
  var dataList = <ChatMo>[].obs;
  ScrollController controller = ScrollController();
  int page = 1;
  bool loading = false;
  var showEmoji = false.obs;
  List categoryList = [Icons.emoji_emotions, Icons.star];
  late TabController tabController;
  List emojiList = [];
  late UserMeta currentUserMeta;
  late ContactList sendUserMeta;

  void sendMsg(String message, {String pic = "", int media = 1}) {
    if ((message == null || message == "") && pic == "") {
      showWarnToast("请输入内容！");
      return;
    }
    _websocket.send(
        message, pic, currentUserMeta.userId, sendUserMeta.sendId, media);
    Map<String, dynamic> msgs = {
      "cmd": 10,
      "send_id": sendUserMeta.sendId,
      "user_id": currentUserMeta.userId,
      "content": message,
      "pic": pic,
      "media": media,
    };
    dataList.add(ChatMo.fromJson(msgs));
    msg.value = "";
  }

  void _loadData() async {
    try {
      loading = true;
      ChatList result = await ChatDao.get(sendUserMeta.sendUserMeta!.userId,
          page: page, size: 10);
      dataList.value = [...result.list.reversed, ...dataList];
      if (result.list.length != 0) {
        page++;
      }
      Future.delayed(Duration(milliseconds: 500), () {
        loading = false;
      });
    } on NeedAuth catch (e) {
      loading = false;
      showToast(e.message);
    } on NeedLogin catch (e) {
      loading = false;
      showToast(e.message);
    } on PinkNetError catch (e) {
      loading = false;
      showToast(e.message);
    }
  }

  @override
  void onInit() {
    currentUserMeta = (Get.arguments as Map)["currentUserMeta"];
    sendUserMeta = (Get.arguments as Map)["sendUserMeta"];
    _loadData();

    for (var i = 0; i < 58; i++) {
      emojiList.add(i + 1);
    }

    var num = GetStorage()
                .read("contact_send_id_${sendUserMeta.sendUserMeta!.userId}") !=
            null
        ? GetStorage()
            .read("contact_send_id_${sendUserMeta.sendUserMeta!.userId}")
        : 0;
    var numAll = GetStorage().read("contact_send_id_all") != null
        ? GetStorage().read("contact_send_id_all")
        : 0;
    GetStorage().write("contact_send_id_all", numAll - num);
    GetStorage()
        .write("contact_send_id_${sendUserMeta.sendUserMeta!.userId}", 0);
    //先在启动时初始化
    _websocket.listen((value) {
      if (value.userId == sendUserMeta.sendUserMeta!.userId) {
        dataList.add(value);
        GetStorage()
            .write("contact_send_id_${sendUserMeta.sendUserMeta!.userId}", 0);
      }
    });
    tabController = TabController(length: categoryList.length, vsync: this);
    controller.addListener(() {
      if (showEmoji.value) {
        showEmoji.value = !showEmoji.value;
      }
      // if (MediaQuery.of(context).viewInsets.bottom > 0) {
      //   FocusScope.of(context).requestFocus(new FocusNode());
      // }
      //最大高度减去当前高度
      var dis =
          controller.position.maxScrollExtent - controller.position.pixels;
      //距离不足300时加载更多
      if (dis < 300 && !loading && controller.position.maxScrollExtent != 0) {
        _loadData();
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    controller.dispose();
    tabController.dispose();
  }
}

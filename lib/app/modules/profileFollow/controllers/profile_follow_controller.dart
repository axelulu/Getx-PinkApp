import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/follow_list_mo.dart';
import 'package:pink_acg/app/http/dao/follow_list_dao.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_net/core/pink_error.dart';

class ProfileFollowController extends GetxController {
  //TODO: Implement ProfileFollowController
  var fansListMo = <FansList>[].obs;
  ScrollController scrollController = ScrollController();
  var pageIndex = 1.obs;
  var loading = false.obs;
  late String followType;

  Future<void> loadData({loadMore = false}) async {
    if (!loadMore) {
      pageIndex.value = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      loading.value = true;
      FansListMo result;
      if (followType == "fans") {
        result = await FollowListDao.fansList(currentIndex.value);
      } else {
        result = await FollowListDao.followList(currentIndex.value);
      }
      if (loadMore) {
        fansListMo.value = [...fansListMo, ...result.list];
      } else {
        fansListMo.value = result.list;
      }
      Future.delayed(Duration(milliseconds: 500), () {
        loading.value = false;
      });
    } on NeedLogin catch (e) {
      loading.value = false;
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      loading.value = false;
      showWarnToast(e.message);
    }
  }

  @override
  void onInit() {
    followType = (Get.arguments as Map)["followType"];
    loadData();
    scrollController.addListener(() {
      //最大高度减去当前高度
      var dis = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      //距离不足300时加载更多
      if (dis < 300 &&
          !loading.value &&
          scrollController.position.maxScrollExtent != 0) {
        loadData(loadMore: true);
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
    scrollController.dispose();
  }
}

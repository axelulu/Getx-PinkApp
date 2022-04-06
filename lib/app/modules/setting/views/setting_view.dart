import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/pink_constants.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            _navigatorBar(),
            hiSpace(height: setHeight(20)),
            _content(context),
            hiSpace(height: setHeight(20)),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _navigatorBar() {
    return NavigationBars(
      height: setHeight(150),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _content(context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.items.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Divider(
                  height: 0.2,
                ),
                Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(controller.items[index]["type"] as String);
                    },
                    child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 40, top: 15, bottom: 15),
                        child: Text(controller.items[index]["name"] as String)),
                  ),
                ),
                Divider(
                  height: 0.2,
                ),
              ],
            );
          }),
    );
  }

  Widget _footer() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: 0.4, color: Color.fromRGBO(236, 236, 236, 1)),
              bottom: BorderSide(
                  width: 0.4, color: Color.fromRGBO(236, 236, 236, 1)))),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            GetStorage().remove(PinkConstants.authorization);
            showToast("退出登录成功!");
            // 登出用户账号
            Future.delayed(Duration(milliseconds: 1000), () {
              Get.toNamed("/login");
            });
          },
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "退出登录",
                style: TextStyle(color: Colors.red),
              )),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/http/dao/user_update_dao.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/app/widget/user_textarea.dart';
import 'package:pink_net/core/pink_error.dart';

import '../controllers/user_desc_controller.dart';

class UserDescView extends GetView<UserDescController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color.fromRGBO(242, 242, 242, 1),
      child: Column(
        children: [
          _navigationBar(),
          _content(),
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
              alignment: Alignment.center,
              child: Text(
                "个性签名",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            )),
            InkWell(
                onTap: () async {
                  try {
                    var result = await UserUpdateDao.update(
                        "descr", controller.profileMo.value.descr);
                    if (result["code"] == 1000) {
                      showToast("修改成功");
                      Get.back();
                    } else {
                      showToast("修改失败");
                    }
                  } on NeedLogin catch (e) {
                    showWarnToast(e.message);
                  } on NeedAuth catch (e) {
                    showWarnToast(e.message);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Text(
                    "保存",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  _content() {
    return UserTextarea(
        controller: TextEditingController.fromValue(TextEditingValue(
            text: controller.profileMo.value.descr, //判断keyword是否为空
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: controller.profileMo.value.descr.length)))),
        onChanged: (value) {
          controller.profileMo.value.descr = value;
        },
        size: 60);
  }
}

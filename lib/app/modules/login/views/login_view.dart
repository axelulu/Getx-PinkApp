import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/widget/login/login_button.dart';
import 'package:pink_acg/app/widget/login/login_effect.dart';
import 'package:pink_acg/app/widget/login/login_input.dart';

import '../../../widget/appbar.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("密码登录", "注册", () {
        Get.toNamed("/reg");
      }),
      body: Container(
        child: ListView(
          children: [
            Obx(() => LoginEffect(protect: controller.protect.value)),
            LoginInput(
              title: "邮箱",
              hint: "请输入邮箱",
              autofocus: false,
              onChanged: (text) {
                controller.email = text;
                controller.checkInput();
              },
            ),
            LoginInput(
              isForgetPassword: true,
              title: "密码",
              hint: "请输入密码",
              obscureText: true,
              onChanged: (text) {
                controller.password = text;
                controller.checkInput();
              },
              focusChanged: (text) {
                controller.protect.value = text;
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Obx(() => LoginButton(
                    "登录",
                    enable: controller.loginEnable.value,
                    onPressed: controller.send,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

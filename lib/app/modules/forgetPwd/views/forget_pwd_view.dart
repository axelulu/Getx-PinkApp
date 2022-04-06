import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/modules/forgetPwd/controllers/forget_pwd_controller.dart';
import 'package:pink_acg/app/widget/email_input.dart';
import 'package:pink_acg/app/widget/login/login_button.dart';
import 'package:pink_acg/app/widget/login/login_effect.dart';
import 'package:pink_acg/app/widget/login/login_input.dart';

import '../../../widget/appbar.dart';

class ForgetPwdView extends GetView<ForgetPwdController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("找回密码", "登录", () {
        Get.offAllNamed("/login");
      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: controller.protect.value),
            Obx(() => EmailInput(
                title: "邮箱",
                hint: "请输入邮箱",
                email: controller.email.value,
                autofocus: false,
                onChanged: (text) {
                  controller.email.value = text;
                  controller.checkInput();
                },
                sendRegEmail: controller.sendForgetPwdEmail,
                focusChanged: (text) {})),
            LoginInput(
                title: "验证码",
                hint: "请输入验证码",
                onChanged: (text) {
                  controller.validateCode = text;
                  controller.checkInput();
                },
                focusChanged: (text) {}),
            LoginInput(
                title: "密码",
                hint: "请输入密码",
                obscureText: true,
                onChanged: (text) {
                  controller.password = text;
                  controller.checkInput();
                },
                focusChanged: (text) {
                  controller.protect.value = text;
                }),
            LoginInput(
                title: "确认密码",
                hint: "请再次输入密码",
                obscureText: true,
                onChanged: (text) {
                  controller.rePassword = text;
                  controller.checkInput();
                },
                focusChanged: (text) {
                  controller.protect.value = text;
                }),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Obx(() => LoginButton(
                    "修改密码",
                    enable: controller.loginEnable.value,
                    onPressed: controller.checkParams,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

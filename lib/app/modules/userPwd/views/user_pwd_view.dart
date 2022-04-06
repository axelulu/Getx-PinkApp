import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/email_input.dart';
import 'package:pink_acg/app/widget/login/login_button.dart';
import 'package:pink_acg/app/widget/login/login_input.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';

import '../controllers/user_pwd_controller.dart';

class UserPwdView extends GetView<UserPwdController> {
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
                "修改密码",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            )),
            hiSpace(width: setWidth(100))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(242, 242, 242, 1),
        child: Column(
          children: [
            _navigationBar(),
            _content(context),
          ],
        ),
      ),
    );
  }

  Widget _content(context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: setHeight(20)),
      color: Colors.white,
      child: MediaQuery.removePadding(
          removeTop: true,
          removeBottom: true,
          context: context,
          child: Obx(() => ListView(
                children: [
                  EmailInput(
                      title: "验证码",
                      hint: "请输入验证码",
                      email: controller.profileMo.value.email,
                      onChanged: (text) {
                        controller.validateCode = text;
                        controller.checkInput();
                      },
                      sendRegEmail: controller.sendForgetPwdEmail,
                      focusChanged: (text) {}),
                  LoginInput(
                      title: "旧密码",
                      hint: "请输入旧密码",
                      obscureText: true,
                      onChanged: (text) {
                        controller.oldPassword = text;
                        controller.checkInput();
                      },
                      focusChanged: (text) {
                        controller.protect.value = text;
                      }),
                  LoginInput(
                      title: "新密码",
                      hint: "请输入新密码",
                      obscureText: true,
                      onChanged: (text) {
                        controller.newPassword = text;
                        controller.checkInput();
                      },
                      focusChanged: (text) {
                        controller.protect.value = text;
                      }),
                  LoginInput(
                      title: "确认新密码",
                      hint: "请再次输入新密码",
                      obscureText: true,
                      onChanged: (text) {
                        controller.reNewPassword = text;
                        controller.checkInput();
                      },
                      focusChanged: (text) {
                        controller.protect.value = text;
                      }),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Obx(() => LoginButton(
                          "修改",
                          enable: controller.loginEnable.value,
                          onPressed: controller.checkParams,
                        )),
                  )
                ],
              ))),
    ));
  }
}

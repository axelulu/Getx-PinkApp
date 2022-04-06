import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/email_input.dart';
import 'package:pink_acg/app/widget/login/login_button.dart';
import 'package:pink_acg/app/widget/login/login_input.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';

import '../controllers/user_email_controller.dart';

class UserEmailView extends GetView<UserEmailController> {
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
                "修改邮箱",
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
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: setWidth(50),
                        right: setWidth(50),
                        top: setHeight(40),
                        bottom: setHeight(40)),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            right: setWidth(180),
                          ),
                          child: Text("老邮箱"),
                        ),
                        Text(controller.profileMo.value.email)
                      ],
                    ),
                  ),
                  Obx(() => EmailInput(
                      title: "新邮箱",
                      hint: "请输入新邮箱",
                      email: controller.newEmail.value,
                      autofocus: false,
                      onChanged: (text) {
                        controller.newEmail.value = text;
                        controller.checkInput();
                      },
                      sendRegEmail: controller.sendForgetEmail,
                      focusChanged: (text) {})),
                  LoginInput(
                      title: "验证码",
                      hint: "请输入验证码",
                      onChanged: (text) {
                        controller.validateCode = text;
                        controller.checkInput();
                      },
                      focusChanged: (text) {}),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Obx(() => LoginButton(
                          "修改",
                          enable: controller.loginEnable.value,
                          onPressed: controller.checkParams,
                        )),
                  )
                ],
              ),
            )));
  }
}

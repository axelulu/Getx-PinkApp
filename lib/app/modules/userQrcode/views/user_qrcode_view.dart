import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/getx_dialog_button.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/pink_constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/user_qrcode_controller.dart';

class UserQrcodeView extends GetView<UserQrcodeController> {
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
                "我的二维码",
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
          children: [_navigationBar(), ..._content()],
        ),
      ),
    );
  }

  List<Widget> _content() {
    return [
      Container(
        margin: EdgeInsets.only(top: setHeight(400), bottom: setHeight(200)),
        child: RepaintBoundary(
          key: controller.repaintKey,
          child: Container(
            height: setHeight(700),
            width: setWidth(650),
            color: Colors.white,
            child: QrImage(
              data: jsonEncode(controller.qrContent),
              version: QrVersions.auto,
              size: setHeight(500),
              gapless: false,
              embeddedImage: NetworkImage(PinkConstants.ossDomain +
                  '/' +
                  controller.profileMo.value.avatar),
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: Size(30, 30),
              ),
            ),
          ),
        ),
      ),
      GetxDialogButton(
          text: "保存二维码",
          onTap: () async {
            await controller.getPerm();
          },
          flag: false)
    ];
  }
}

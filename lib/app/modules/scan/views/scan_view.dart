import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/image_picker.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:scan/scan.dart' as ScanCard;
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../controllers/scan_controller.dart';

class ScanView extends GetView<ScanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        ScanCard.ScanView(
          controller: controller.controller,
          scanAreaScale: 1,
          scanLineColor: primary,
          onCapture: (data) {
            controller.getUserMeta(data);
          },
        ),
        ..._navigatorBar(),
        ..._content(context),
      ]),
    );
  }

  List<Widget> _navigatorBar() {
    return [
      Positioned(
        left: setWidth(-50),
        top: setHeight(100),
        child: MaterialButton(
            child: Icon(
              Icons.arrow_back_ios,
              size: setSp(60),
              color: primary,
            ),
            onPressed: () {
              Get.back();
            }),
      ),
      Positioned(
          left: setWidth(450),
          top: setHeight(140),
          child: Text(
            "扫描二维码",
            style: TextStyle(color: Colors.white),
          ))
    ];
  }

  List<Widget> _content(context) {
    return [
      _scanButton(() {
        controller.controller.toggleTorchMode();
        if (controller.lightIcon == Icons.flash_on) {
          controller.lightIcon = Icons.flash_off;
        } else {
          controller.lightIcon = Icons.flash_on;
        }
      }, controller.lightIcon, false),
      _scanButton(() async {
        List<AssetEntity>? fileList =
            await getImagePicker(context, maxAssets: 1);
        File? file = await fileList![0].file;
        String? result = await ScanCard.Scan.parse(file!.path);
        if (result == null) {
          showToast("请扫描正确的二维码");
          return;
        }
        controller.getUserMeta(result);
      }, Icons.image, true),
    ];
  }

  Widget _scanButton(onPressed, icon, flag) {
    return Positioned(
      left: flag ? null : setWidth(140),
      right: flag ? setWidth(140) : null,
      bottom: setHeight(100),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
              height: setHeight(175),
              width: setWidth(175),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(75, 73, 78, .4),
                  borderRadius: BorderRadius.circular(setRadius(100))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(setRadius(100)),
                child: MaterialButton(
                    child: Icon(
                      icon,
                      size: setSp(80),
                      color: primary,
                    ),
                    onPressed: onPressed),
              ));
        },
      ),
    );
  }
}

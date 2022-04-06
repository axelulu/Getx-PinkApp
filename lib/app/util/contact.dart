import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:vibration/vibration.dart';

/// 即时通讯设置未读消息红点
void noReadMsg(value) async {
  int num;
  if (GetStorage().read("contact_send_id_${value.userId}") != null &&
      GetStorage().read("contact_send_id_${value.userId}") != 0) {
    num = GetStorage().read("contact_send_id_${value.userId}");
  } else {
    num = 0;
  }
  var numAll = GetStorage().read("contact_send_id_all") ?? 0;
  GetStorage().write("contact_send_id_${value.userId}", num + 1);
  GetStorage().write("contact_send_id_all", numAll + 1);
  //检查是否支持振动
  bool? hasVi = await Vibration.hasVibrator();
  if (hasVi!) {
    Vibration.vibrate(duration: 200);
  }
}

/// contact顶部按钮
Widget headerTextButton(String text, String icon, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.only(top: setHeight(32), bottom: setHeight(32)),
      color: Colors.white,
      child: Column(
        children: [
          Image.asset(
            icon,
            width: setWidth(90),
            height: setHeight(90),
          ),
          hiSpace(height: setHeight(20)),
          Text(
            text,
            style: TextStyle(fontSize: setSp(32), color: Colors.grey),
          )
        ],
      ),
    ),
  );
}

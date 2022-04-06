import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

setScreenInit() {
  //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
  ScreenUtil.init(BoxConstraints(maxWidth: Get.width, maxHeight: Get.height),
      designSize: Size(1080, 2248), orientation: Orientation.portrait);
}

setWidth(int width) {
  return width.w;
}

setHeight(int height) {
  return height.h;
}

setR(int height) {
  return height.r;
}

setRadius(int radius) {
  return ScreenUtil().radius(radius);
}

setSp(int sp) {
  return sp.sp;
}

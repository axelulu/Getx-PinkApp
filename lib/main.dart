import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_acg/app/util/pink_defend.dart';
import 'package:pink_acg/pink_constants.dart';

import 'app/routes/app_pages.dart';
import 'app/util/color.dart';
import 'app/util/screenutil.dart';

/// 初始化APP
Future<void> initApp() async {
  // 初始化存储
  await GetStorage.init();
  // 系统bar
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Get.isDarkMode ? Colors.black : Colors.white,
      systemNavigationBarDividerColor:
          Get.isDarkMode ? Colors.black : Colors.white,
      systemNavigationBarIconBrightness:
          Get.isDarkMode ? Brightness.light : Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
  setScreenInit();
}

/// 启动APP
void main() async {
  await initApp();
  PinkDefend().run(GetMaterialApp(
    theme: themeData(),
    themeMode: GetStorage().read("dark_mode") == "dark"
        ? ThemeMode.dark
        : GetStorage().read("dark_mode") == "light"
            ? ThemeMode.light
            : ThemeMode.system,
    debugShowCheckedModeBanner: false,
    color: primary,
    title: "PinkAcg",
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
  ));

  // 腾讯日志
  FlutterBugly.init(
      androidAppId: PinkConstants.buglyAndroidId,
      iOSAppId: PinkConstants.buglyIosId);
}

/// 主题配置
ThemeData themeData() {
  return ThemeData(
    fontFamily: 'PinkApp',
    brightness: GetStorage().read("dark_mode") == "dark"
        ? Brightness.dark
        : Brightness.light,
    errorColor: GetStorage().read("dark_mode") == "dark"
        ? HiColor.dark_red
        : HiColor.red,
    primaryColor:
        GetStorage().read("dark_mode") == "dark" ? HiColor.dark_bg : white,
    accentColor: GetStorage().read("dark_mode") == "dark" ? primary[50] : white,
    // Tab指示器的颜色
    indicatorColor:
        GetStorage().read("dark_mode") == "dark" ? primary[50] : white,
    // 页面背景色
    scaffoldBackgroundColor:
        GetStorage().read("dark_mode") == "dark" ? HiColor.dark_bg : white,
  );
}

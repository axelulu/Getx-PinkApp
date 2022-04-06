import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:pink_acg/app/http/dao/login_dao.dart';
import 'package:pink_acg/app/routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? priority = 2;

  bool get isAuthenticated =>
      LoginDao.getBoardingPass() != null && LoginDao.getBoardingPass() != "";

  @override
  RouteSettings? redirect(String? route) {
    if (!isAuthenticated) {
      return RouteSettings(name: Routes.LOGIN);
    }
    return super.redirect(route);
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }
}

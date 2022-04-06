import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';

import '../controllers/about_us_controller.dart';

class AboutUsView extends GetView<AboutUsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            _navigationBar(),
            hiSpace(height: setHeight(20)),
            ..._content()
          ],
        ),
      ),
    );
  }

  Widget _navigationBar() {
    return NavigationBars(
      height: setHeight(150),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _content() {
    return [Text("想不出中二的简介，先占个位置")];
  }
}

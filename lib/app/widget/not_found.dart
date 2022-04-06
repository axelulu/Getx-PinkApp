import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import '../util/view_util.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 40),
      width: Get.width,
      height: setHeight(650),
      child: Column(
        children: [
          Image(
            height: 150,
            fit: BoxFit.cover,
            image: AssetImage('assets/images/404.png'),
          ),
          hiSpace(height: 20),
          Text(
            "这里什么都没有······",
            style: TextStyle(fontSize: setSp(36), color: Colors.grey),
          )
        ],
      ),
    );
  }
}

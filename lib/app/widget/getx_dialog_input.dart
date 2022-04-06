import 'package:flutter/material.dart';
import 'package:pink_acg/app/util/screenutil.dart';

import 'package:pink_acg/app/util/color.dart';

class GetxDialogInput extends StatelessWidget {
  final TextEditingController controller;
  const GetxDialogInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: setHeight(120),
        child: TextField(
          controller: controller,
          cursorColor: primary,
          style: TextStyle(fontSize: setSp(48), fontWeight: FontWeight.w300),
          //输入框样式
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                //未选中时候的颜色
                borderRadius: BorderRadius.circular(setRadius(30)),
                borderSide: BorderSide(
                  width: setWidth(4),
                  color: primary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                //选中时外边框颜色
                borderRadius: BorderRadius.circular(setRadius(30)),
                borderSide: BorderSide(
                  width: setWidth(4),
                  color: primary,
                ),
              ),
              border: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.circular(setRadius(30)),
              ),
              contentPadding: EdgeInsets.all(setWidth(20)),
              hintText: "请输入用户uid",
              hintStyle: TextStyle(fontSize: setSp(48))),
        ));
  }
}

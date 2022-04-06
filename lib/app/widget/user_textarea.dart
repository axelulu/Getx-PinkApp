import 'package:flutter/material.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/screenutil.dart';

class UserTextarea extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final int size;
  const UserTextarea(
      {Key? key, required this.controller, this.onChanged, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(
          top: setHeight(20),
          bottom: setHeight(20),
          left: setWidth(20),
          right: setWidth(20)),
      child: TextField(
        maxLines: 5,
        maxLength: size,
        cursorColor: primary,
        cursorHeight: 20,
        onChanged: onChanged,
        style: TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          isCollapsed: true,
          //内容内边距，影响高度
          border: OutlineInputBorder(
            ///用来配置边框的样式
            borderSide: BorderSide.none,
          ),
        ),
        controller: controller,
      ),
    );
  }
}

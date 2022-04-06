import 'package:flutter/material.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/screenutil.dart';

class GetxDialogButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;
  final bool flag;
  const GetxDialogButton(
      {Key? key, required this.text, required this.onTap, required this.flag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: setWidth(20), right: setWidth(20)),
      child: ClipRRect(
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(setRadius(30))),
          child: Container(
            decoration: BoxDecoration(
                color: flag ? Colors.white : primary,
                borderRadius: BorderRadius.all(Radius.circular(setRadius(30))),
                border: Border.all(width: setWidth(5), color: primary)),
            padding: EdgeInsets.only(
                left: setWidth(40),
                right: setWidth(40),
                top: setHeight(15),
                bottom: setHeight(15)),
            child: Text(
              text,
              style: TextStyle(color: flag ? primary : Colors.white),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

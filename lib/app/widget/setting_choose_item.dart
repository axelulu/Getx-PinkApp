import 'package:flutter/material.dart';
import 'package:pink_acg/app/util/color.dart';

class SettingChooseItem extends StatelessWidget {
  final String text;
  final bool flag;
  final GestureTapCallback onTap;
  const SettingChooseItem(
      {Key? key, required this.onTap, required this.text, required this.flag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 0.2,
        ),
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 40, top: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(text),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Opacity(
                        opacity: flag ? 1 : 0,
                        child: Icon(Icons.done, color: primary),
                      ),
                    )
                  ],
                )),
          ),
        ),
        Divider(
          height: 0.2,
        ),
      ],
    );
  }
}

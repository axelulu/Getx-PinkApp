import 'package:flutter/material.dart';
import 'package:pink_acg/app/util/view_util.dart';

///自定义appbar
appBar(String title, String rightTitle, VoidCallback rightButtonClick) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: false,
    titleSpacing: 0,
    leading: BackButton(color: Colors.black),
    title: Text(
      title,
      style: TextStyle(fontSize: 18, color: Colors.black),
    ),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 18, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}

///视频详情页appBar
videoAppBar({required VoidCallback onBack}) {
  return Container(
    padding: EdgeInsets.only(right: 8),
    decoration: BoxDecoration(gradient: blackLinearGradient(fromTop: true)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(
          color: Colors.white,
        ),
        Row(
          children: [
            Icon(
              Icons.live_tv_rounded,
              color: Colors.white,
              size: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
                size: 20,
              ),
            )
          ],
        )
      ],
    ),
  );
}

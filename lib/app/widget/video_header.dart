import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/user_center_mo.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/format_util.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/view_util.dart';

import 'package:pink_acg/app/util/color.dart';

///详情页 作者widget
class VideoHeader extends StatelessWidget {
  final UserMeta? userMeta;
  final String time;
  final bool isFollow;
  final bool isSelf;
  final VoidCallback onFollow;
  const VideoHeader(
      {Key? key,
      this.userMeta,
      required this.time,
      required this.isFollow,
      required this.isSelf,
      required this.onFollow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String Time = formatDate(DateTime.parse("${time.substring(0, 19)}"));
    return Container(
      height: setHeight(120),
      color: Colors.white,
      padding: EdgeInsets.only(
          top: setHeight(5), right: setWidth(30), left: setWidth(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed("/user-center", arguments: {"profileMo": userMeta!});
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: cachedImage(userMeta!.avatar,
                      height: setR(90), width: setR(90)),
                ),
                hiSpace(width: setWidth(45)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userMeta!.username,
                      style: TextStyle(
                          fontSize: setSp(38),
                          color: primary,
                          fontWeight: FontWeight.bold),
                    ),
                    hiSpace(height: setHeight(4)),
                    Row(
                      children: [
                        Text(
                          "$Time",
                          style: TextStyle(
                              color: Colors.grey, fontSize: setSp(30)),
                        ),
                        hiSpace(width: 5),
                        Text(
                          "·",
                          style: TextStyle(
                              color: Colors.grey, fontSize: setSp(30)),
                        ),
                        hiSpace(width: 5),
                        Text(
                          "${countFormat(userMeta!.fans)}粉丝",
                          style: TextStyle(
                              color: Colors.grey, fontSize: setSp(30)),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          !isSelf ? followBtn(isFollow, onFollow) : Container()
        ],
      ),
    );
  }
}

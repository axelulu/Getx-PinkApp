import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/util/format_util.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import '../../util/view_util.dart';
import 'package:pink_acg/app/widget/share_card.dart';
import 'package:vibration/vibration.dart';

import 'package:pink_acg/app/util/color.dart';

class DynamicLargeCard extends StatelessWidget {
  final contentModel;

  const DynamicLargeCard({Key? key, this.contentModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onLongPress: () async {
          //检查是否支持振动
          bool? hasVi = await Vibration.hasVibrator();
          if (hasVi!) {
            Vibration.vibrate(duration: 10);
          }
          moreHandleDialog(context, 720, ShareCard(postMo: contentModel));
        },
        onTap: openDynamic,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: setHeight(38),
                  bottom: setHeight(20),
                  left: setWidth(30),
                  right: setWidth(30)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: setWidth(30)),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(setRadius(115))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(setRadius(115)),
                      child: cachedImage(contentModel.userMeta.avatar,
                          height: setR(115), width: setR(115)),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contentModel.userMeta.username,
                        style: TextStyle(
                            color: primary,
                            fontSize: setSp(40),
                            fontWeight: FontWeight.w800),
                      ),
                      hiSpace(height: setHeight(10)),
                      Text(
                        "${formatDate(DateTime.parse("${contentModel.createTime.substring(0, 19)}"))} · 进行了投稿",
                        style:
                            TextStyle(color: Colors.grey, fontSize: setSp(30)),
                      )
                    ],
                  )),
                  Container(
                    width: setWidth(60),
                    height: setHeight(45),
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      padding: EdgeInsets.all(0),
                      iconSize: setSp(60),
                      color: Colors.grey,
                      icon: Icon(Icons.more_vert_sharp),
                      onPressed: () {
                        moreHandleDialog(
                            context, 720, ShareCard(postMo: contentModel));
                      },
                    ),
                  ),
                ],
              ),
            ),
            contentModel.postType == "dynamic" ||
                    contentModel.postType == "video"
                ? Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Text(
                      contentModel.content,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: setSp(45),
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(83, 83, 83, 1)),
                    ),
                  )
                : Container(),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: cachedImage(contentModel.cover,
                  width: Get.width - 20, height: 200),
            ),
            contentModel.postType == "post" || contentModel.postType == "video"
                ? Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        top: setHeight(20),
                        bottom: setHeight(20),
                        left: setWidth(40),
                        right: setWidth(40)),
                    child: Text(
                      contentModel.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: setSp(40), fontWeight: FontWeight.w700),
                    ),
                  )
                : Container(),
            Container(
              margin: EdgeInsets.only(bottom: setHeight(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _synamicIcon("assets/icon/share.png", "转发", () {
                    moreHandleDialog(
                        context, 720, ShareCard(postMo: contentModel));
                  }),
                  _synamicIcon("assets/icon/comment.png", "评论", openDynamic),
                  _synamicIcon(
                      "assets/icon/star.png", "${contentModel.likes}", () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _synamicIcon(String icon, String name, GestureTapCallback onTap) {
    return Container(
      height: setHeight(90),
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      child: InkResponse(
        highlightColor: Colors.transparent,
        radius: 0.0,
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(
              icon,
              width: setWidth(50),
              height: setHeight(50),
            ),
            hiSpace(width: setWidth(10)),
            Text(
              name,
              style: TextStyle(
                  fontSize: setSp(35), color: Color.fromRGBO(148, 151, 156, 1)),
            )
          ],
        ),
      ),
    );
  }

  void openDynamic() {
    switch (contentModel.postType) {
      case "dynamic":
      case "post":
        Get.toNamed("/post", arguments: {"contentModel": contentModel});
        break;
      case "video":
      case "collection":
        Get.toNamed("/video", arguments: {"contentModel": contentModel});
        break;
    }
  }
}

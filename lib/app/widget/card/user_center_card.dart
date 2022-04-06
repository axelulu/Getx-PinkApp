import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import '../../util/view_util.dart';
import 'package:pink_acg/app/widget/share_card.dart';
import 'package:vibration/vibration.dart';

class UserCenterCard extends StatelessWidget {
  final PostMo contentModel;
  const UserCenterCard({Key? key, required this.contentModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black87;
    return SizedBox(
      height: setHeight(490),
      width: Get.width / 2 - 10,
      child: Card(
        margin: EdgeInsets.only(left: 6, right: 6, bottom: 8, top: 8),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              onLongPress: () async {
                //检查是否支持振动
                bool? hasVi = await Vibration.hasVibrator();
                if (hasVi!) {
                  Vibration.vibrate(duration: 10);
                }
                moreHandleDialog(context, 720, ShareCard(postMo: contentModel));
              },
              onTap: () {
                switch (contentModel.postType) {
                  case "post":
                  case "dynamic":
                    Get.toNamed("/post",
                        arguments: {"contentModel": contentModel});
                    break;
                  case "video":
                  case "collection":
                    Get.toNamed("/video",
                        arguments: {"contentModel": contentModel});
                    break;
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [_itemImage(context), _infoText(textColor)],
              ),
            )),
      ),
    );
  }

  _itemImage(BuildContext context) {
    return Stack(
      children: [
        cachedImage(contentModel.cover,
            width: Get.size.width / 2 - 22, height: 100),
        Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 5),
              decoration: BoxDecoration(
                  //渐变
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black54, Colors.transparent])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  iconText(contentModel.view.toString(),
                      icon: "assets/icon/video_card_play.png"),
                  iconText(contentModel.favorite.toString(),
                      icon: "assets/icon/video_card_star.png"),
                  iconText(contentModel.createTime,
                      isDate: true, time: contentModel.createTime),
                ],
              ),
            ))
      ],
    );
  }

  _infoText(Color textColor) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.only(
          top: setHeight(20),
          left: setWidth(20),
          right: setHeight(20),
          bottom: setHeight(20)),
      child: Text(
        contentModel.postType == "dynamic"
            ? contentModel.content
            : contentModel.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            height: 1.4,
            color: textColor,
            fontSize: setSp(35),
            fontWeight: FontWeight.w500),
      ),
    ));
  }
}

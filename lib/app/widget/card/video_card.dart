import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import '../../util/view_util.dart';
import 'package:pink_acg/app/widget/share_card.dart';
import 'package:vibration/vibration.dart';

class VideoCard extends StatelessWidget {
  final PostMo contentModel;

  const VideoCard({Key? key, required this.contentModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black87;
    return Card(
      margin: EdgeInsets.only(
          left: setWidth(10),
          right: setWidth(10),
          top: setHeight(12),
          bottom: setHeight(12)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(setRadius(10)),
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
              Get.toNamed("/video", arguments: {"contentModel": contentModel});
            },
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _itemImage(context),
                    _infoText(context, textColor)
                  ],
                )),
          )),
    );
  }

  _itemImage(BuildContext context) {
    return Stack(
      children: [
        cachedImage(contentModel.cover,
            width: setWidth(512), height: setHeight(324)),
        Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                  left: setWidth(20),
                  right: setWidth(20),
                  bottom: setHeight(10)),
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

  _infoText(context, Color textColor) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.only(
          top: setHeight(20),
          left: setWidth(20),
          right: setHeight(20),
          bottom: setHeight(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: setHeight(8)),
            child: Text(
              contentModel.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  height: 1.4,
                  color: textColor,
                  fontSize: setSp(35),
                  fontWeight: FontWeight.w500),
            ),
          ),
          _owner(context, textColor)
        ],
      ),
    ));
  }

  _owner(context, Color textColor) {
    var owner = contentModel.userMeta;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(setRadius(60)),
              child:
                  cachedImage(owner!.avatar, width: setR(60), height: setR(60)),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: setWidth(18), right: setHeight(18)),
              child: Text(
                owner.username,
                style: TextStyle(
                    fontSize: setSp(30),
                    color: Color.fromRGBO(173, 175, 181, 1)),
              ),
            )
          ],
        ),
        InkWell(
          onTap: () {
            moreHandleDialog(context, 720, ShareCard(postMo: contentModel));
          },
          child: Icon(
            Icons.more_vert_sharp,
            size: setWidth(36),
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}

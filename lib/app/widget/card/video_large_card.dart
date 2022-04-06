import 'dart:async';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/format_util.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import '../../util/view_util.dart';
import 'package:pink_acg/app/widget/share_card.dart';
import 'package:vibration/vibration.dart';

///关联视频，视频列表卡片
class VideoLargeCard extends StatelessWidget {
  final PostMo contentModel;
  final FijkPlayer? player;

  const VideoLargeCard({
    Key? key,
    required this.contentModel,
    this.player,
  }) : super(key: key);

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
        onTap: () async {
          if (player != null) {
            await player!.stop();
          }
          switch (contentModel.postType) {
            case "post":
            case "dynamic":
              Get.toNamed("/post", arguments: {"contentModel": contentModel});
              break;
            case "video":
            case "collection":
              if (player != null) {
                Get.back();
              }
              const timeout = Duration(milliseconds: 400);
              Timer(timeout, () {
                //callback function
                Get.toNamed("/video",
                    arguments: {"contentModel": contentModel});
              });
              break;
          }
          ;
        },
        child: Container(
          height: setHeight(254),
          decoration: BoxDecoration(border: borderLine(context, bottom: true)),
          padding: EdgeInsets.only(
              left: setWidth(30),
              right: setWidth(10),
              bottom: setHeight(20),
              top: setHeight(20)),
          child: Row(
            children: [_itemImage(context), _buildContent(context)],
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Stack(
        children: [
          cachedImage(contentModel.cover,
              width: setWidth(350), height: setHeight(200)),
          Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                padding: EdgeInsets.only(bottom: 2, left: 4, right: 4),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(2)),
                child: Text(
                  formatDate(DateTime.parse(
                      "${contentModel.createTime.substring(0, 19)}")),
                  style: TextStyle(fontSize: setSp(24), color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }

  _buildContent(context) {
    return Expanded(
        child: Container(
      padding:
          EdgeInsets.only(left: 8, bottom: setHeight(12), top: setHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: setWidth(500),
            child: Text(
              contentModel.postType == "dynamic"
                  ? contentModel.content
                  : contentModel.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  height: 1.3,
                  color: Color.fromRGBO(33, 35, 37, 1),
                  fontSize: setSp(35),
                  fontWeight: FontWeight.w500),
            ),
          ),
          _buildBottomContent(context)
        ],
      ),
    ));
  }

  _buildBottomContent(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _owner(),
        hiSpace(height: setHeight(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ...smallIconText(Icons.ondemand_video, contentModel.view),
                hiSpace(width: 5),
                ...smallIconText(Icons.list_alt, contentModel.reply),
                hiSpace(width: 5),
                contentModel.postType != "video"
                    ? contentModel.postType == "dynamic"
                        ? postTypeButton("动态")
                        : postTypeButton("文章")
                    : Container(),
              ],
            ),
            Container(
              width: 30,
              height: 10,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.all(0),
                iconSize: setSp(44),
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
      ],
    );
  }

  _owner() {
    var owner = contentModel.userMeta;
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: Colors.grey)),
          child: Text(
            "UP",
            style: TextStyle(
                color: Colors.grey,
                fontSize: setSp(24),
                fontWeight: FontWeight.bold),
          ),
        ),
        hiSpace(width: 4),
        Text(
          owner!.username,
          style: TextStyle(fontSize: setSp(30), color: Colors.grey),
        )
      ],
    );
  }
}

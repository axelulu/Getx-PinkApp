import 'package:flutter/material.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/data/video_detail_mo.dart';
import 'package:pink_acg/app/util/format_util.dart';
import 'package:pink_acg/app/util/screenutil.dart';

import 'package:pink_acg/app/util/color.dart';

import '../util/view_util.dart';

///视频点赞分享收藏等工具栏
class VideoToolBar extends StatelessWidget {
  final VideoDetailMo? detailMo;
  final PostMo contentModel;
  final VoidCallback? onLike;
  final VoidCallback? onUnLike;
  final VoidCallback? onCoin;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;

  const VideoToolBar(
      {Key? key,
      required this.detailMo,
      required this.contentModel,
      this.onLike,
      this.onUnLike,
      this.onCoin,
      this.onFavorite,
      this.onShare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: setHeight(30), bottom: setHeight(40)),
      decoration: BoxDecoration(
        border: borderLine(context),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText(Icons.thumb_up_alt_rounded,
              contentModel.likes == 0 ? "喜欢" : contentModel.likes,
              onClick: onLike, tint: detailMo!.isLike ? true : false),
          _buildIconText(Icons.thumb_down_alt_rounded,
              contentModel.un_likes == 0 ? "讨厌" : contentModel.un_likes,
              onClick: onUnLike, tint: detailMo!.isUnLike ? true : false),
          _buildIconText(Icons.monetization_on, contentModel.coin,
              onClick: onCoin, tint: detailMo!.isCoin ? true : false),
          _buildIconText(Icons.grade_rounded, contentModel.favorite,
              onClick: onFavorite, tint: detailMo!.isFavorite),
          _buildIconText(Icons.share_rounded, contentModel.share,
              onClick: onShare),
        ],
      ),
    );
  }

  _buildIconText(IconData iconData, text, {onClick, bool tint = false}) {
    if (text is int) {
      text = countFormat(text);
    } else {
      text ??= "";
    }
    tint = tint == null ? false : tint;
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: Column(
          children: [
            Icon(
              iconData,
              size: setWidth(64),
              color: tint ? primary : Color.fromRGBO(86, 91, 97, 1),
            ),
            hiSpace(height: 5),
            Text(
              text,
              style: TextStyle(color: Colors.grey, fontSize: setSp(25)),
            )
          ],
        ),
      ),
    );
  }
}

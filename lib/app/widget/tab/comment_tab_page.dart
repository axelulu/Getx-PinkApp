import 'package:flutter/material.dart';
import 'package:pink_acg/app/core/pink_base_tab_state.dart';
import 'package:pink_acg/app/data/comment_mo.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/http/dao/comment_dao.dart';
import 'package:pink_acg/app/util/clipboard_tool.dart';
import 'package:pink_acg/app/util/format_util.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:vibration/vibration.dart';

import '../../util/view_util.dart';
import '../not_found.dart';

class CommentTabPage extends StatefulWidget {
  final int postId;
  final bool refresh;
  final String content;

  const CommentTabPage(
      {Key? key,
      required this.postId,
      this.refresh = true,
      required this.content})
      : super(key: key);

  @override
  _CommentTabPageState createState() => _CommentTabPageState();
}

class _CommentTabPageState
    extends PinkBaseTabState<CommentMo, CommentList, CommentTabPage> {
  @override
  // TODO: implement openRefresh
  bool get openRefresh => widget.refresh;

  @override
  // TODO: implement bannerList
  List<PostMo>? get bannerList => null;

  @override
  // TODO: implement showCommentSort
  bool get showCommentSort => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CommentTabPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {
      loadData();
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  // TODO: implement contentChild
  get contentChild => dataList.length > 0
      ? Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: setHeight(100)),
            child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) => Column(
                      children: [
                        commentCard(index),
                        Divider(
                          height: 1,
                        )
                      ],
                    )),
          ),
        )
      : ListView(
          children: [NotFound()],
        );

  @override
  Future<CommentMo> getData(int pageIndex) async {
    CommentMo result = await CommentDao.get(widget.postId, pageIndex, 10);
    return result;
  }

  @override
  List<CommentList>? parseList(CommentMo result) {
    return result.list;
  }

  // 评论排序
  commentSort() {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "热门评论",
            style: TextStyle(fontSize: setSp(38)),
          ),
          Row(
            children: [
              Icon(
                Icons.more_horiz_outlined,
                size: setSp(60),
                color: Color.fromRGBO(146, 156, 149, 1),
              ),
              Text(
                "按热度",
                style: TextStyle(
                    fontSize: setSp(38),
                    color: Color.fromRGBO(146, 156, 149, 1)),
              )
            ],
          )
        ],
      ),
      padding: EdgeInsets.only(
          top: setHeight(30),
          left: setWidth(30),
          right: setWidth(25),
          bottom: setHeight(20)),
    );
  }

  // 评论卡片
  commentCard(index) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onLongPress: () async {
          //检查是否支持振动
          bool? hasVi = await Vibration.hasVibrator();
          if (hasVi!) {
            Vibration.vibrate(duration: 10);
          }
          ClipboardTool.setDataToast(dataList[index].content);
        },
        child: Container(
          padding: EdgeInsets.only(
              left: setWidth(30),
              right: setWidth(30),
              top: setHeight(30),
              bottom: setHeight(30)),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: setWidth(25)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(setRadius(85)),
                      child: cachedImage(
                        dataList[index].owner.avatar,
                        height: setR(85),
                        width: setR(85),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataList[index].owner.username,
                        style: TextStyle(
                            height: 1,
                            fontWeight: FontWeight.w800,
                            color: Colors.black54,
                            fontSize: setSp(34)),
                      ),
                      hiSpace(height: setHeight(12)),
                      Text(
                        formatDate(
                          DateTime.parse(
                            dataList[index].updatedTime.substring(0, 19),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: setSp(30),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                margin:
                    EdgeInsets.only(left: setWidth(105), top: setHeight(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dataList[index].content),
                    hiSpace(height: setHeight(30)),
                    Row(
                      children: [
                        Image.asset("assets/icon/comment_like.png",
                            width: setWidth(60),
                            height: setHeight(60),
                            color: Colors.black),
                        hiSpace(width: setWidth(30)),
                        Image.asset("assets/icon/comment_unlike.png",
                            width: setWidth(60),
                            height: setHeight(60),
                            color: Colors.black),
                        hiSpace(width: setWidth(30)),
                        Image.asset("assets/icon/comment_icon.png",
                            width: setWidth(60),
                            height: setHeight(60),
                            color: Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

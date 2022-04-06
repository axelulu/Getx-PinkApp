import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import '../util/view_util.dart';
// import 'package:tencent_kit/tencent_kit.dart';


class ShareCard extends StatefulWidget {
  final PostMo postMo;

  const ShareCard({Key? key, required this.postMo}) : super(key: key);

  @override
  _ShareCardState createState() => _ShareCardState();
}

class _ShareCardState extends State<ShareCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(240, 240, 240, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: setHeight(276),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        bottom: setHeight(28),
                        top: setHeight(14),
                        left: setWidth(20),
                        right: setWidth(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textBtn(iconShare("微信", "assets/icon/wechat.png"),
                            () async {
                          showWarnToast("暂不支持");
                          Navigator.of(context).pop();
                        }),
                        textBtn(iconShare("朋友圈", "assets/icon/friends.png"),
                            () async {
                          showWarnToast("暂不支持");
                          Navigator.of(context).pop();
                        }),
                        // textBtn(iconShare("QQ", "assets/icon/qq.png"),
                        //     () async {
                        //   if (await Tencent.instance.isQQInstalled() ||
                        //       await Tencent.instance.isTIMInstalled()) {
                        //     Tencent.instance.shareText(
                        //       scene: TencentScene.SCENE_QQ,
                        //       summary: widget.postMo.title,
                        //     );
                        //   } else {
                        //     showWarnToast("请安装QQ或Tim");
                        //   }
                        //   Navigator.of(context).pop();
                        // }),
                        textBtn(iconShare("QQ空间", "assets/icon/qzone.png"),
                            () async {
                          showWarnToast("暂不支持");
                          Navigator.of(context).pop();
                        }),
                        textBtn(iconShare("动态", "assets/icon/active.png"), () {
                          showWarnToast("暂不支持");
                          Navigator.of(context).pop();
                        }),
                      ],
                    ),
                  )
                ],
              )),
          Divider(
            height: 1,
            color: Color.fromRGBO(233, 235, 236, 1),
          ),
          Container(
            height: setHeight(276),
            color: Colors.white,
            padding: EdgeInsets.only(left: setWidth(20), right: setWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                textBtn(iconShare("稍后再看", "assets/icon/play_await.png"), () {
                  var awaitWatch = GetStorage().read("awaitWatchPost");
                  if (awaitWatch != null && awaitWatch.length > 0) {
                    if (!awaitWatch.contains("${widget.postMo.postId}")) {
                      awaitWatch.insert(0, "${widget.postMo.postId}");
                    } else {
                      showToast("已经添加过");
                      Navigator.of(context).pop();
                      return;
                    }
                    GetStorage().write("awaitWatchPost", awaitWatch);
                  } else {
                    GetStorage()
                        .write("awaitWatchPost", ["${widget.postMo.postId}"]);
                  }
                  showToast("添加成功");
                  Navigator.of(context).pop();
                }),
              ],
            ),
          ),
          hiSpace(height: setHeight(10)),
          Container(
              color: Colors.white,
              width: setWidth(1080),
              height: setHeight(154),
              padding:
                  EdgeInsets.only(bottom: setHeight(48), top: setHeight(48)),
              child: textBtn(
                  Text(
                    "取消",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: setSp(40),
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ), () {
                Navigator.of(context).pop();
              })),
        ],
      ),
    );
  }

  void _showTips(String title, String content) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      },
    );
  }
}

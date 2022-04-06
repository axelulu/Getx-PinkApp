import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pink_acg/app/http/dao/post_view_dao.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_net/core/pink_error.dart';

import '../../pink_constants.dart';
import 'format_util.dart';

/// 添加文章查看数
void addPostView(int postId) async {
  try {
    await PostViewDao.get(postId);
  } on NeedLogin catch (e) {
    showWarnToast(e.message);
  } on NeedAuth catch (e) {
    showWarnToast(e.message);
  }
}

/// 带缓存的image
Widget cachedImage(String url,
    {double width = 200,
      double height = 150,
      String img = 'assets/icon/default.png'}) {
  return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: (BuildContext context, String url) => Image.asset(
        img,
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
      errorWidget: (
          BuildContext context,
          String url,
          dynamic error,
          ) =>
          Image.asset(
            img,
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
      imageUrl: url.startsWith('https://') || url.startsWith('http://')
          ? url + "@250w_160h.webp"
          : PinkConstants.ossDomain + '/' + url);
}

/// 黑色线性渐变
blackLinearGradient({bool fromTop = false}) {
  return LinearGradient(
      begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
      end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
      colors: [
        Colors.black54,
        Colors.black45,
        Colors.black38,
        Colors.black26,
        Colors.black12,
        Colors.transparent,
      ]);
}

/// 带文字的小图标
smallIconText(IconData iconData, var text) {
  var style = TextStyle(fontSize: setSp(32), color: Colors.grey);
  if (text is int) {
    text = countFormat(text);
  }
  return [
    Icon(
      iconData,
      color: Colors.grey,
      size: setSp(38),
    ),
    hiSpace(width: setWidth(10)),
    Text("$text", style: style),
  ];
}

/// border线
borderLine(BuildContext context, {bottom: true, top: false}) {
  BorderSide borderSide =
  BorderSide(width: 0.5, color: Color.fromRGBO(235, 236, 238, 1));
  return Border(
      bottom: bottom ? borderSide : BorderSide.none,
      top: top ? borderSide : BorderSide.none);
}

/// 空格
SizedBox hiSpace({double height: 0.5, double width: 1}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

/// 底部阴影
BoxDecoration? bottomBoxShadow() {
  return BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey[100]!,
        offset: Offset(0, 5), //xy轴偏移
        blurRadius: 5.0, //阴影模糊程度
        spreadRadius: 1, //阴影扩散程度
      )
    ],
  );
}

/// 个人空间粉丝关注
mySpaceFollow(String num, String label, {required GestureTapCallback onTap}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            num,
            style: TextStyle(fontSize: setSp(45), fontWeight: FontWeight.w600),
          ),
          hiSpace(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: setSp(34), color: Colors.grey),
          )
        ],
      ),
    ),
  );
}

/// 竖线
longString(
    {double width = 0.5, double height = 20, Color color = Colors.grey}) {
  return SizedBox(
    width: width,
    height: height,
    child: DecoratedBox(
      decoration: BoxDecoration(color: color),
    ),
  );
}

/// 文章盒子长按更多操作蒙板
void moreHandleDialog(context, int height, Widget child) {
  showMaterialModalBottomSheet(
    context: context,
    closeProgressThreshold: 0.4,
    builder: (context) => Container(
      height: setHeight(height),
      child: child,
    ),
  );
}

/// 分享蒙板文本按钮
Widget textBtn(Widget child, VoidCallback onPressed) {
  return TextButton(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
      overlayColor: MaterialStateProperty.all(Colors.white),
      //定义文本的样式 这里设置的颜色是不起作用的
      textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 18, color: Colors.white)),
      //设置按钮上字体与图标的颜色
      //foregroundColor: MaterialStateProperty.all(Colors.deepPurple),
      //更优美的方式来设置
      foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
          if (states.contains(MaterialState.focused) &&
              !states.contains(MaterialState.pressed)) {
            //获取焦点时的颜色
            return Colors.white;
          } else if (states.contains(MaterialState.pressed)) {
            //按下时的颜色
            return Colors.grey[100];
          }
          //默认状态使用灰色
          return Colors.white;
        },
      ),
      //背景颜色
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        //设置按下时的背景颜色
        if (states.contains(MaterialState.pressed)) {
          return Colors.white;
        }
        //默认不使用背景颜色
        return null;
      }),
    ),
    onPressed: onPressed,
    child: child,
  );
}

/// 分享蒙板图标
Widget iconShare(String name, String path) {
  return Container(
    margin: EdgeInsets.only(
        left: setWidth(25), right: setWidth(25), top: setHeight(30)),
    child: Column(
      children: [
        Image.asset(
          path,
          width: setWidth(122),
          height: setHeight(122),
        ),
        hiSpace(height: setHeight(20)),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: setSp(30),
              color: Color.fromRGBO(151, 158, 164, 1),
              fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}
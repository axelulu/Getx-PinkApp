import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/view_util.dart';

import 'format_util.dart';

Widget settingItemButton(GestureTapCallback onTap, String title, Widget text,
    {isShowIcon = true}) {
  return Column(
    children: [
      Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 10, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12),
                ),
                Row(
                  children: [
                    text,
                    isShowIcon
                        ? hiSpace(width: 3)
                        : Container(
                            height: setHeight(60),
                          ),
                    isShowIcon
                        ? Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                          )
                        : Container()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      Divider(
        height: 0.5,
      ),
    ],
  );
}

/// app头部按钮
Widget appBarButton(String icon, GestureTapCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.only(left: setWidth(20), right: setWidth(36)),
      child: Image.asset(icon,
          width: setWidth(60),
          height: setHeight(60),
          color: Color.fromRGBO(91, 95, 105, 1)),
    ),
  );
}

Widget iconText(String count, {isDate = false, String? icon, time}) {
  String views = "";
  if (isDate == false) {
    views = countFormat(int.parse(count));
  } else {
    views = formatDate(DateTime.parse("${time.substring(0, 19)}"));
  }
  return Row(
    children: [
      icon != null
          ? Image.asset(
              icon,
              width: setWidth(40),
              height: setHeight(40),
              color: Colors.white,
            )
          : Container(),
      isDate == false
          ? Padding(
              padding: EdgeInsets.only(left: setWidth(10)),
              child: Text(
                views,
                style: TextStyle(color: Colors.white, fontSize: setSp(28)),
              ),
            )
          : Padding(
              padding:
                  EdgeInsets.only(left: setWidth(10), bottom: setHeight(8)),
              child: Text(
                views,
                style: TextStyle(color: Colors.white, fontSize: setSp(28)),
              ),
            )
    ],
  );
}

///用户中心上的图标按钮
Widget userCenterIcon(
    bool _showBarColor, IconData icon, VoidCallback onPressed) {
  return Container(
    height: setHeight(80),
    width: setHeight(80),
    margin: EdgeInsets.only(
        left: setWidth(15),
        right: setWidth(15),
        top: setHeight(55),
        bottom: setHeight(65)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: !_showBarColor ? Color.fromRGBO(0, 0, 0, 0.3) : Colors.transparent,
    ),
    child: IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      padding: EdgeInsets.all(0),
      icon: Icon(
        icon,
        color: !_showBarColor ? Colors.white : Colors.black,
        size: setSp(70),
      ),
      onPressed: onPressed,
    ),
  );
}

///关注按钮
Widget followBtn(bool isFollow, VoidCallback onFollow) {
  return MaterialButton(
    elevation: 0,
    highlightElevation: 1,
    disabledElevation: 1.0,
    onPressed: onFollow,
    color: !isFollow ? primary : Color.fromRGBO(222, 224, 226, 1),
    height: setHeight(65),
    minWidth: setWidth(155),
    child: Text(
      !isFollow ? "+ 关注" : "已关注",
      style: TextStyle(
          color: !isFollow ? Colors.white : Color.fromRGBO(160, 160, 160, 1),
          fontSize: setSp(34)),
    ),
  );
}

/// 文章类型按钮
Widget postTypeButton(String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(setRadius(2)),
      border: Border.all(color: primary, width: 1),
      color: Color.fromRGBO(255, 226, 226, 0.5),
    ),
    padding: EdgeInsets.only(
        left: setWidth(10),
        right: setWidth(10),
        bottom: setHeight(2),
        top: setHeight(6)),
    child: Text(
      text,
      style: TextStyle(
          height: 1,
          color: Colors.red,
          fontSize: 8,
          fontWeight: FontWeight.w400),
    ),
  );
}

/// 文章发布页面菜单按钮
Widget menuButton(String name, VoidCallback onPressed,
    {bool isSelect = false}) {
  return TextButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        //设置按下时的背景颜色
        if (states.contains(MaterialState.pressed)) {
          return primary;
        }
        //默认不使用背景颜色
        if (isSelect) {
          return primary;
        } else {
          return null;
        }
      }),
      //定义文本的样式 这里设置的颜色是不起作用的
      textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: setSp(35), color: primary)),
      //设置按钮上字体与图标的颜色
      //foregroundColor: MaterialStateProperty.all(Colors.deepPurple),
      //更优美的方式来设置
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.focused) &&
              !states.contains(MaterialState.pressed)) {
            //获取焦点时的颜色
            return primary;
          } else if (states.contains(MaterialState.pressed)) {
            //按下时的颜色
            return Colors.white;
          }
          //默认状态使用灰色
          if (isSelect) {
            return Colors.white;
          } else {
            return primary;
          }
        },
      ),
      //设置水波纹颜色
      overlayColor: MaterialStateProperty.all(primary),
      //设置阴影  不适用于这里的TextButton
      elevation: MaterialStateProperty.all(0),
      //设置按钮内边距
      padding: MaterialStateProperty.all(
          EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 12)),
      //设置按钮的大小
      minimumSize: MaterialStateProperty.all(Size(20, 20)),

      //设置边框
      side: MaterialStateProperty.all(BorderSide(color: primary, width: 1)),
      //外边框装饰 会覆盖 side 配置的样式
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    ),
    onPressed: onPressed,
    child: Text(name),
  );
}

/// 发布弹窗按钮
Widget publishButton(String text, IconData icon, VoidCallback onPressed,
    {bool isSpace = false}) {
  return TextButton(
    onPressed: onPressed,
    child: isSpace
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 26,
              ),
              hiSpace(width: 5),
              Text(
                text,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              )
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 26,
              ),
              hiSpace(width: 5),
              Text(
                text,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              )
            ],
          ),
    style: ButtonStyle(
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
            return Colors.black;
          } else if (states.contains(MaterialState.pressed)) {
            //按下时的颜色
            return Colors.black;
          }
          //默认状态使用灰色
          return Colors.black;
        },
      ),
      //背景颜色
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        //设置按下时的背景颜色
        if (states.contains(MaterialState.pressed)) {
          return Colors.white;
        }
        //默认不使用背景颜色
        return Colors.white;
      }),
      //设置水波纹颜色
      overlayColor: MaterialStateProperty.all(Colors.white),
      //设置阴影  不适用于这里的TextButton
      elevation: MaterialStateProperty.all(0),
      //设置按钮内边距
      padding: MaterialStateProperty.all(EdgeInsets.only(
          left: 20,
          right: 20,
          top: isSpace ? 30 : 15,
          bottom: isSpace ? 30 : 15)),
      //设置按钮的大小
      minimumSize: MaterialStateProperty.all(Size(20, 20)),

      //外边框装饰 会覆盖 side 配置的样式
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    ),
  );
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import '../util/string_util.dart';
import '../util/view_util.dart';

///登录输入框 中自定义widget
class EmailInput extends StatefulWidget {
  final String title;
  final String email;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? sendRegEmail;
  final ValueChanged<bool>? focusChanged;
  final bool lineStretch;
  final bool obscureText;
  final bool autofocus;
  final TextInputType? keyBoardType;

  const EmailInput(
      {Key? key,
      required this.title,
      required this.email,
      this.hint = "",
      this.onChanged,
      this.sendRegEmail,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.autofocus = true,
      this.keyBoardType})
      : super(key: key);

  @override
  _EmailInputState createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  final _focusNode = FocusNode();
  String validateText = "获取验证码";
  bool isActive = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //是否获取光标的监听
    _focusNode.addListener(() {
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: TextStyle(fontSize: setSp(48)),
              ),
            ),
            _input(),
            longString(),
            Container(
              padding: EdgeInsets.only(left: setWidth(50), right: setWidth(50)),
              child: TextButton(
                onPressed: () {
                  if (!isActive) {
                    showWarnToast("请稍后再获取");
                    return;
                  }
                  if (isEmail(widget.email)) {
                    int time = 60;
                    widget.sendRegEmail!();
                    Timer.periodic(Duration(seconds: 1), (timer) {
                      if (time > 0) {
                        time--;
                        setState(() {
                          validateText = "${time}s后重试";
                          isActive = false;
                        });
                      } else {
                        timer.cancel();
                        setState(() {
                          validateText = "获取验证码";
                          isActive = true;
                        });
                      }
                    });
                  } else {
                    showWarnToast("邮箱格式错误");
                  }
                },
                child: Text(
                  validateText,
                  style: TextStyle(
                    fontSize: setSp(42),
                  ),
                ),
                style: ButtonStyle(
                  //定义文本的样式 这里设置的颜色是不起作用的
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: setSp(38), color: Colors.white)),
                  //更优美的方式来设置
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.focused) &&
                          !states.contains(MaterialState.pressed)) {
                        //获取焦点时的颜色
                        return Colors.grey;
                      } else if (states.contains(MaterialState.pressed)) {
                        //按下时的颜色
                        return Colors.grey;
                      }
                      //默认状态使用灰色
                      return isActive ? primary : Colors.grey[500];
                    },
                  ),
                  //背景颜色
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    //设置按下时的背景颜色
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.transparent;
                    }
                    //默认不使用背景颜色
                    return Colors.transparent;
                  }),
                  //设置水波纹颜色
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  //设置阴影  不适用于这里的TextButton
                  elevation: MaterialStateProperty.all(0),
                  //设置按钮内边距
                  padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                  //设置按钮的大小
                  minimumSize: MaterialStateProperty.all(Size(20, 20)),

                  //外边框装饰 会覆盖 side 配置的样式
                  shape: MaterialStateProperty.all(StadiumBorder()),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStretch ? 15 : 0),
          child: Divider(
            height: 1,
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  _input() {
    return Expanded(
      child: TextField(
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        keyboardType: widget.keyBoardType,
        autofocus: !widget.autofocus,
        cursorColor: primary,
        style: TextStyle(fontSize: setSp(48), fontWeight: FontWeight.w300),
        //输入框样式
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20, right: 20),
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: 15)),
      ),
    );
  }
}

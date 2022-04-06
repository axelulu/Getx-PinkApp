import 'package:flutter/material.dart';

///登录效果 自定义widget
class LoginEffect extends StatelessWidget {
  final bool protect;
  const LoginEffect({Key? key, required this.protect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image(true),
          Image(
            height: 90,
            width: 90,
            image: AssetImage('assets/images/logo.png'),
          ),
          _image(false),
        ],
      ),
    );
  }

  _image(bool left) {
    var headLeft = protect
        ? 'assets/images/head_left_protect.png'
        : 'assets/images/head_left.png';
    var headRight = protect
        ? 'assets/images/head_right_protect.png'
        : 'assets/images/head_right.png';
    return Image(
      height: 90,
      image: AssetImage(left ? headLeft : headRight),
    );
  }
}

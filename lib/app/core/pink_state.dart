import 'package:flutter/cupertino.dart';

///页面状态异常管理
abstract class PinkState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    } else {}
  }
}

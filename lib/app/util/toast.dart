import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 警告通知
void showWarnToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white);
}

/// 正常通知
void showToast(String text) {
  Fluttertoast.showToast(
      msg: text, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
}

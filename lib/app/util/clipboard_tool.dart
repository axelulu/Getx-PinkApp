//复制粘贴
import 'package:flutter/services.dart';
import 'package:pink_acg/app/util/toast.dart';

/// 剪切板工具
class ClipboardTool {
  //复制内容
  static setData(String data) {
    if (data != null && data != '') {
      Clipboard.setData(ClipboardData(text: data));
    }
  }

  //复制内容
  static setDataToast(String data) {
    if (data != null && data != '') {
      Clipboard.setData(ClipboardData(text: data));
      showToast('复制成功');
    }
  }

  //复制内容
  static setDataToastMsg(String data, {String toastMsg = '复制成功'}) {
    if (data != null && data != '') {
      Clipboard.setData(ClipboardData(text: data));
      showToast(toastMsg);
    }
  }

  //获取内容
  static Future<ClipboardData?> getData() {
    return Clipboard.getData(Clipboard.kTextPlain);
  }
}

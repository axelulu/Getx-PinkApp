/// 判断是否为空
bool isNotEmpty(String text) {
  return text.isNotEmpty ? text.isNotEmpty : false;
}

/// 判断是否为空
bool isEmpty(String text) {
  return text.isEmpty ? text.isEmpty : true;
}

// 邮箱判断
bool isEmail(String input) {
  String regexEmail =
      "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
  if (input.isEmpty) return false;
  return RegExp(regexEmail).hasMatch(input);
}

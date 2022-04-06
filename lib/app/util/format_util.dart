/// 数字转万
String countFormat(int count) {
  String views = "";
  if (count > 9999) {
    views = "${(count / 10000).toStringAsFixed(2)}w";
  } else {
    views = count.toString();
  }
  return views;
}

/// 时间转换将秒转换为分钟：秒
String durationTransform(int seconds) {
  int m = (seconds / 60).truncate();
  int s = seconds - m * 60;
  if (s < 10) {
    return "$m:0$s";
  }
  return "$m:$s";
}

/// 格式化tz格式时间
String formatDate(DateTime time) {
  var year = time.year;
  var month = time.month;
  var day = time.day;
  var hour = time.hour;
  var minute = time.minute;
  //获取当前时间
  DateTime nowTime = DateTime.now();
  var nowYear = nowTime.year;
  var nowMonth = nowTime.month;
  var nowDay = nowTime.day;
  if (year == nowYear && month == nowMonth && day == nowDay) {
    return "今天$hour:$minute";
  } else {
    return "$month月$day日";
  }
}

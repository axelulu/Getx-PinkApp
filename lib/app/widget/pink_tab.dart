import 'package:flutter/material.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:underline_indicator/underline_indicator.dart';

///chat页面表情tab切换
class EmojiTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController controller;

  const EmojiTab({
    Key? key,
    required this.tabs,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _unselectedLabelColor = Colors.grey[400];
    return Container(
      height: setHeight(96),
      child: TabBar(
          controller: controller,
          isScrollable: true,
          labelColor: primary,
          unselectedLabelColor: _unselectedLabelColor,
          unselectedLabelStyle:
              TextStyle(fontSize: setSp(36), fontWeight: FontWeight.w500),
          labelStyle:
              TextStyle(fontSize: setSp(36), fontWeight: FontWeight.w800),
          tabs: tabs),
    );
  }
}

///顶部tab切换
class PinkTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController controller;
  final double labelFontSize;
  final double unselectedFontSize;
  final double borderWidth;
  final double insets;
  final Color unselectedLabelColor;

  const PinkTab(
      {Key? key,
      required this.tabs,
      required this.controller,
      this.labelFontSize = 13,
      this.unselectedFontSize = 13,
      this.borderWidth = 2,
      this.insets = 15,
      this.unselectedLabelColor = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: setHeight(96),
      child: TabBar(
          controller: controller,
          isScrollable: true,
          labelColor: primary,
          unselectedLabelColor: unselectedLabelColor,
          unselectedLabelStyle: TextStyle(
              fontSize: unselectedFontSize, fontWeight: FontWeight.w500),
          labelStyle:
              TextStyle(fontSize: labelFontSize, fontWeight: FontWeight.w800),
          indicator: UnderlineIndicator(
              strokeCap: StrokeCap.square,
              borderSide: BorderSide(color: primary, width: borderWidth),
              insets: EdgeInsets.only(left: setWidth(40), right: setWidth(40))),
          tabs: tabs),
    );
  }
}

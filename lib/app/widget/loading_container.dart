import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pink_acg/app/util/screenutil.dart';

Widget LoadingMore() {
  return Container(
    height: setHeight(150),
    width: setWidth(150),
    child: Center(
      child: Lottie.asset("assets/json/loading_more.json"),
    ),
  );
}

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final double top;

  ///加载动画是否覆盖在原有界面上
  final bool cover;

  const LoadingContainer(
      {Key? key,
      required this.isLoading,
      required this.child,
      this.cover = true,
      required this.top})
      : super(key: key);

  Widget get _loadingView {
    return Positioned(
        top: top,
        left: setWidth(390),
        child: Container(
          height: setHeight(300),
          width: setWidth(300),
          child: Center(
            child: Lottie.asset("assets/json/loading_more.json"),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (cover) {
      return Stack(
        children: [
          child,
          isLoading ? _loadingView : Container(),
        ],
      );
    } else {
      return Container();
    }
  }
}

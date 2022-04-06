import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:pink_acg/app/lib/fijkplayer_skin/fijkplayer_skin.dart';
import 'package:pink_acg/app/lib/fijkplayer_skin/schema.dart'
    show VideoSourceFormat;
import 'package:pink_acg/app/util/screenutil.dart';

// 这里实现一个皮肤显示配置项
class PlayerShowConfig implements ShowConfigAbs {
  @override
  bool drawerBtn = true;
  @override
  bool nextBtn = true;
  @override
  bool speedBtn = true;
  @override
  bool topBar = true;
  @override
  bool lockBtn = true;
  @override
  bool autoNext = true;
  @override
  bool bottomPro = true;
  @override
  bool stateAuto = true;
  @override
  bool isAutoPlay = true;
}

class VideoScreen extends StatefulWidget {
  final Map<String, dynamic> url;
  final String title;
  final int curTabIdx;
  final int curActiveIdx;
  final FijkPlayer player;
  final VideoSourceFormat? videoSourceTabs;

  const VideoScreen(
      {Key? key,
      required this.url,
      required this.title,
      required this.curTabIdx,
      required this.curActiveIdx,
      required this.player,
      this.videoSourceTabs})
      : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  // 当前tab的index，默认0
  int _curTabIdx = 0;
  // 当前选中的tablist index，默认0
  int _curActiveIdx = 0;
  ShowConfigAbs vCfg = PlayerShowConfig();

  @override
  void initState() {
    _curTabIdx = widget.curTabIdx;
    _curActiveIdx = widget.curActiveIdx;
    // 这句不能省，必须有
    speed = 1.0;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant VideoScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 播放器内部切换视频钩子，回调，tabIdx 和 activeIdx
  void onChangeVideo(int curTabIdx, int curActiveIdx) async {
    this.setState(() {
      _curTabIdx = curTabIdx;
      _curActiveIdx = curActiveIdx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.url != {} &&
            widget.url != null &&
            widget.videoSourceTabs != null
        ? Container(
            height: setR(620),
            alignment: Alignment.center,
            // 这里 FijkView 开始为自定义 UI 部分
            child: FijkView(
              height: setR(620),
              color: Colors.black,
              fit: FijkFit.cover,
              player: widget.player,
              panelBuilder: (
                FijkPlayer player,
                FijkData data,
                BuildContext context,
                Size viewSize,
                Rect texturePos,
              ) {
                /// 使用自定义的布局
                return CustomFijkPanel(
                  player: player,
                  // 传递 context 用于左上角返回箭头关闭当前页面，不要传递错误 context，
                  // 如果要点击箭头关闭当前的页面，那必须传递当前组件的根 context
                  pageContent: context,
                  viewSize: viewSize,
                  texturePos: texturePos,
                  // 标题 当前页面顶部的标题部分，可以不传，默认空字符串
                  playerTitle: "${widget.title}",
                  // 当前视频改变钩子，简单模式，单个视频播放，可以不传
                  onChangeVideo: onChangeVideo,
                  // 当前视频源tabIndex
                  curTabIdx: _curTabIdx,
                  // 当前视频源activeIndex
                  curActiveIdx: _curActiveIdx,
                  // 显示的配置
                  showConfig: vCfg,
                  // json格式化后的视频数据
                  videoFormat: widget.videoSourceTabs,
                );
              },
            ))
        : Container();
  }
}

import 'package:flutter/material.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_net/core/pink_error.dart';

import 'package:pink_acg/app/util/color.dart';

///通用底层带分页和刷新的页面框架
///M为Dao返回数据模型，L为列表数据模型，T为具体widget
abstract class PinkBaseTabState<M, L, T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {
  List items = [
    {"name": "随机排序", "key": "rand"},
    {"name": "新发布", "key": "update_time"},
    {"name": "播放多", "key": "view"},
    {"name": "点赞多", "key": "likes"},
    {"name": "评论多", "key": "reply"},
  ];

  List<L> dataList = [];
  int pageIndex = 1;
  bool loading = false;
  ScrollController scrollController = ScrollController();
  bool openRefresh = true;
  get contentChild;

  String default_sort = "rand";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      //最大高度减去当前高度
      var dis = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      //距离不足0时加载更多
      if (dis == 0 &&
          !loading &&
          scrollController.position.maxScrollExtent != 0) {
        loadData(loadMore: true);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: openRefresh
          ? RefreshIndicator(
              color: primary,
              onRefresh: loadData,
              child: MediaQuery.removePadding(
                  removeTop: true, context: context, child: contentChild),
            )
          : MediaQuery.removePadding(
              removeTop: true, context: context, child: contentChild),
    );
  }

  ///获取对应页码的数据
  Future<M> getData(int pageIndex);

  ///从MO中解析出list数据
  List<L>? parseList(M result);

  Future<void> loadData({loadMore = false}) async {
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      loading = true;
      var result = await getData(currentIndex);
      setState(() {
        if (loadMore) {
          dataList = [...dataList, ...?parseList(result)];
          if (parseList(result)!.isNotEmpty) {
            pageIndex++;
          }
        } else {
          dataList = parseList(result)!;
        }
      });
      Future.delayed(Duration(milliseconds: 500), () {
        if (parseList(result)!.isEmpty) {
          setState(() {
            loading = false;
          });
        }
        loading = false;
      });
    } on NeedAuth catch (e) {
      loading = false;
      showWarnToast(e.message);
    } on PinkNetError catch (e) {
      loading = false;
      showWarnToast(e.message);
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

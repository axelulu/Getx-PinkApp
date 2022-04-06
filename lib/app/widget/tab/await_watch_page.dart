import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_acg/app/core/pink_base_tab_state.dart';
import 'package:pink_acg/app/data/dynamic_mo.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/http/dao/await_watch_dao.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/widget/card/video_large_card.dart';

import '../loading_container.dart';
import '../not_found.dart';

class AwaitWatchTabPage extends StatefulWidget {
  final String postType;
  final bool refresh;

  const AwaitWatchTabPage(
      {Key? key, this.refresh = true, required this.postType})
      : super(key: key);

  @override
  _AwaitWatchTabPageState createState() => _AwaitWatchTabPageState();
}

class _AwaitWatchTabPageState
    extends PinkBaseTabState<DynamicMo, PostMo, AwaitWatchTabPage> {
  late var awaitWatchPostIds;

  @override
  void initState() {
    awaitWatchPostIds = widget.postType == "await_watch"
        ? GetStorage().read("awaitWatchPost")
        : GetStorage().read("historyWatchPost");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AwaitWatchTabPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {
      awaitWatchPostIds = widget.postType == "await_watch"
          ? GetStorage().read("awaitWatchPost")
          : GetStorage().read("historyWatchPost");
    });
  }

  @override
  // TODO: implement openRefresh
  bool get openRefresh => widget.refresh;

  @override
  // TODO: implement contentChild
  get contentChild => dataList.length > 0
      ? ListView(
          physics: AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: dataList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: setHeight(1080) / setWidth(250)),
              padding: EdgeInsets.only(top: 10),
              itemBuilder: (BuildContext context, int index) => Container(
                  child: VideoLargeCard(
                contentModel: dataList[index],
              )),
            ),
            loading ? LoadingMore() : Container()
          ],
        )
      : ListView(
          children: [NotFound()],
        );

  @override
  Future<DynamicMo> getData(int page) async {
    DynamicMo result = await AwaitWatchDao.get(
        awaitWatchPostIds != null ? jsonEncode(awaitWatchPostIds) : "",
        page: page,
        size: 10);
    return result;
  }

  @override
  List<PostMo>? parseList(DynamicMo result) {
    return result.list;
  }
}

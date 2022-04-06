import 'package:flutter/material.dart';
import 'package:pink_acg/app/core/pink_base_tab_state.dart';
import 'package:pink_acg/app/data/dynamic_mo.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/http/dao/user_post_dao.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/widget/card/dynamic_large_card.dart';
import 'package:pink_acg/app/widget/card/video_large_card.dart';

import '../loading_container.dart';
import '../not_found.dart';

class UserCenterTabPage extends StatefulWidget {
  final String slug;
  final int userId;
  final bool refresh;
  final ScrollController? tabController;

  const UserCenterTabPage({
    Key? key,
    required this.slug,
    required this.userId,
    this.refresh = true,
    this.tabController,
  }) : super(key: key);

  @override
  _UserCenterTabPageState createState() => _UserCenterTabPageState();
}

class _UserCenterTabPageState
    extends PinkBaseTabState<DynamicMo, PostMo, UserCenterTabPage> {
  @override
  // TODO: implement openRefresh
  bool get openRefresh => widget.refresh;

  @override
  // TODO: implement contentChild
  get contentChild => dataList.length > 0
      ? widget.slug == "dynamic"
          ? Container(
              child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context, int index) => Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: DynamicLargeCard(contentModel: dataList[index]))),
            )
          : ListView(
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
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
                dataList.length > 0 ? LoadingMore() : Container()
              ],
            )
      : ListView(
          children: [NotFound()],
        );

  @override
  Future<DynamicMo> getData(int page) async {
    DynamicMo result =
        await UserPostDao.get(widget.userId, widget.slug, page, 20);
    return result;
  }

  @override
  List<PostMo>? parseList(DynamicMo result) {
    return result.list;
  }
}

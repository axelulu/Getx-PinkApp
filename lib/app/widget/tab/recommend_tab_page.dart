import 'package:flutter/material.dart';
import 'package:pink_acg/app/core/pink_base_tab_state.dart';
import 'package:pink_acg/app/data/home_mo.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/http/dao/home_dao.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/widget/card/banner_card.dart';
import 'package:pink_acg/app/widget/card/dynamic_card.dart';
import 'package:pink_acg/app/widget/card/post_card.dart';
import 'package:pink_acg/app/widget/card/video_card.dart';
import 'package:pink_acg/app/widget/not_found.dart';

import '../../data/recommend_mo.dart';
import '../loading_container.dart';

class RecommendTabPage extends StatefulWidget {
  final int categoryId;
  final List<PostMo>? bannerList;

  const RecommendTabPage({Key? key, this.categoryId = 0, this.bannerList})
      : super(key: key);

  @override
  _RecommendTabPageState createState() => _RecommendTabPageState();
}

class _RecommendTabPageState
    extends PinkBaseTabState<RecommendMo, PostMo, RecommendTabPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // TODO: implement bannerList
  List<PostMo>? get bannerList => widget.bannerList;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  // TODO: implement contentChild
  get contentChild => dataList.length > 0
      ? ListView(
          physics: AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          children: [
            if (bannerList != null && bannerList!.length > 0)
              Container(
                margin: EdgeInsets.only(
                    bottom: setHeight(10),
                    top: setHeight(10),
                    left: setWidth(10),
                    right: setWidth(10)),
                child: BannerCard(
                  bannerList,
                  bannerHeight: setHeight(595),
                ),
              ),
            Container(
              padding: EdgeInsets.only(
                  top: setHeight(24), left: setWidth(16), right: setWidth(16)),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dataList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 510 / 534),
                  itemBuilder: (BuildContext context, int index) {
                    return dataList[index].postType == "video" ||
                            dataList[index].postType == "collection"
                        ? VideoCard(contentModel: dataList[index])
                        : dataList[index].postType == "post"
                            ? PostCard(contentModel: dataList[index])
                            : DynamicCard(contentModel: dataList[index]);
                  }),
            ),
            dataList.isNotEmpty && dataList.length >= 20
                ? LoadingMore()
                : Container()
          ],
        )
      : ListView(
          children: [NotFound()],
        );

  @override
  Future<RecommendMo> getData(int pageIndex) async {
    RecommendMo result = await HomeDao.getRecoPosts(widget.categoryId);
    return result;
  }

  @override
  List<PostMo>? parseList(RecommendMo result) {
    return result.post;
  }
}

import 'package:flutter/material.dart';
import 'package:pink_acg/app/core/pink_base_tab_state.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/data/ranking_mo.dart';
import 'package:pink_acg/app/http/dao/ranking_dao.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/widget/card/ranking_large_card.dart';

import '../loading_container.dart';
import '../not_found.dart';

class RankingTabPage extends StatefulWidget {
  final String sort;

  const RankingTabPage({Key? key, required this.sort}) : super(key: key);

  @override
  _RankingTabPageState createState() => _RankingTabPageState();
}

class _RankingTabPageState
    extends PinkBaseTabState<RankingMo, PostMo, RankingTabPage> {
  @override
  // TODO: implement contentChild
  get contentChild => dataList.length > 0
      ? ListView(
          controller: scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dataList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: setHeight(1080) / setWidth(310)),
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (BuildContext context, int index) =>
                    RankingLargeCard(contentModel: dataList[index])),
            dataList.length > 0 ? LoadingMore() : Container()
          ],
        )
      : ListView(
          children: [NotFound()],
        );

  @override
  Future<RankingMo> getData(int page) async {
    var result = await RankingDao.get(widget.sort, size: 20, page: page);
    return result;
  }

  @override
  List<PostMo>? parseList(RankingMo result) {
    return result.list;
  }
}

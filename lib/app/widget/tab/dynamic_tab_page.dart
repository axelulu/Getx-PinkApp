import 'package:flutter/material.dart';
import 'package:pink_acg/app/core/pink_base_tab_state.dart';
import 'package:pink_acg/app/data/dynamic_mo.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/http/dao/dynamic_dao.dart';
import 'package:pink_acg/app/util/screenutil.dart';

import '../card/dynamic_large_card.dart';
import '../not_found.dart';

class DynamicTabPage extends StatefulWidget {
  final String slug;

  const DynamicTabPage({Key? key, required this.slug}) : super(key: key);

  @override
  _DynamicTabPageState createState() => _DynamicTabPageState();
}

class _DynamicTabPageState
    extends PinkBaseTabState<DynamicMo, PostMo, DynamicTabPage> {
  @override
  // TODO: implement contentChild
  get contentChild => dataList.length > 0
      ? ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: setHeight(32), bottom: setHeight(32)),
          itemCount: dataList.length,
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) => Container(
                margin: EdgeInsets.only(bottom: setHeight(24)),
                child: DynamicLargeCard(contentModel: dataList[index]),
              ))
      : ListView(
          children: [NotFound()],
        );

  @override
  Future<DynamicMo> getData(int page) async {
    var result = await DynamicDao.get(widget.slug, size: 10, page: page);
    return result;
  }

  @override
  List<PostMo>? parseList(DynamicMo result) {
    return result.list;
  }
}

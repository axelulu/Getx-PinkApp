import 'package:flutter/material.dart';
import 'package:pink_acg/app/core/pink_base_tab_state.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/data/search.dart';
import 'package:pink_acg/app/http/dao/search_dao.dart';
import 'package:pink_acg/app/util/screenutil.dart';

import '../card/dynamic_card.dart';
import '../card/post_card.dart';
import '../card/video_card.dart';
import '../loading_container.dart';
import '../not_found.dart';

class SearchTabPage extends StatefulWidget {
  final String type;
  final String word;

  const SearchTabPage({Key? key, required this.type, required this.word})
      : super(key: key);

  @override
  SearchTabPageState createState() => SearchTabPageState();
}

class SearchTabPageState
    extends PinkBaseTabState<SearchPostMo, PostMo, SearchTabPage> {
  String word = "";

  @override
  void initState() {
    // TODO: implement initState
    word = widget.word;
    super.initState();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(covariant SearchTabPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {
      word = widget.word;
      loadData();
    });
  }

  get contentChild => dataList.length > 0
      ? Container(
          padding: EdgeInsets.only(
              top: setHeight(24), left: setWidth(16), right: setWidth(16)),
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            children: [
              GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dataList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 510 / 534),
                  itemBuilder: (BuildContext context, int index) {
                    if (dataList[index].postType == "video") {
                      return VideoCard(contentModel: dataList[index]);
                    } else if (dataList[index].postType == "post") {
                      return PostCard(contentModel: dataList[index]);
                    } else if (dataList[index].postType == "dynamic") {
                      return DynamicCard(contentModel: dataList[index]);
                    } else if (widget.type == "user") {
                      return DynamicCard(contentModel: dataList[index]);
                    } else {
                      return PostCard(contentModel: dataList[index]);
                    }
                  }),
              dataList.length > 0 ? LoadingMore() : Container()
            ],
          ),
        )
      : ListView(
          children: [NotFound()],
        );

  @override
  Future<SearchPostMo> getData(int pageIndex) async {
    SearchPostMo result =
        await SearchDao.get(widget.type, word, page: pageIndex, size: 20);
    return result;
  }

  @override
  List<PostMo>? parseList(SearchPostMo result) {
    return result.post;
  }
}

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

import '../loading_container.dart';

class HomeTabPage extends StatefulWidget {
  final int categoryId;
  final List<PostMo>? bannerList;

  const HomeTabPage({Key? key, this.categoryId = 0, this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends PinkBaseTabState<HomeMo, PostMo, HomeTabPage> {
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
            if (widget.categoryId != "recommend") headerSort(),
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
  Future<HomeMo> getData(int pageIndex) async {
    HomeMo result = await HomeDao.get(widget.categoryId,
        page: pageIndex, size: 20, sort: default_sort);
    return result;
  }

  @override
  List<PostMo>? parseList(HomeMo result) {
    return result.postList;
  }

  // 头部排序
  headerSort() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                  width: 1, color: Color.fromRGBO(247, 247, 247, 1)))),
      padding: EdgeInsets.only(
          top: setHeight(25),
          bottom: setHeight(25),
          left: setWidth(25),
          right: setWidth(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((e) {
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(setRadius(10))),
            child: Material(
              child: InkWell(
                onTap: () {
                  default_sort = e["key"];
                  setState(() {
                    loadData();
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: setWidth(30),
                      right: setWidth(30),
                      top: setHeight(10),
                      bottom: setHeight(10)),
                  child: Text(
                    "${e["name"]}",
                    style: TextStyle(
                        fontSize: setSp(36),
                        color: default_sort == e["key"]
                            ? Colors.white
                            : Color.fromRGBO(160, 160, 160, 1)),
                  ),
                ),
              ),
              color: default_sort == e["key"] ? primary : Colors.transparent,
            ),
          );
        }).toList(),
      ),
    );
  }
}

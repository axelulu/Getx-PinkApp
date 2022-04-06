import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import '../../util/view_util.dart';


class BannerCard extends StatelessWidget {
  final List<PostMo>? bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? padding;

  const BannerCard(this.bannerList,
      {Key? key, this.bannerHeight = 160, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: setWidth(6), right: setWidth(6)),
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      itemCount: bannerList!.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList![index]);
      },
      //自定义指示器
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white60, size: 6, activeSize: 12)),
    );
  }

  _image(PostMo bannerList) {
    return Container(
      padding: padding,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        child: InkWell(
          onTap: () {
            _handleClick(bannerList);
          },
          child: Stack(
            children: [
              cachedImage(bannerList.cover,
                  width: setWidth(1050), height: bannerHeight),
              Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, bottom: 8),
                    decoration: BoxDecoration(
                        //渐变
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black54, Colors.transparent])),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: setWidth(600),
                          child: Text(
                            bannerList.postType == "dynamic"
                                ? bannerList.content
                                : bannerList.title,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w800),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _handleClick(PostMo bannerList) {
    switch (bannerList.postType) {
      case "post":
      case "dynamic":
        Get.toNamed("/post", arguments: {"contentModel": bannerList});
        break;
      case "video":
      case "collection":
        Get.toNamed("/video", arguments: {"contentModel": bannerList});
        break;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/app/widget/pink_tab.dart';
import 'package:pink_acg/app/widget/tab/search_tab_page.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavigationBars(
            height: setHeight(160),
            child: _appBar(),
            color: Colors.white,
            statusStyle: StatusStyle.DARK_CONTENT,
          ),
          Obx(() => controller.hasInput.value
              ? searchHistory(context)
              : searchResult())
        ],
      ),
    );
  }

  _tabBar() {
    return PinkTab(
      tabs: controller.categoryList.map<Tab>((tab) {
        return Tab(
          text: tab["name"],
        );
      }).toList(),
      controller: controller.controller,
      labelFontSize: setSp(40),
      unselectedFontSize: setSp(42),
      borderWidth: 3,
      unselectedLabelColor: Colors.black54,
      insets: 13,
    );
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: setWidth(30), right: setWidth(30)),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.only(left: setWidth(30)),
                height: setHeight(90),
                width: setHeight(870),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(238, 239, 240, 1),
                ),
                child: Obx(() => TextField(
                      cursorColor: primary,
                      controller: TextEditingController.fromValue(
                          TextEditingValue(
                              text: controller.searchWord.value, //判断keyword是否为空
                              // 保持光标在最后
                              selection: TextSelection.fromPosition(
                                  TextPosition(
                                      affinity: TextAffinity.upstream,
                                      offset: controller
                                          .searchWord.value.length)))),
                      onTap: () {
                        controller.allSearchHistorys.value =
                            GetStorage().read("searchHistory")!;
                        controller.hasInput.value = true;
                      },
                      onSubmitted: (value) {
                        controller.searchWord.value = value;
                        controller.setSearchHistory(value);
                      },
                      onChanged: (value) {},
                      style: TextStyle(
                          fontSize: setSp(46),
                          color: Color.fromRGBO(80, 80, 80, 1)),
                      decoration: InputDecoration(
                          hintText: "动漫游戏galgame",
                          hintStyle: TextStyle(
                              fontSize: setSp(36),
                              color: Color.fromRGBO(190, 190, 190, 1)),
                          icon: Container(
                            width: setWidth(10),
                            child: Icon(
                              Icons.search,
                              color: Color.fromRGBO(190, 190, 190, 1),
                              size: setWidth(50),
                            ),
                          ),
                          isCollapsed: true,
                          //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                          //内容内边距，影响高度

                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    )),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 12),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "取消",
                  style: TextStyle(color: Colors.grey),
                ),
              ))
        ],
      ),
    );
  }

  Widget searchResult() {
    return Expanded(
        child: Column(
      children: [
        Container(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: bottomBoxShadow(),
                  child: _tabBar(),
                ),
              )
            ],
          ),
        ),
        Flexible(
            child: TabBarView(
          controller: controller.controller,
          children: controller.categoryList.map((tab) {
            return SearchTabPage(
              type: tab["key"]!,
              word: controller.searchWord.value,
            );
          }).toList(),
        ))
      ],
    ));
  }

  Widget searchHisBtn(String name) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(right: setWidth(30)),
      child: InkWell(
        onTap: () {
          controller.setSearchHistory(name);
          controller.searchWord.value = name;
          controller.hasInput.value = false;
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(238, 240, 240, 1),
              borderRadius: BorderRadius.circular(setRadius(10))),
          padding: EdgeInsets.only(
              left: setWidth(40),
              top: setHeight(12),
              right: setWidth(40),
              bottom: setHeight(12)),
          child: Text(
            "$name",
            style: TextStyle(fontSize: setSp(36)),
          ),
        ),
      ),
    );
  }

  Widget searchHistory(context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.only(
          left: setWidth(34),
          right: setWidth(34),
          top: setHeight(12),
          bottom: setHeight(30)),
      child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "热搜",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: setSp(38),
                    fontWeight: FontWeight.w600),
              ),
              Container(
                margin: EdgeInsets.only(top: setHeight(30)),
                child: MediaQuery.removePadding(
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.dataList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 6),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                controller.setSearchHistory(
                                    controller.dataList[index]);
                                controller.searchWord.value =
                                    controller.dataList[index];
                              },
                              child: Text(
                                "${index + 1}.  ${controller.dataList[index]}",
                                style: TextStyle(
                                    height: setHeight(4),
                                    fontSize: setSp(38),
                                    fontWeight: FontWeight.w400),
                              ),
                            ));
                      }),
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                ),
              ),
              controller.allSearchHistorys.value != null &&
                      controller.allSearchHistorys.value.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        hiSpace(height: setHeight(30)),
                        Text(
                          "搜索历史",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: setSp(38),
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: setHeight(40)),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 0,
                            runSpacing: setHeight(20),
                            children:
                                controller.allSearchHistorys.value.map((value) {
                              return searchHisBtn(value);
                            }).toList(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: setHeight(40)),
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: InkWell(
                            onTap: () async {
                              Get.defaultDialog(
                                  title: "删除历史记录",
                                  radius: setRadius(40),
                                  cancel: Container(
                                    margin: EdgeInsets.only(
                                        left: setWidth(20),
                                        right: setWidth(20)),
                                    child: ClipRRect(
                                      child: InkWell(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(setRadius(30))),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      setRadius(30))),
                                              border: Border.all(
                                                  width: setWidth(5),
                                                  color: primary)),
                                          padding: EdgeInsets.only(
                                              left: setWidth(40),
                                              right: setWidth(40),
                                              top: setHeight(15),
                                              bottom: setHeight(15)),
                                          child: Text(
                                            "关闭",
                                            style: TextStyle(color: primary),
                                          ),
                                        ),
                                        onTap: () {
                                          Get.back();
                                        },
                                      ),
                                    ),
                                  ),
                                  confirm: Container(
                                    margin: EdgeInsets.only(
                                        left: setWidth(20),
                                        right: setWidth(20)),
                                    child: ClipRRect(
                                      child: InkWell(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(setRadius(30))),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: setWidth(5),
                                                color: primary),
                                            color: primary,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(setRadius(30))),
                                          ),
                                          padding: EdgeInsets.only(
                                              left: setWidth(40),
                                              right: setWidth(40),
                                              top: setHeight(15),
                                              bottom: setHeight(15)),
                                          child: Text(
                                            "确定",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        onTap: () {
                                          GetStorage()
                                              .write("searchHistory", []);
                                          controller.allSearchHistorys.value =
                                              GetStorage()
                                                  .read("searchHistory")!;
                                          showToast("删除成功");
                                          Get.back();
                                        },
                                      ),
                                    ),
                                  ),
                                  content: Container(
                                    child: Text("点击将会清空历史记录"),
                                  ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete_forever_outlined,
                                  size: setWidth(42),
                                  color: Color.fromRGBO(205, 208, 200, 1),
                                ),
                                Text(
                                  "清空搜索历史",
                                  style: TextStyle(
                                    fontSize: setSp(34),
                                    color: Color.fromRGBO(205, 208, 200, 1),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        hiSpace(height: setHeight(30)),
                      ],
                    )
                  : Container(),
              hiSpace(height: setHeight(30)),
              Text(
                "搜索发现",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: setSp(38),
                    fontWeight: FontWeight.w600),
              ),
              Container(
                padding: EdgeInsets.only(top: setHeight(40)),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 0,
                  runSpacing: setHeight(30),
                  children: controller.dataList2.map((value) {
                    return searchHisBtn(value);
                  }).toList(),
                ),
              )
            ],
          )),
    ));
  }
}

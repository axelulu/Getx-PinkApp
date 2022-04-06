import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_acg/app/data/post_mo.dart';
import 'package:pink_acg/app/lib/fijkplayer_skin/fijkplayer_skin.dart';
import 'package:pink_acg/app/modules/video/controllers/video_controller.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/follow.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/card/video_large_card.dart';
import 'package:pink_acg/app/widget/loading_container.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/app/widget/pink_tab.dart';
import 'package:pink_acg/app/widget/share_card.dart';
import 'package:pink_acg/app/widget/tab/comment_tab_page.dart';
import 'package:pink_acg/app/widget/video_content.dart';
import 'package:pink_acg/app/widget/video_header.dart';
import 'package:pink_acg/app/widget/video_toolbar.dart';

class VideoView extends GetView<VideoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MediaQuery.removePadding(
      removeTop: GetPlatform.isIOS,
      context: context,
      child: Obx(() => Column(
            children: [
              NavigationBars(
                color: Colors.black,
                statusStyle: StatusStyle.LIGHT_CONTENT,
                height: GetPlatform.isAndroid ? setHeight(16) : setHeight(80),
              ),
              _buildVideoView(),
              _buildTabNavigation(),
              _buildTabView(context),
            ],
          )),
    ));
  }

  _buildInput(BuildContext context) {
    return Expanded(
        child: Container(
      height: setHeight(90),
      margin: EdgeInsets.only(top: setHeight(20), bottom: setHeight(20)),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(26)),
      child: TextField(
        controller: controller.textEditingController,
        onSubmitted: (value) {
          controller.send(value);
        },
        cursorColor: primary,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(
              left: setWidth(40),
              right: setWidth(40),
              top: setHeight(25),
              bottom: setHeight(25)),
          border: InputBorder.none,
          hintStyle: TextStyle(
            fontSize: setSp(40),
            color: Color.fromRGBO(146, 156, 149, 1),
          ),
          hintText: "发送一条评论!",
        ),
      ),
    ));
  }

  _buildSendBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        var text = controller.textEditingController.text.isNotEmpty
            ? controller.textEditingController.text.trim()
            : "";
        controller.send(text);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.send_rounded,
          color: primary,
        ),
      ),
    );
  }

  _buildVideoView() {
    return controller.contentModel.value.video.toJson() != {}
        ? LoadingContainer(
            isLoading: controller.videoSourceTabs.value.video == null,
            top: setHeight(150),
            child: Container(
                height: setR(620),
                alignment: Alignment.center,
                // 这里 FijkView 开始为自定义 UI 部分
                child: FijkView(
                  height: setR(620),
                  color: Colors.black,
                  fit: FijkFit.cover,
                  player: controller.player.value,
                  panelBuilder: (
                    FijkPlayer player,
                    FijkData data,
                    BuildContext context,
                    Size viewSize,
                    Rect texturePos,
                  ) {
                    if (controller.videoSourceTabs.value.video != null) {
                      /// 使用自定义的布局
                      return CustomFijkPanel(
                        player: player,
                        // 传递 context 用于左上角返回箭头关闭当前页面，不要传递错误 context，
                        // 如果要点击箭头关闭当前的页面，那必须传递当前组件的根 context
                        pageContent: context,
                        viewSize: viewSize,
                        texturePos: texturePos,
                        // 标题 当前页面顶部的标题部分，可以不传，默认空字符串
                        playerTitle: controller.contentModel.value.title,
                        // 当前视频改变钩子，简单模式，单个视频播放，可以不传
                        onChangeVideo: controller.onChangeVideo,
                        // 当前视频源tabIndex
                        curTabIdx: controller.curTabIdx.value,
                        // 当前视频源activeIndex
                        curActiveIdx: controller.curActiveIdx.value,
                        // 显示的配置
                        showConfig: controller.vCfg,
                        // json格式化后的视频数据
                        videoFormat: controller.videoSourceTabs.value,
                      );
                    } else {
                      return Container();
                    }
                  },
                )),
          )
        : Container();
  }

  _buildTabNavigation() {
    return Container(
      decoration: bottomBoxShadow(),
      height: setHeight(108),
      padding: EdgeInsets.only(left: setWidth(100)),
      alignment: Alignment.centerLeft,
      child: _tabBar(),
    );
  }

  _tabBar() {
    return PinkTab(
      tabs: controller.tabs.map<Tab>((tab) {
        return Tab(
          text: tab,
        );
      }).toList(),
      labelFontSize: setSp(35),
      unselectedFontSize: setSp(35),
      controller: controller.controller,
    );
  }

  _buildDetailList(context) {
    return ListView(
      padding: EdgeInsets.only(top: setHeight(30)),
      children: [
        Container(
          margin: EdgeInsets.only(bottom: setHeight(35), left: setHeight(20)),
          child: VideoHeader(
            userMeta: controller.contentModel.value.userMeta,
            time: controller.contentModel.value.createTime,
            isFollow: controller.videoDetailMo.value.isFollow,
            isSelf: controller.videoDetailMo.value.isSelf,
            onFollow: controller.videoDetailMo.value.isFollow
                ? () {
                    unFollow(controller.contentModel.value.userMeta!.userId,
                        () {
                      controller.videoDetailMo.update((val) {
                        val!.isFollow = false;
                      });
                    });
                  }
                : () {
                    follow(controller.contentModel.value.userMeta!.userId, () {
                      controller.videoDetailMo.update((val) {
                        val!.isFollow = true;
                      });
                    });
                  },
          ),
        ),
        VideoContent(mo: controller.contentModel.value),
        VideoToolBar(
          detailMo: controller.videoDetailMo.value,
          contentModel: controller.contentModel.value,
          onLike: () {
            doLike(controller.contentModel.value.postId, () {
              controller.videoDetailMo.update((val) {
                val!.isLike = true;
              });
              controller.videoDetailMo.update((val) {
                val!.isUnLike = false;
              });
              if (controller.contentModel.value.likes >= 0) {
                controller.contentModel.update((val) {
                  val!.likes += 1;
                });
              }
              if (controller.contentModel.value.un_likes >= 1) {
                controller.contentModel.update((val) {
                  val!.un_likes -= 1;
                });
              }
            });
          },
          onUnLike: () {
            doUnLike(controller.contentModel.value.postId, () {
              controller.videoDetailMo.update((val) {
                val!.isLike = false;
              });
              controller.videoDetailMo.update((val) {
                val!.isUnLike = true;
              });
              if (controller.contentModel.value.likes >= 1) {
                controller.contentModel.update((val) {
                  val!.likes -= 1;
                });
              }
              if (controller.contentModel.value.un_likes >= 0) {
                controller.contentModel.update((val) {
                  val!.un_likes += 1;
                });
              }
            });
          },
          onFavorite: () {
            onFavorite(controller.videoDetailMo.value.isFavorite,
                controller.contentModel.value.postId, () {
              if (controller.videoDetailMo.value.isFavorite) {
                controller.videoDetailMo.update((val) {
                  val!.isFavorite = false;
                });
                if (controller.contentModel.value.favorite >= 1) {
                  controller.contentModel.update((val) {
                    val!.favorite -= 1;
                  });
                }
                showToast("取消收藏成功!");
              } else {
                controller.videoDetailMo.value.isFavorite = true;
                if (controller.contentModel.value.favorite >= 0) {
                  controller.contentModel.update((val) {
                    val!.favorite += 1;
                  });
                }
                showToast("收藏成功!");
              }
            });
          },
          onCoin: () {
            onCoin(controller.contentModel.value.postId, () {
              controller.videoDetailMo.update((val) {
                val!.isCoin = true;
              });
              controller.contentModel.update((val) {
                val!.coin += 1;
              });
            });
          },
          onShare: () {
            moreHandleDialog(
                context, 720, ShareCard(postMo: controller.contentModel.value));
          },
        ),
        Container(
          height: setHeight(200),
          padding: EdgeInsets.only(
              left: setWidth(20),
              right: setWidth(20),
              top: setHeight(35),
              bottom: setHeight(35)),
          child: controller.collection != null
              ? ListView(
                  scrollDirection: Axis.horizontal,
                  children: controller.collection.value.video[0].list
                      .asMap()
                      .entries
                      .map((e) {
                    return Container(
                      height: setHeight(120),
                      width: setWidth(340),
                      margin: EdgeInsets.only(
                        left: setWidth(15),
                        right: setWidth(15),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          //定义文本的样式 这里设置的颜色是不起作用的
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 18, color: Colors.red)),
                          //设置按钮上字体与图标的颜色
                          //foregroundColor: MaterialStateProperty.all(Colors.deepPurple),
                          //更优美的方式来设置
                          foregroundColor: MaterialStateProperty.resolveWith(
                            (states) {
                              if (states.contains(MaterialState.focused) &&
                                  !states.contains(MaterialState.pressed)) {
                                //获取焦点时的颜色
                                return Colors.grey;
                              } else if (states
                                  .contains(MaterialState.pressed)) {
                                //按下时的颜色
                                return Colors.grey;
                              }
                              //默认状态使用灰色
                              return Colors.grey;
                            },
                          ),
                          //背景颜色
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            //设置按下时的背景颜色
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white;
                            }
                            //默认不使用背景颜色
                            return null;
                          }),
                          //设置水波纹颜色
                          overlayColor: MaterialStateProperty.all(Colors.white),
                          //设置阴影  不适用于这里的TextButton
                          elevation: MaterialStateProperty.all(0),
                          //设置按钮内边距
                          padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                          //设置按钮的大小
                          minimumSize:
                              MaterialStateProperty.all(Size(200, 100)),

                          //设置边框
                          side: MaterialStateProperty.all(BorderSide(
                              color: controller.curTabIdx == 0 &&
                                      controller.curActiveIdx == e.key
                                  ? primary
                                  : Color.fromRGBO(236, 236, 236, 1),
                              width: setWidth(3))),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: setWidth(25), right: setWidth(25)),
                          child: Text(
                            '${e.key} - ${e.value.name}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: setSp(32),
                                color: controller.curTabIdx == 0 &&
                                        controller.curActiveIdx == e.key
                                    ? primary
                                    : Colors.black),
                          ),
                        ),
                        onPressed: () async {
                          await controller.player.value.reset();
                          controller.curActiveIdx.value = e.key;
                          controller.player.update((val) {
                            val!.setDataSource(
                                controller
                                    .contentModel
                                    .value
                                    .video
                                    .video[controller.curTabIdx.value]
                                    .list[controller.curActiveIdx.value]
                                    .url,
                                autoPlay: true);
                          });
                        },
                      ),
                    );
                  }).toList(),
                )
              : Container(),
        ),
        ..._buildVideoList(context)
      ],
    );
  }

  _buildVideoList(context) {
    return controller.videoList.map(
      (PostMo mo) =>
          VideoLargeCard(player: controller.player.value, contentModel: mo),
    );
  }

  _buildTabView(context) {
    return Flexible(
        child: TabBarView(
      controller: controller.controller,
      children: [
        _buildDetailList(context),
        Column(
          children: [
            Expanded(
              child: CommentTabPage(
                postId: controller.contentModel.value.postId,
                content: "$controller.random",
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: [_buildInput(context), _buildSendBtn(context)],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

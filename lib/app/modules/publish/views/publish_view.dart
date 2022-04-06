import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pink_acg/app/data/upload_mo.dart';
import 'package:pink_acg/app/data/video_detail_mo.dart';
import 'package:pink_acg/app/http/dao/upload_dao.dart';
import 'package:pink_acg/app/util/button.dart';
import 'package:pink_acg/app/util/color.dart';
import 'package:pink_acg/app/util/image_picker.dart';
import 'package:pink_acg/app/util/screenutil.dart';
import 'package:pink_acg/app/util/toast.dart';
import 'package:pink_acg/app/util/view_util.dart';
import 'package:pink_acg/app/widget/navigation_bar.dart';
import 'package:pink_acg/app/widget/video_player.dart';
import 'package:pink_acg/pink_constants.dart';
import 'package:rich_editor/rich_editor.dart';

import '../controllers/publish_controller.dart';

class PublishView extends GetView<PublishController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _buildNavigationBar(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            children: [
              // 视频
              controller.type == "video" ? _video(context) : Container(),

              // 标题
              controller.type == "post" ||
                      controller.type == "video" ||
                      controller.type == "collection"
                  ? _title()
                  : Container(),

              // 编辑器
              controller.type == "post"
                  ? _content()
                  : _textField(10, 500, 16, "请输入内容", "contents", setHeight(0)),
              Container(
                margin: EdgeInsets.only(
                    left: setWidth(20),
                    right: setWidth(20),
                    top: setHeight(20)),
                child: Divider(
                  height: 1,
                ),
              ),
              // 分类
              _category(),

              // 剧集
              controller.type == "collection"
                  ? _collection(context)
                  : Container(),

              // 封面
              controller.type == "post" ||
                      controller.type == "video" ||
                      controller.type == "dynamic" ||
                      controller.type == "collection"
                  ? _cover(context)
                  : Container(),
            ],
          ),
        )
      ],
    ));
  }

  _buildNavigationBar() {
    return NavigationBars(
      child: Container(
        height: setHeight(200),
        decoration: bottomBoxShadow(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: setWidth(20)),
              child: appBarButton("assets/icon/back.png", () {
                Get.defaultDialog(
                    title: "退出内容发布",
                    radius: setRadius(40),
                    cancel: Container(
                      margin: EdgeInsets.only(
                          left: setWidth(20), right: setWidth(20)),
                      child: ClipRRect(
                        child: InkWell(
                          borderRadius:
                              BorderRadius.all(Radius.circular(setRadius(30))),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(setRadius(30))),
                                border: Border.all(
                                    width: setWidth(5), color: primary)),
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
                          left: setWidth(20), right: setWidth(20)),
                      child: ClipRRect(
                        child: InkWell(
                          borderRadius:
                              BorderRadius.all(Radius.circular(setRadius(30))),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: setWidth(5), color: primary),
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
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            Get.back();
                            Get.back();
                          },
                        ),
                      ),
                    ),
                    content: Container(
                      child: Text("点击确定将不会保存当前内容"),
                    ));
              }),
            ),
            InkWell(
                onTap: controller.publish,
                child: Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Obx(() => Container(
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 10, right: 10),
                          color:
                              controller.isActive.value ? primary : primary[50],
                          child: Text(
                            "发布",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        )),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  _itemTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: setSp(40)),
      ),
    );
  }

  _title() {
    return Column(
      children: [
        _textField(1, 50, setSp(55), "标题（建议30字以内）", "title", setHeight(30)),
        Container(
          margin: EdgeInsets.only(
              left: setWidth(40), right: setWidth(40), top: setHeight(10)),
          child: Divider(
            height: 1,
          ),
        ),
        hiSpace(height: setHeight(20)),
      ],
    );
  }

  _textField(int lines, int length, double size, String hintText, String val,
      double marginTop) {
    return Container(
      margin: EdgeInsets.only(
          left: setWidth(30), right: setWidth(30), top: marginTop),
      child: TextField(
        maxLines: lines,
        maxLength: length,
        cursorColor: primary,
        onChanged: (value) {
          if (val == "title") {
            controller.title.value = value;
          } else {
            controller.contents.value = value;
          }
        },
        keyboardType: TextInputType.text,
        controller: TextEditingController.fromValue(TextEditingValue(
            text: val == "title"
                ? controller.title.value
                : controller.contents.value, //判断keyword是否为空
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: val == "title"
                    ? controller.title.value.length
                    : controller.contents.value.length)))),
        style: TextStyle(fontSize: size, color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: size, color: Colors.grey),

          isCollapsed: true,
          //内容内边距，影响高度
          border: OutlineInputBorder(
            ///用来配置边框的样式
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  _content() {
    return Container(
      height: setHeight(1400),
      child: RichEditor(
        key: controller.keyEditor,
        value: '',
        editorOptions: RichEditorOptions(
          placeholder: '请输入文章内容!',
          padding: EdgeInsets.symmetric(horizontal: setWidth(40)),
          baseFontFamily: 'sans-serif',
          barPosition: BarPosition.TOP,
        ),
        getImageUrl: (image) async {
          var uploadDao = UploadDao();
          UplaodMo url = await uploadDao.uploadImg(image);
          return PinkConstants.ossDomain + "/" + url.data;
        },
      ),
    );
  }

  _category() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: setWidth(30),
              top: setHeight(20),
              bottom: setHeight(10),
              right: setWidth(30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _itemTitle("请选择专栏分类"),
              Obx(() => Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 0,
                    runSpacing: -15,
                    children: controller.category.value.map((e) {
                      return Container(
                        child: menuButton(e.categoryName, () {
                          controller.categoryId.value = e.categoryId;
                        },
                            isSelect:
                                e.categoryId == controller.categoryId.value),
                        margin: EdgeInsets.only(
                            right: setWidth(27), bottom: setHeight(10)),
                      );
                    }).toList(),
                  )),
              Text(
                " 必选",
                style: TextStyle(
                    fontSize: setSp(26),
                    color: Color.fromRGBO(183, 189, 191, 1)),
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  _cover(context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: setWidth(30),
              top: setHeight(20),
              bottom: setHeight(10),
              right: setWidth(30)),
          child: Column(
            children: [
              _itemTitle("封面预览"),
              Container(
                padding:
                    EdgeInsets.only(top: setHeight(30), bottom: setHeight(30)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      offset: Offset(0, 0), //xy轴偏移
                      blurRadius: 1.0, //阴影模糊程度
                      spreadRadius: 1, //阴影扩散程度
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: setHeight(66),
                      width: setWidth(1020),
                      color: Color.fromRGBO(238, 239, 245, 1),
                      margin: EdgeInsets.only(
                          bottom: setHeight(20),
                          left: setWidth(33),
                          right: setWidth(32)),
                    ),
                    Stack(
                      children: [
                        Obx(() => cachedImage(controller.cover.value,
                            width: setWidth(1020),
                            height: setHeight(300),
                            img: 'assets/icon/default.png')),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () async {
                              List<AssetEntity>? fileList =
                                  await getImagePicker(context, maxAssets: 1);
                              File? file = await fileList![0].file;
                              if (file == null) return;
                              var uploadDao = UploadDao();
                              UplaodMo url = await uploadDao.uploadImg(file);
                              controller.cover.value = url.data;
                            },
                            child: Image.asset(
                              'assets/icon/image.png',
                              height: setHeight(85),
                              width: setWidth(85),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: setHeight(40),
                      width: setWidth(1020),
                      color: Color.fromRGBO(238, 239, 245, 1),
                      margin: EdgeInsets.only(
                          top: setHeight(20),
                          bottom: setHeight(10),
                          left: setWidth(33),
                          right: setWidth(32)),
                    ),
                    Container(
                      height: setHeight(40),
                      width: setWidth(1020),
                      color: Color.fromRGBO(238, 239, 245, 1),
                      margin: EdgeInsets.only(
                          bottom: setHeight(20),
                          left: setWidth(33),
                          right: setWidth(32)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: setWidth(33),
                      ),
                      child: Text(
                        " 文章封面",
                        style: TextStyle(
                            fontSize: setSp(26),
                            color: Color.fromRGBO(183, 189, 191, 1)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }

  _video(context) {
    return Stack(
      children: [
        Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.progressBar.value == 1.0
                    ? Container(
                        alignment: Alignment.centerLeft,
                        height: setHeight(80),
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: setWidth(40), bottom: setHeight(20)),
                        child: Text(
                          "上传成功",
                          style: TextStyle(fontSize: setSp(35)),
                        ),
                      )
                    : Container(),
                Container(
                  alignment: Alignment.centerLeft,
                  height: setHeight(10),
                  width:
                      setWidth((controller.progressBar.value * 2248).toInt()),
                  color: primary,
                ),
                controller.collection.value.video[0].list[0].url != ""
                    ? VideoScreen(
                        url: controller.collection.value.toJson(),
                        title: controller.title.value,
                        curTabIdx: 0,
                        curActiveIdx: 0,
                        player: controller.player.value,
                      )
                    : cachedImage(
                        'assets/icon/default.png',
                        height: setHeight(680),
                        width: setWidth(1080),
                      ),
              ],
            )),
        Positioned(
          bottom: setHeight(30),
          right: setWidth(30),
          child: InkWell(
            onTap: () async {
              controller.isActive.value = false;
              List<AssetEntity>? fileList = await getImagePicker(context,
                  maxAssets: 1, requestType: RequestType.video);
              File? file = await fileList![0].file;
              // ImageSource gallerySource = ImageSource.gallery;
              // final ImagePicker _picker = ImagePicker();
              // final file = await _picker.pickVideo(source: gallerySource);
              if (file == null) return;
              var uploadDao = UploadDao();
              uploadDao.sendProgress = (int count, int total) {
                controller.progressBar.value = count / total;
              };
              UplaodMo url = await uploadDao.uploadVideo(file);
              controller.collection.update((val) {
                val!.video[0].list[0].url =
                    PinkConstants.ossDomain + "/" + url.data;
                val.video[0].list[0].name = controller.title.value;
              });
              controller.isActive.value = true;
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(35, 12, 13, 1),
                  borderRadius: BorderRadius.circular(setRadius(10))),
              padding: EdgeInsets.only(
                  left: setWidth(15),
                  right: setWidth(15),
                  bottom: setHeight(15),
                  top: setHeight(15)),
              child: Text(
                "上传视频",
                style: TextStyle(color: Colors.white, fontSize: setSp(30)),
              ),
            ),
          ),
        )
      ],
    );
  }

  _collection(context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Container(
                alignment: Alignment.centerLeft,
                height: setHeight(10),
                width: setWidth((controller.progressBar.value * 2248).toInt()),
                color: primary,
              )),
          Obx(() => controller.collection.value.video != null
              ? Column(
                  children: controller.collection.value.video[0].list
                      .asMap()
                      .entries
                      .map((e) {
                    return Container(
                      child: Row(
                        children: [
                          Container(
                            width: setWidth(500),
                            height: setHeight(80),
                            margin: EdgeInsets.only(
                              left: setWidth(30),
                              right: setWidth(20),
                              top: setHeight(20),
                            ),
                            child: e.value.url != ""
                                ? TextField(
                                    cursorColor: primary,
                                    controller: TextEditingController.fromValue(
                                        TextEditingValue(
                                            text: e.value.url, //判断keyword是否为空
                                            // 保持光标在最后

                                            selection:
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        affinity: TextAffinity
                                                            .downstream,
                                                        offset: e.value.url
                                                            .length)))),
                                    style: TextStyle(
                                        fontSize: setSp(32),
                                        color: Color.fromRGBO(80, 80, 80, 1)),
                                    decoration: InputDecoration(
                                        hintText: "支持(mp4,flv,u3m8)",
                                        hintStyle: TextStyle(
                                            fontSize: setSp(32),
                                            color: Color.fromRGBO(
                                                190, 190, 190, 1)),
                                        isCollapsed: true,
                                        //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 6),
                                        //内容内边距，影响高度

                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 4,
                                                color: Colors.white70))),
                                  )
                                : ElevatedButton(
                                    style: ButtonStyle(
                                      textStyle: MaterialStateProperty.all(
                                          TextStyle(fontSize: setSp(32))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              controller.isActive.value
                                                  ? primary
                                                  : primary[50]), //背景颜色
                                    ),
                                    onPressed: () async {
                                      if (!controller.isActive.value) {
                                        showWarnToast("请等待上传完成");
                                        return;
                                      }
                                      controller.isActive.value = false;
                                      List<AssetEntity>? fileList =
                                          await getImagePicker(context,
                                              maxAssets: 1,
                                              requestType: RequestType.video);
                                      File? file = await fileList![0].file;
                                      // ImageSource gallerySource =
                                      //     ImageSource.gallery;
                                      // final ImagePicker _picker = ImagePicker();
                                      // final file = await _picker.pickVideo(
                                      //     source: gallerySource);
                                      if (file == null) return;
                                      var uploadDao = UploadDao();
                                      uploadDao.sendProgress =
                                          (int count, int total) {
                                        controller.progressBar.value =
                                            count / total;
                                      };
                                      UplaodMo url =
                                          await uploadDao.uploadVideo(file);
                                      uploadDao.sendProgress =
                                          (int count, int total) {
                                        controller.progressBar.value =
                                            count / total;
                                      };
                                      controller.collection.update((val) {
                                        val!.video[0].list[e.key].url =
                                            PinkConstants.ossDomain +
                                                "/" +
                                                url.data;
                                      });
                                      controller.isActive.value = true;
                                    },
                                    child: Text("上传视频")),
                          ),
                          Container(
                            width: setWidth(280),
                            height: setHeight(80),
                            margin: EdgeInsets.only(
                              right: setWidth(20),
                              top: setHeight(20),
                            ),
                            child: TextField(
                              cursorColor: primary,
                              controller: TextEditingController.fromValue(
                                  TextEditingValue(
                                      text: '${e.value.name}', //判断keyword是否为空
                                      // 保持光标在最后

                                      selection: TextSelection.fromPosition(
                                          TextPosition(
                                              affinity: TextAffinity.downstream,
                                              offset: e.value.name.length)))),
                              style: TextStyle(
                                  fontSize: setSp(32),
                                  color: Color.fromRGBO(80, 80, 80, 1)),
                              onChanged: (value) {
                                controller.collection.update((val) {
                                  val!.video[0].list[e.key].name = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "视频名称",
                                hintStyle: TextStyle(
                                    fontSize: setSp(32),
                                    color: Color.fromRGBO(190, 190, 190, 1)),
                                isCollapsed: true,
                                //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 6),
                                //内容内边距，影响高度

                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, color: Colors.white70)),
                              ),
                            ),
                          ),
                          Container(
                            height: setHeight(80),
                            margin: EdgeInsets.only(top: setHeight(20)),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(fontSize: setSp(32))),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.red), //背景颜色
                                ),
                                onPressed: () {
                                  controller.collection.update((value) {
                                    if (value!.video[0].list.length > 1) {
                                      value.video[0].list.removeAt(e.key);
                                    }
                                  });
                                },
                                child: Text("删除")),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                )
              : Container()),
          Container(
            height: setHeight(80),
            width: setWidth(1020),
            margin: EdgeInsets.only(left: setWidth(25), top: setHeight(20)),
            child: ElevatedButton(
                style: ButtonStyle(
                  textStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: setSp(32))),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green), //背景颜色
                ),
                onPressed: () {
                  controller.collection.update((value) {
                    value!.video[0].list.add(CollectionList());
                  });
                },
                child: Text("添加")),
          )
        ],
      ),
    );
  }
}

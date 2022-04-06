import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:pink_acg/pink_constants.dart';
import 'package:r_upgrade/r_upgrade.dart';

class UpdateUtil {
  int? id;

  /// 更新应用
  static Future<Map> getUpgrade() async {
    if (Platform.isAndroid) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String localVersion = packageInfo.version;
      var result = await Dio()
          .get("http://" + PinkConstants.domain + ":8080/api/v1/update");
      if (result.data != "") {
        String serverAndroidVersion = result.data["data"]["version"];
        String serverAndroidUrl = result.data["data"]["url"];
        String serverAndroidMsg = result.data["data"]["meta"];
        int c = serverAndroidVersion.compareTo(localVersion);
        if (c == 1) {
          return {
            "update": true,
            "msg": serverAndroidMsg,
            "version": serverAndroidVersion,
            "url": serverAndroidUrl
          };
        }
      }
    }
    return {
      "update": false,
    };
  }

  static Future<void> upgrade(String serverAndroidUrl) async {}

  /// 安装应用
  void install() async {
    bool? isSuccess = await RUpgrade.install(id!);
  }

  /// 暂停下载
  void pause() async {
    bool? isSuccess = await RUpgrade.pause(id!);
  }

  /// 关闭下载
  void cancel() async {
    bool? isSuccess = await RUpgrade.cancel(id!);
  }

  /// 继续下载
  void pause_() async {
    bool? isSuccess = await RUpgrade.upgradeWithId(id!);
    // 返回 false 即表示从来不存在此ID
    // 返回 true
    //    调用此方法前状态为 [STATUS_PAUSED]、[STATUS_FAILED]、[STATUS_CANCEL],将继续下载
    //    调用此方法前状态为 [STATUS_RUNNING]、[STATUS_PENDING]，不会发生任何变化
    //    调用此方法前状态为 [STATUS_SUCCESSFUL]，将会安装应用
    // 当文件被删除时，重新下载
  }

  /// 获取最后一次下载的ID
  void getLastUpgradeId() async {
    int? id = await RUpgrade.getLastUpgradedId();
  }

  /// 获取ID对应的下载状态
  void getDownloadStatus() async {
    DownloadStatus? status = await RUpgrade.getDownloadStatus(id!);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> showUpdate(BuildContext context, String serverAndroidVersion,
      String serverAndroidMsg, String serverAndroidUrl) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("检测到新版本：v$serverAndroidVersion"),
            content: Text("是否要更新到最新版本？"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("下次再说")),
              FlatButton(
                  onPressed: () {
                    doUpdate(context, serverAndroidVersion, serverAndroidUrl);
                  },
                  child: Text("立即更新"))
            ],
          );
        });
  }

  void doUpdate(BuildContext context, String serverAndroidVersion,
      String serverAndroidUrl) async {
    Navigator.pop(context);
    await upgrade(serverAndroidUrl);
  }
}

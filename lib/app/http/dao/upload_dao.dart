import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pink_acg/app/data/upload_mo.dart';
import 'package:pink_acg/app/http/request/upload_request.dart';
import 'package:pink_net/pink_net.dart';

class UploadDao {
  ProgressCallback sendProgress = (int count, int total) {};

  // 上传图片
  uploadImg(File? imgfile) async {
    UploadRequest request = UploadRequest();
    String path = imgfile!.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = FormData.fromMap(
        {"file": await MultipartFile.fromFile(path, filename: name)});
    request.file = formData;
    var pinkNet = PinkNet.getInstance();
    pinkNet.sendProgress = sendProgress;
    var result = await pinkNet.fire(request);
    return UplaodMo.fromJson(result);
  }

  // 上传视频
  uploadVideo(File imgfile) async {
    UploadRequest request = UploadRequest();
    String path = imgfile.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = FormData.fromMap(
        {"file": await MultipartFile.fromFile(path, filename: name)});
    request.file = formData;
    var pinkNet = PinkNet.getInstance();
    pinkNet.sendProgress = sendProgress;
    var result = await pinkNet.fire(request);
    return UplaodMo.fromJson(result);
  }
}

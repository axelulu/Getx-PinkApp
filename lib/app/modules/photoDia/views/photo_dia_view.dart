import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../controllers/photo_dia_controller.dart';

class PhotoDiaView extends GetView<PhotoDiaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Obx(() => PhotoView(
                imageProvider: NetworkImage(controller.image.value),
              )),
        ),
        onLongPress: () {
          controller.getPerm();
        },
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

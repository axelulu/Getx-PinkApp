import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'custom_dialog_template.dart';

class InsertImageDialog extends StatefulWidget {
  final bool isVideo;

  InsertImageDialog({this.isVideo = false});

  @override
  _InsertImageDialogState createState() => _InsertImageDialogState();
}

class _InsertImageDialogState extends State<InsertImageDialog> {
  TextEditingController link = TextEditingController();

  TextEditingController alt = TextEditingController();
  bool picked = false;

  @override
  Widget build(BuildContext context) {
    return CustomDialogTemplate(
      body: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.isVideo ? '视频链接' : '图片链接'),
            ElevatedButton(
              onPressed: () => getImage(),
              child: Text('...'),
            ),
          ],
        ),
        TextField(
          controller: link,
          decoration: InputDecoration(
            hintText: '',
          ),
        ),
        Visibility(
          visible: !widget.isVideo,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Text('显示文本'),
              TextField(
                controller: alt,
                decoration: InputDecoration(
                  hintText: '',
                ),
              ),
            ],
          ),
        ),
      ],
      onDone: () => Navigator.pop(context, [link.text, alt.text, picked]),
      onCancel: () => Navigator.pop(context),
    );
  }

  Future getImage() async {
    final picker = ImagePicker();
    AssetEntity? image;
    if (widget.isVideo) {
      // image = await picker.getVideo(source: ImageSource.gallery);
    } else {
      final List<AssetEntity>? fileList = await AssetPicker.pickAssets(context,
          maxAssets: 1,
          requestType: RequestType.image,
          // themeColor: primary,
          routeCurve: Curves.fastLinearToSlowEaseIn);
      if (fileList!.isEmpty) return;
      image = fileList[0];
    }

    if (image != null) {
      link.text = image.relativePath!;
      picked = true;
    }
  }
}

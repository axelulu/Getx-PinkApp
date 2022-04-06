import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  final String serverAndroidVersion;
  final String serverAndroidMsg;
  final VoidCallback close;
  final VoidCallback update;
  const Update(
      {Key? key,
      required this.serverAndroidVersion,
      required this.close,
      required this.update,
      required this.serverAndroidMsg})
      : super(key: key);

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: AlertDialog(
      title: Text('检测到新版本:v${widget.serverAndroidVersion}'),
      content: Text('${widget.serverAndroidMsg}'),
      elevation: 24,
      actions: <Widget>[
        TextButton(
          child: Text('下次一定'),
          onPressed: widget.close,
        ),
        TextButton(
          child: Text('立即更新'),
          onPressed: widget.update,
        ),
      ],
    ));
  }
}

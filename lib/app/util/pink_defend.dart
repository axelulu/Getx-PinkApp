import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bugly/flutter_bugly.dart';

class PinkDefend {
  run(Widget app) {
    // 框架异常
    FlutterError.onError = (FlutterErrorDetails details) async {
      if (kReleaseMode) {
        // 线上环境，走上报流程
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      } else {
        // 开发期间，走控制台
        FlutterError.dumpErrorToConsole(details);
      }
    };
    runZonedGuarded(() {
      FlutterBugly.postCatchedException(() {
        runApp(app);
      });
    }, (e, s) => _reportError(e, s));
  }

  _reportError(Object error, StackTrace s) {
    print("当前环境:$kReleaseMode");
    print("catch error:$error");
  }
}

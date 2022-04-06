import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class AboutAppController extends GetxController {
  //TODO: Implement AboutAppController
  var version = "".obs;
  var appName = "".obs;
  var buildNumber = "".obs;
  var packageName = "".obs;

  @override
  Future<void> onInit() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
    appName.value = packageInfo.appName;
    buildNumber.value = packageInfo.buildNumber;
    packageName.value = packageInfo.packageName;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

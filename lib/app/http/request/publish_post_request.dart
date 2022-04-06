import 'package:pink_acg/pink_constants.dart';
import 'package:pink_net/request/pink_base_request.dart';

import 'base_request.dart';

class PublishPostRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return "${PinkConstants.versionPath}/post";
  }
}

import 'package:pink_acg/app/http/dao/login_dao.dart';
import 'package:pink_acg/pink_constants.dart';
import 'package:pink_net/request/pink_base_request.dart';

abstract class BaseRequest extends PinkBaseRequest {
  @override
  String authority() {
    return "${PinkConstants.domain}:${PinkConstants.port}";
  }

  @override
  String url() {
    //是否需要登录
    if (needLogin()) {
      addHeader(
          PinkConstants.authorization, "Bearer " + LoginDao.getBoardingPass());
    }
    return super.url();
  }
}

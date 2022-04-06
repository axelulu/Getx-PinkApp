import 'package:pink_net/request/pink_base_request.dart';

import 'favorite_request.dart';

class CancelFavoriteRequest extends FavoriteRequest {
  @override
  HttpMethod httpMethod() {
    // TODO: implement httpMethod
    return HttpMethod.DELETE;
  }
}

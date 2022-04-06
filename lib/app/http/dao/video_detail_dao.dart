import 'package:pink_acg/app/data/video_detail_mo.dart';
import 'package:pink_acg/app/http/request/video_detail_request.dart';
import 'package:pink_net/pink_net.dart';

class VideoDetailDao {
  static get(String vid) async {
    VideoDetailRequest request = VideoDetailRequest();
    request.pathParams = vid;
    var result = await PinkNet.getInstance().fire(request);
    print(result);
    return VideoDetailMo.fromJson(result["data"]);
  }
}

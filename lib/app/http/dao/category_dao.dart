import 'package:pink_acg/app/data/category_mo.dart';
import 'package:pink_acg/app/http/request/category_request.dart';
import 'package:pink_net/pink_net.dart';

class CategoryDao {
  static get(int size) async {
    CategoryRequest request = CategoryRequest();
    request.add("size", size);
    var result = await PinkNet.getInstance().fire(request);
    return CategoryModel.fromJson(result);
  }
}

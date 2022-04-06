import 'package:pink_acg/app/data/home_mo.dart';

class CategoryModel {
  late int code;
  late String msg;
  late List<CategoryMo> data;

  CategoryModel({required this.code, required this.msg, required this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <CategoryMo>[];
      json['data'].forEach((v) {
        data.add(new CategoryMo.fromJson(v));
      });
    } else {
      data = <CategoryMo>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

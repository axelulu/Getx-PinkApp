import 'package:pink_acg/app/data/post_mo.dart';

class HomeMo {
  late List<PostMo> bannerList;
  late List<CategoryMo> categoryList;
  late List<PostMo> postList;

  HomeMo(
      {required this.bannerList,
      required this.categoryList,
      required this.postList});

  HomeMo.fromJson(Map<String, dynamic> json) {
    if (json['banner'] != null) {
      bannerList = <PostMo>[];
      json['banner'].forEach((v) {
        bannerList.add(new PostMo.fromJson(v));
      });
    } else {
      bannerList = <PostMo>[];
    }
    if (json['category'] != null) {
      categoryList = <CategoryMo>[];
      json['category'].forEach((v) {
        categoryList.add(new CategoryMo.fromJson(v));
      });
    } else {
      categoryList = <CategoryMo>[];
    }
    if (json['post'] != null) {
      postList = <PostMo>[];
      json['post'].forEach((v) {
        postList.add(new PostMo.fromJson(v));
      });
    } else {
      postList = <PostMo>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bannerList != null) {
      data['banner'] = this.bannerList.map((v) => v.toJson()).toList();
    }
    if (this.categoryList != null) {
      data['category'] = this.categoryList.map((v) => v.toJson()).toList();
    }
    if (this.postList != null) {
      data['post'] = this.postList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryMo {
  late int categoryId;
  late String categoryName;

  CategoryMo({required this.categoryId, required this.categoryName});

  CategoryMo.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    return data;
  }
}

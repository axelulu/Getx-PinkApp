import 'package:pink_acg/app/data/home_mo.dart';
import 'package:pink_acg/app/data/post_mo.dart';

class RecommendMo {
  List<PostMo>? banner;
  List<CategoryMo>? category;
  List<PostMo>? post;

  RecommendMo({this.banner, this.category, this.post});

  RecommendMo.fromJson(Map<String, dynamic> json) {
    if (json['banner'] != null) {
      banner = <PostMo>[];
      json['banner'].forEach((v) {
        banner!.add(PostMo.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <CategoryMo>[];
      json['category'].forEach((v) {
        category!.add(CategoryMo.fromJson(v));
      });
    }
    if (json['post'] != null) {
      post = <PostMo>[];
      json['post'].forEach((v) {
        post!.add(PostMo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (banner != null) {
      data['banner'] = banner!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    if (post != null) {
      data['post'] = post!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? categoryId;
  String? categoryName;

  Category({this.categoryId, this.categoryName});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    return data;
  }
}

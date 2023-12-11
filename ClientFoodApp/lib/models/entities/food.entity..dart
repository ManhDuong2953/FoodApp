import 'package:foodapp/models/assets_dir/assets_direct.dart';

class Food {
  int? id;
  String? name;
  double? price;
  String? ingredients;
  String? description;
  String? imgThumbnail;
  double? averageRating;
  int? totalReviews;
  int? totalOrders;

  Food({
    this.id,
    this.name,
    this.price,
    this.ingredients,
    this.description,
    this.imgThumbnail,
    this.averageRating,
    this.totalReviews,
    this.totalOrders,
  });

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "Tên món không khả dụng";
    price = double.parse(json['price'] ?? '0.0');
    ingredients = json['ingredients'] ?? "";
    description = json['description'] ?? "";
    imgThumbnail = json['img_thumbnail'] ?? assetsDirect.errImg;
    averageRating = json['average_rating'] != null
        ? double.parse(json['average_rating'])
        : 0.0;

    totalReviews = int.parse(json['total_reviews'].toString());
    totalOrders = int.parse(json['total_orders'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['ingredients'] = ingredients;
    data['description'] = description;
    data['img_thumbnail'] = imgThumbnail;
    data['average_rating'] = averageRating;
    data['total_reviews'] = totalReviews;
    data['total_orders'] = totalOrders;
    return data;
  }
}

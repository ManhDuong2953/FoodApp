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
    imgThumbnail = json['img_thumbnail'] ?? "assets/images/errImg.jpg";
    averageRating =
        double.parse(json['price'] != "null" ? json['price'] : '0.0');
    totalReviews = int.parse(json['total_reviews'].toString()) ?? 0;
    totalOrders = int.parse(json['total_orders'].toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['ingredients'] = this.ingredients;
    data['description'] = this.description;
    data['img_thumbnail'] = this.imgThumbnail;
    data['average_rating'] = this.averageRating;
    data['total_reviews'] = this.totalReviews;
    data['total_orders'] = this.totalOrders;
    return data;
  }
}

import 'package:foodapp/models/assets_dir/assets_direct.dart';

class Review {
  int? idFood;
  int? idUser;
  String? name;
  String? avatarThumbnail;
  String? reviewsDatetime;
  int? rate;
  String? comment;

  Review(
      {this.idFood,
      this.idUser,
      this.name,
      this.avatarThumbnail,
      this.reviewsDatetime,
      this.rate,
      this.comment});

  Review.fromJson(Map<String, dynamic> json) {
    idFood = json['food_id'];
    idUser = json['user_id'];
    name = json['name'] ?? "Người dùng FoodApp";
    avatarThumbnail = json['avatar_thumbnail'] ?? assetsDirect.errAvt;
    reviewsDatetime = json['reviews_datetime'] ?? "";
    rate = int.parse(json['rate'].toString()) ?? 5;
    comment = json['comment'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['food_id'] = idFood;
    data['user_id'] = idUser;
    data['name'] = name;
    data['avatar_thumbnail'] = avatarThumbnail;
    data['reviews_datetime'] = reviewsDatetime;
    data['rate'] = rate;
    data['comment'] = comment;
    return data;
  }
}

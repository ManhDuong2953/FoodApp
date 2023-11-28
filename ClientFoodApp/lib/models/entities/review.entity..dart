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
    avatarThumbnail = json['avatar_thumbnail'] ?? "assets/images/errorAvt.png";
    reviewsDatetime = json['reviews_datetime'] ?? "";
    rate = int.parse(json['rate'].toString()) ?? 5;
    comment = json['comment'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_id'] = this.idFood;
    data['user_id'] = this.idUser;
    data['name'] = this.name;
    data['avatar_thumbnail'] = this.avatarThumbnail;
    data['reviews_datetime'] = this.reviewsDatetime;
    data['rate'] = this.rate;
    data['comment'] = this.comment;
    return data;
  }
}

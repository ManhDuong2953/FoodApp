class Review {
  String? name;
  String? avatarThumbnail;
  String? reviewsDatetime;
  int? rate;
  String? comment;

  Review(
      {this.name,
      this.avatarThumbnail,
      this.reviewsDatetime,
      this.rate,
      this.comment});

  Review.fromJson(Map<String, dynamic> json) {
    name = json['name']?? "Người dùng FoodApp";
    avatarThumbnail = json['avatar_thumbnail'] ?? "assets/images/errorAvt.png";
    reviewsDatetime = json['reviews_datetime'] ?? "";
    rate = json['rate'] ?? 5;
    comment = json['comment'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar_thumbnail'] = this.avatarThumbnail;
    data['reviews_datetime'] = this.reviewsDatetime;
    data['rate'] = this.rate;
    data['comment'] = this.comment;
    return data;
  }
}
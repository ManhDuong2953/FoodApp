class Order {
  int? orderId;
  double? price;
  int? foodId;
  String? name;
  String? ingredients;
  String? imgThumbnail;
  String? orderDatetime;
  int? quantity;
  double? totalPrice;
  int? userID;

  Order({
    this.orderId,
    this.price,
    this.foodId,
    this.name,
    this.ingredients,
    this.imgThumbnail,
    this.orderDatetime,
    this.quantity,
    this.totalPrice,
    this.userID,
  });

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    price = double.parse(json['price'].toString()) ?? 0.0;
    foodId = json['food_id'];
    name = json['name'];
    ingredients = json['ingredients'];
    imgThumbnail = json['img_thumbnail'];
    orderDatetime = json['order_datetime'];
    quantity = json['quantity'];
    totalPrice = double.parse(json['total_price'].toString()) ?? 0.0;
    userID = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['price'] = this.price;
    data['food_id'] = this.foodId;
    data['name'] = this.name;
    data['ingredients'] = this.ingredients;
    data['img_thumbnail'] = this.imgThumbnail;
    data['order_datetime'] = this.orderDatetime;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    data['user_id'] = this.userID;
    return data;
  }
}

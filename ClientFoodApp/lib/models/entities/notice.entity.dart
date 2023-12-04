class Notice {
  DateTime noticesDatetime;
  String noticesMessage;
  String foodImage;
  String foodName;
  int quantity;
  int orderId;

  Notice({
    required this.noticesDatetime,
    required this.noticesMessage,
    required this.foodImage,
    required this.foodName,
    required this.quantity,
    required this.orderId,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      noticesDatetime: DateTime.parse(json['notices_datetime']),
      noticesMessage: json['notices_message'],
      foodImage: json['food_image'],
      foodName: json['food_name'],
      quantity: json['quantity'],
      orderId: json['order_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notices_datetime': noticesDatetime.toIso8601String(),
      'notices_message': noticesMessage,
      'food_image': foodImage,
      'food_name': foodName,
      'quantity': quantity,
      'order_id': orderId,
    };
  }
}

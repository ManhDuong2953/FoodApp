class Notice {
  int? id;
  int? userId;
  String? titleNotifi;
  String? noticesMessage;
  DateTime? noticesDatetime;

  Notice(
      {this.id,
      this.userId,
      this.titleNotifi,
      this.noticesMessage,
      this.noticesDatetime});

  Notice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    titleNotifi = json['title_notifi'];
    noticesMessage = json['notices_message'];
    noticesDatetime = DateTime.parse(json['notices_datetime']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title_notifi'] = titleNotifi;
    data['notices_message'] = noticesMessage;
    data['notices_datetime'] = noticesDatetime;
    return data;
  }
}

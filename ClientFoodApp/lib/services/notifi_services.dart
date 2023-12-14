import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  // Singleton instance
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  // Initialize the plugin
  Future<void> initialize() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    var androidInitialize = AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Show big text notification
  Future<void> showBigTextNotification({
    required String title,
    required String body,
    int id = 0,
    Object? payload,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'notification_order',
      'foodapp',
      importance: Importance.max,
      priority: Priority.high,
    );

    var notificationDetails =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
        id, title, body, notificationDetails);
  }
}

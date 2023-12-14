import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';

import '../services/notifi_services.dart';

class ApiFCM {
  static Future<String?> getFirebaseMessagingToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    try {
      await messaging.requestPermission();
      String? token = await messaging.getToken();
      return token;
    } catch (e) {
      print("Error getting FCM token: $e");
      return null;
    }
  }

  static Future<void> sendPushNotification(
      String token, String title, String bodyText) async {
    try {
      final requestBody = {
        "to": token,
        "notification": {
          "title": title,
          "body": bodyText,
          "android_channel_id": "notifications",
        },
      };

      var res = await post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'key=AAAA9F98iiY:APA91bGon9DUumqnu8fm9BSC_ClpdJ-nEY9IuGFKuj5m7UYHMsGcXprb52cAV0Nldotcz7Wo71UnC8WiIv9dRMbRHijhR-fJfEHGx_930aavQGTgRxcsaPsV93UDmjePCyEiYmxGroTP',
        },
        body: jsonEncode(requestBody),
      );
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
    } catch (e) {
      print('\nsendPushNotificationE: $e');
    }
  }

  static void initializeFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        NotificationService().showBigTextNotification(
          title: message.notification!.title ?? "",
          body: message.notification!.body ?? "",
        );
      }
    });
  }
}

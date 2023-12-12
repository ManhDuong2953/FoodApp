import 'package:firebase_messaging/firebase_messaging.dart';

class ApiFCM {
  static Future<String?> getFirebaseMessagingToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    try {
      String? token = await messaging.getToken();
      return token;
    } catch (e) {
      print("Error getting FCM token: $e");
      return null;
    }
  }
}

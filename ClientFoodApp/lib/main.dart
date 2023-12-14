import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodapp/api/fcm.dart';
import 'package:foodapp/screen/home_page/home_page.dart';
import 'package:foodapp/screen/login_page/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodapp/services/notifi_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD5r2KFzMl6DhG5rPhvs0NaMxF2-k8nqgU",
          appId: "1:1049574017574:android:e767488b8b0c64e28cb4e7",
          messagingSenderId: "1049574017574",
          projectId: "foodapp-177a2"));


  ApiFCM.initializeFirebaseMessaging();

  // Initialize the notification service
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();

  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return const MaterialApp(
      title: 'FoodApp - Ứng dụng bán đồ ăn nhanh',
      home: MyAppWrapper(),
    );
  }
}

class MyAppWrapper extends StatefulWidget {
  const MyAppWrapper({Key? key}) : super(key: key);

  @override
  _MyAppWrapperState createState() => _MyAppWrapperState();
}

class _MyAppWrapperState extends State<MyAppWrapper> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

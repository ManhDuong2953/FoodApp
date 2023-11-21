import 'package:flutter/material.dart';
import 'package:foodapp/HomePage/HomePage.dart';
import 'package:foodapp/LoginPage/LoginPage.dart';
import 'package:foodapp/OrderPage/OrderPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'FoodApp by Nhom2',
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

    // Delay for 3 seconds and then navigate to OrderScreen
    Future.delayed(const Duration(seconds: 3), () {
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

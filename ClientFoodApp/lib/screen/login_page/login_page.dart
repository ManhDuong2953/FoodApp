import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodapp/api/user.api.dart';
import 'package:foodapp/models/assets_dir/assets_direct.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/screen/search_page/search_page.dart';
import 'package:foodapp/screen/signup_page/signup_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/fcm.dart';
import '../../models/entities/user.entity.dart';
import '../../services/notifi_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _message = '';
  LoadStatus loadStatus = LoadStatus.success;
  User? user;

  Future<void> _login(context) async {
    user = User(
      phoneNumber: _phonenumberController.text,
      password: _passwordController.text,
    );

    try {
      String apiUrl = ApiUser.postLoginEndpoint;
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user?.toJson()),
      );
      setState(() {
        loadStatus = LoadStatus.loading;
      });
      var resBody = json.decode(response.body);
      if (response.statusCode == 200) {
        var idUser = resBody['data']['id'].toString();
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('idUser', idUser);

        setState(() {
          loadStatus = LoadStatus.success;
        });
        await NotificationService().showBigTextNotification(
          title: "Đăng nhập thành công",
          body:
              "Chào ${resBody['data']['name'] ?? 'bạn'}, chúc mừng bạn đã đăng nhập thành công. Hãy đặt món thỏa thích cùng FoodApp với những voucher cực hấp dẫn nhé",
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchPage(),
          ),
        );

        // String userId = prefs.getString('idUser') ?? '';
      } else {
        setState(() {
          loadStatus = LoadStatus.failure;
          _message = resBody['message'].toString();
        });
      }
    } catch (e) {
      setState(() {
        loadStatus = LoadStatus.failure;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(assetsDirect.bgLogin),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color.fromRGBO(0, 0, 0, 0.4),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(assetsDirect.logoFoodPanda),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _phonenumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone number',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "$_message",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                            left: 10,
                          ),
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                _login(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: assetsDirect.homeColor,
                              ),
                              child: loadStatus == LoadStatus.loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text('Login'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: assetsDirect.homeColor,
                        ),
                        child: const Text('Sign up'),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            String? token =
                                await ApiFCM.getFirebaseMessagingToken();

                            ApiFCM.sendPushNotification(
                                token!, "title", "bodyText");
                          },
                          child: Text("click"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

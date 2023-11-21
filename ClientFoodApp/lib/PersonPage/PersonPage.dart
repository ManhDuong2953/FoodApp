import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapp/BottomBar/BottomBar.dart';
import 'package:foodapp/OrderHistoryPage/OrderHistoryPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  int selectedTab = 5;

  void changeTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  Map<String, dynamic> _data = {};
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? IDUser = prefs.getString('IDUser') ?? '';
    final response =
        await http.get(Uri.parse('http://10.0.2.2:2953/users/info/$IDUser'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data
      final Map<String, dynamic> data = jsonDecode(response.body)["data"];
      setState(() {
        _data = data;
      });
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/bgPerson.png'), // Hình ảnh PNG
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Color.fromRGBO(219, 22, 110, 1),
                    BlendMode.multiply,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "assets/images/settings.png",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            // _data["avatar_thumbnail"] ??
                            'https://static.vecteezy.com/system/resources/previews/000/425/647/original/avatar-icon-vector-illustration.jpg'),
                        radius: 35,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _data["name"],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            _data["phone_number"],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                const Divider(
                  color: Color.fromRGBO(239, 239, 239, 1),
                  thickness: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderHistoryScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/order.png"),
                                ),
                              ),
                              child: Image.asset("assets/images/OrderIcon.png"),
                            ),
                            const Text(
                              "Orders History",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Image.asset("assets/images/chevronRight.png")
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Color.fromRGBO(239, 239, 239, 1),
                  thickness: 20,
                ),
              ],
            ),
          ),
          BottomBar(tab: selectedTab, changeTab: changeTab)
        ],
      ),
    );
  }
}

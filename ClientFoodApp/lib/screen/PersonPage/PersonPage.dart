import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/api/user.api.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/widgets/BottomBar/BottomBar.dart';
import 'package:foodapp/screen/LoginPage/LoginPage.dart';
import 'package:foodapp/screen/OrderHistoryPage/OrderHistoryPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/entities/user.entity.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  int selectedTab = 5;
  LoadStatus loadStatus = LoadStatus.loading;

  void changeTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  User? userEntity;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getString('idUser') ?? '';
      String apiUrl = ApiUser.getUserEndpoint(int.parse(idUser));
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON data
        final Map<String, dynamic> data = jsonDecode(response.body)["data"];
        setState(() {
          userEntity = User.fromJson(data);
          loadStatus = LoadStatus.success;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        loadStatus = LoadStatus.failure;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          loadStatus == LoadStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : loadStatus == LoadStatus.failure
                  ? const Center(child: Text("No food available"))
                  : Expanded(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(25),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/bgPerson.png'), // Hình ảnh PNG
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
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${userEntity?.avatarThumbnail}" ??
                                          'https://e7.pngegg.com/pngimages/321/641/png-clipart-load-the-map-loading-load.png'),
                                  radius: 35,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${userEntity?.name}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      '${userEntity?.phoneNumber}',
                                      style: const TextStyle(
                                          color: Color.fromRGBO(
                                              222, 219, 219, 1.0),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '${userEntity?.address}',
                                      style: const TextStyle(
                                          color: Color.fromRGBO(
                                              222, 219, 219, 1.0),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
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
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Log out",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
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

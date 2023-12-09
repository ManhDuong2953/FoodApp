import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/api/user.api.dart';
import 'package:foodapp/models/assets_direct.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/screen/update_profile/update_profile.dart';
import 'package:foodapp/widgets/bottom_bar/bottom_bar.dart';
import 'package:foodapp/screen/login_page/login_page.dart';
import 'package:foodapp/screen/order_history_page/order_history_page.dart';
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
      body: loadStatus == LoadStatus.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : loadStatus == LoadStatus.failure
              ? const Center(child: Text("No data available"))
              : Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(25),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                assetsDirect.bgPerson), // Hình ảnh PNG
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
                                  assetsDirect.settings,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${userEntity?.avatarThumbnail}" ??
                                          assetsDirect.errAvt),
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
                                  builder: (context) =>
                                      const UpdateProfileScreen(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 47,
                                        height: 47,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              assetsDirect.bgUser),
                                          ),
                                        ),
                                        child: Image.asset(
                                            assetsDirect.users),
                                      ),
                                      const Text(
                                        "Edit Profile",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(assetsDirect.chevronRight)
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            color: Color.fromRGBO(239, 239, 239, 1),
                            thickness: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OrderHistoryScreen(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 47,
                                        height: 47,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                assetsDirect.order),
                                          ),
                                        ),
                                        child: Image.asset(
                                            assetsDirect.orderIcon),
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
                                  Image.asset(assetsDirect.chevronRight)
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 47,
                                        height: 47,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                assetsDirect.bgLogout),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            assetsDirect.logoutIcon,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "Logout",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(assetsDirect.chevronRight)
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
                  ],
                ),
      bottomNavigationBar: BottomBar(tab: selectedTab, changeTab: changeTab),
    );
  }
}

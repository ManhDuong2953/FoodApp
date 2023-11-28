import 'dart:convert';
import 'package:foodapp/api/user.api.dart';
import 'package:foodapp/models/entities/user.entity.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/screen/SearchFood/SearchFood.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  User? userEntity;
  LoadStatus loadStatus = LoadStatus.loading;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString('idUser') ?? '';
    final response =
        await http.get(Uri.parse(ApiUser.getUserEndpoint(int.parse(idUser))));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body)["data"];
      setState(() {
        loadStatus = LoadStatus.success;
        userEntity = User.fromJson(data);
      });
    } else {
      loadStatus = LoadStatus.failure;
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgsearch.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color.fromRGBO(0, 0, 0, 0.4),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: loadStatus == LoadStatus.loading
              ? const CircularProgressIndicator()
              : ListView(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 42,
                          left: 25,
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: userEntity?.avatarThumbnail != null
                                  ? Image.network(
                                      '${userEntity?.avatarThumbnail}',
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/errorAvt.png",
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                              ),
                              child: Text(
                                "Hi, ${userEntity?.name}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                        )),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 94,
                        left: 25,
                        right: 25,
                      ),
                      child: SizedBox(
                        width: 314,
                        height: 163,
                        child: Text(
                          "What can we serve you today?",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchFoodScreen()),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.search,
                                          color: Colors.grey),
                                      const SizedBox(width: 8.0),
                                      const Expanded(
                                        child: Text(
                                          "Search for address, food...",
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                138, 138, 138, 1),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      SvgPicture.asset(
                                          "assets/vectors/locationSVGIcon.svg"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

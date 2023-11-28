import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/api/food.api.dart';
import 'package:foodapp/widgets/BottomBar/BottomBar.dart';
import 'package:foodapp/screen/SearchFood/SearchFood.dart';
import 'package:foodapp/widgets/ItemListFavorite/ItemListFavorite.dart';
import 'package:http/http.dart' as http;

import '../../models/entities/food.entity..dart';

class FavoritePageScreen extends StatefulWidget {
  const FavoritePageScreen({super.key});

  @override
  State<FavoritePageScreen> createState() => _FavoritePageScreenState();
}

class _FavoritePageScreenState extends State<FavoritePageScreen> {
  int selectedTab = 3;
  List<Food> foodEntity = [];

  Future<void> fetchData() async {
    try {
      String apiUrl = ApiFood.getRecommendEndpoint;
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonDecode(response.body)["data"]);

        setState(() {
          foodEntity = data.map((item) => Food.fromJson(item)).toList();
        });
      } else {
        setState(() {
          // _data = [];
        });
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void changeTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 75,
            color: const Color.fromRGBO(219, 22, 110, 1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchFoodScreen(),
                          ),
                        );
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchFoodScreen(),
                            ),
                          );
                        },
                        child:
                            SvgPicture.asset("assets/vectors/searchIcon.svg"),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 20,
                    child: Text(
                      "THE MOST FAVORITES",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color.fromRGBO(250, 240, 240, 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: foodEntity.length,
                  itemBuilder: (BuildContext context, int index) {
                    final itemFavorite = foodEntity[index];
                    return ItemListFavorites(
                      id: itemFavorite.id!,
                      name: itemFavorite.name!,
                      price: itemFavorite.price!,
                      ingredients: itemFavorite.ingredients!,
                      description: itemFavorite.description!,
                      imgThumbnail: itemFavorite.ingredients!,
                      totalOrders: itemFavorite.totalOrders!,
                      averageRating: itemFavorite.averageRating!,
                      totalReviews: itemFavorite.totalReviews!,
                    );
                  },
                ),
              ),
            ),
          ),
          BottomBar(tab: selectedTab, changeTab: changeTab)
        ],
      ),
    );
  }
}

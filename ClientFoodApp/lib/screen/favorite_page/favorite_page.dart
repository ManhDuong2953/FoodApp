import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/api/food.api.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/widgets/bottom_bar/bottom_bar.dart';
import 'package:foodapp/screen/search_food/search_food.dart';
import 'package:foodapp/widgets/item_list_favorite/item_list_favorite.dart';
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
  LoadStatus loadStatus = LoadStatus.loading;

  Future<void> fetchData() async {
    try {
      String apiUrl = ApiFood.getRecommendEndpoint;
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonDecode(response.body)["data"]);

        if (data.isNotEmpty) {
          setState(() {
            loadStatus = LoadStatus.success;
            foodEntity = data.map((item) => Food.fromJson(item)).toList();
          });
        } else {
          print("không có data");
          throw Exception('Failed to load data');
        }
      } else {
        print("Lỗi 404");

        throw Exception('Failed to load data');
      }
    } catch (error) {
      print("Lỗi fetch: $error");

      setState(() {
        loadStatus = LoadStatus.failure;
      });
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
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "THE MOST FAVORITES",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: loadStatus == LoadStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : loadStatus == LoadStatus.failure
                    ? const Center(child: Text("No food available"))
                    : Container(
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
                                imgThumbnail: itemFavorite.imgThumbnail!,
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

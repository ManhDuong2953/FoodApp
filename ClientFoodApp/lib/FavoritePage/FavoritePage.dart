import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/BottomBar/BottomBar.dart';
import 'package:foodapp/DetailProductPage/DetailProductPage.dart';
import 'package:foodapp/SearchFood/SearchFood.dart';
import 'package:http/http.dart' as http;

class FavoritePageScreen extends StatefulWidget {
  const FavoritePageScreen({super.key});

  @override
  State<FavoritePageScreen> createState() => _FavoritePageScreenState();
}

class _FavoritePageScreenState extends State<FavoritePageScreen> {
  int selectedTab = 3;
  List<Map<String, dynamic>> _data = [];

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:2953/foods/recommend'),
      );

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonDecode(response.body)["data"]);
        setState(() {
          _data = data;
        });
      } else {
        setState(() {
          _data = [];
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
    print('initState: Calling fetchData');
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
                          child: SvgPicture.asset(
                              "assets/vectors/searchIcon.svg")),
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
                  itemCount: _data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final itemFavorite = _data[index];
                    return ItemListFavorites(
                      id: (itemFavorite["id"]),
                      name: itemFavorite["name"],
                      price: itemFavorite["price"],
                      ingredients: itemFavorite["ingredients"],
                      description: itemFavorite["description"],
                      imgThumbnail: itemFavorite["img_thumbnail"],
                      totalOrders: (itemFavorite["total_orders"]) ?? "0",
                      averageRating:
                          double.parse(itemFavorite["average_rating"] ?? "0.0"),
                      totalReviews: (itemFavorite["total_reviews"]) ?? 0,
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

class ItemListFavorites extends StatelessWidget {
  final int id;
  final String name;
  final String price;
  final String ingredients;
  final String description;
  final String imgThumbnail;
  final String totalOrders;
  final double averageRating;
  final int totalReviews;

  const ItemListFavorites({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.ingredients,
    required this.description,
    required this.imgThumbnail,
    required this.totalOrders,
    required this.averageRating,
    required this.totalReviews,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailProductScreen(idProduct: id)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(255, 214, 214, 0.8),
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                color: Color.fromARGB(255, 220, 139, 139),
                child: Image.network(
                  imgThumbnail,
                  width: double.infinity,
                  height: 174,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                      child: Text(
                        ingredients,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Color.fromRGBO(95, 95, 95, 1),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                      child: Text(
                        "\$ $price",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Color.fromRGBO(219, 22, 110, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 5; i++)
                          Icon(
                            i < (averageRating ?? 0.0).round()
                                ? Icons.star
                                : Icons.star_border,
                            color: i < (averageRating ?? 0.0).round()
                                ? ((averageRating ?? 0.0) - i >= 0.5)
                                    ? Colors.red
                                    : const Color.fromARGB(255, 255, 88, 88)
                                : Colors.red,
                            size: 16,
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "${totalReviews.toString()} reviews",
                            style: const TextStyle(
                              color: Color.fromRGBO(96, 96, 96, 1),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

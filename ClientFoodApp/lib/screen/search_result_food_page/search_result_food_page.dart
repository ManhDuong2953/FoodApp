import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/api/food.api.dart';
import 'package:foodapp/models/assets_direct.dart';
import 'package:foodapp/models/entities/food.entity..dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/widgets/item_list_result_food/item_list_result_food.dart';
import 'package:http/http.dart' as http;
import '../search_food/search_food.dart';

class SearchResultFoodScreen extends StatefulWidget {
  final String keyword;

  const SearchResultFoodScreen({Key? key, required this.keyword})
      : super(key: key);

  @override
  State<SearchResultFoodScreen> createState() => _SearchResultFoodScreenState();
}

class _SearchResultFoodScreenState extends State<SearchResultFoodScreen> {
  List<Food> foodList = [];
  LoadStatus loadStatus = LoadStatus.loading;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      String urlAPI = ApiFood.postSearchEndpoint;
      final response = await http.post(
        Uri.parse(urlAPI),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "keyword": widget.keyword,
        },
      );

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonDecode(response.body)["data"]);
        if (data.isNotEmpty) {
          setState(() {
            foodList = data.map((item) => Food.fromJson(item)).toList();
            loadStatus = LoadStatus.success;
          });
        } else {
          throw Exception('Failed to load data');
        }
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
    final keywordSearch = widget.keyword ?? "''";

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 85,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(219, 22, 110, 1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        assetsDirect.arrowLeft,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchFoodScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.search, color: Colors.grey),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              'Search for address, food...',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color.fromRGBO(172, 20, 88, 1),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              children: [
                const Text(
                  "Results for ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "'$keywordSearch' (${foodList.length} results)",
                  style: const TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: loadStatus == LoadStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                : loadStatus == LoadStatus.failure
                    ? const Center(child: Text("No food available"))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: foodList.length,
                        itemBuilder: (context, index) {
                          final foodItem = foodList[index];
                          return ItemListResultFood(
                            key: UniqueKey(),
                            id: foodItem.id!,
                            name: foodItem.name!,
                            description: foodItem.description!,
                            ingredients: foodItem.ingredients!,
                            imageUrl: foodItem.imgThumbnail!,
                            avgRate: foodItem.averageRating!,
                            totalReview: foodItem.totalReviews!,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

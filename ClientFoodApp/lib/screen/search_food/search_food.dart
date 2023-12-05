import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/api/food.api.dart';
import 'package:foodapp/models/entities/food.entity..dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/widgets/bottom_bar/bottom_bar.dart';
import 'package:foodapp/widgets/item_list_recommend_food/item_list_recommend_food.dart';
import 'package:http/http.dart' as http;
import '../search_result_food_page/search_result_food_page.dart';

class SearchFoodScreen extends StatefulWidget {
  const SearchFoodScreen({Key? key});

  @override
  State<SearchFoodScreen> createState() => _SearchFoodScreenState();
}

class _SearchFoodScreenState extends State<SearchFoodScreen> {
  final TextEditingController _keywordSearch = TextEditingController();
  int selectedTab = 1;
  List<Food> foodList = [];
  LoadStatus loadStatus = LoadStatus.loading;

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

  Future<void> fetchData() async {
    try {
      String apiUrl = ApiFood.getAllFoodEndpoint;
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonDecode(response.body)["data"]);

        if (data.isNotEmpty) {
          setState(() {
            loadStatus = LoadStatus.success;
            foodList = data.map((item) => Food.fromJson(item)).toList();
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
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSearchBar(),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: const Text(
              "RECOMMENDED FOR YOU",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(155, 155, 155, 1),
              ),
            ),
          ),
          loadStatus == LoadStatus.loading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : loadStatus == LoadStatus.success
                  ? _buildRecommendationsList()
                  : const Expanded(
                      child: Center(child: Text("No food available"))),
          BottomBar(tab: selectedTab, changeTab: changeTab),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 100,
      color: const Color.fromRGBO(219, 22, 110, 1),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 13),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: TextField(
                controller: _keywordSearch,
                // autofocus: true,
                onSubmitted: (String keywordSearch) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchResultFoodScreen(keyword: keywordSearch),
                    ),
                  );
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search for address, food...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationsList() {
    return Expanded(
      child: Container(
        color: const Color.fromRGBO(250, 240, 240, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: ListView.builder(
              itemCount: foodList.length, // +1 for the recommended header
              itemBuilder: (context, index) {
                final recommendedFood = foodList[foodList.length - index - 1];
                return ItemListRecommendFood(
                  id: recommendedFood.id!,
                  name: recommendedFood.name!,
                  description: recommendedFood.description!,
                  ingredients: recommendedFood.ingredients!,
                  imageUrl: recommendedFood.imgThumbnail!,
                  avgRate: recommendedFood.averageRating!,
                  totalReviews: recommendedFood.totalReviews!,
                );
              }
              // },
              ),
        ),
      ),
    );
  }
}

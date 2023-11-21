import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/BottomBar/BottomBar.dart';
import 'package:foodapp/DetailProductPage/DetailProductPage.dart';
import 'package:http/http.dart' as http;
import '../SearchResultFoodPage/SearchResultFoodPage.dart';

class SearchFoodScreen extends StatefulWidget {
  const SearchFoodScreen({Key? key});

  @override
  State<SearchFoodScreen> createState() => _SearchFoodScreenState();
}

class _SearchFoodScreenState extends State<SearchFoodScreen> {
  final TextEditingController _keywordSearch = TextEditingController();
  int selectedTab = 1;
  List<Map<String, dynamic>> _data = [];

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
      final response = await http.get(
        Uri.parse('http://10.0.2.2:2953/foods'),
      );

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonDecode(response.body)["data"]);

        if (data.isNotEmpty) {
          setState(() {
            _data = data;
            print('Nội dung phản hồi: $_data}');
          });
        } else {
          print('Received empty data array');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSearchBar(),
          _buildRecommendationsList(),
          BottomBar(tab: selectedTab, changeTab: changeTab),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 91,
      color: const Color.fromRGBO(219, 22, 110, 1),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 13),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: TextField(
                controller: _keywordSearch,
                autofocus: true,
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
              itemCount: _data.length + 1, // +1 for the recommended header
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Display the recommended header
                  return const Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Text(
                      "RECOMMENDED FOR YOU",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(155, 155, 155, 1),
                      ),
                    ),
                  );
                } else {
                  // Display the recommended food items
                  final recommendedFood = _data[index - 1];
                  return ItemListRecommendFood(
                    id: recommendedFood['id'],
                    name: recommendedFood['name'],
                    description: recommendedFood['description'],
                    ingredients: recommendedFood['ingredients'],
                    imageUrl: recommendedFood['img_thumbnail'],
                    avgRate:
                        double.parse(recommendedFood['average_rating'] ?? '0'),
                    totalReviews: recommendedFood['total_reviews'] ?? 0,
                  );
                }
              },
            )),
      ),
    );
  }
}

class ItemListRecommendFood extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final String ingredients;
  final String imageUrl;
  final double avgRate;
  final int totalReviews;

  const ItemListRecommendFood({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.imageUrl,
    required this.avgRate,
    required this.totalReviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProductScreen(
              idProduct: id,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              height: 60,
                              width: 60,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              ingredients,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: const TextStyle(
                                color: Color.fromRGBO(95, 95, 95, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              for (int i = 0; i < 5; i++)
                                Icon(
                                  i < avgRate.round()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: i < avgRate.round()
                                      ? (avgRate - i >= 0.5)
                                          ? Colors.red
                                          : const Color.fromARGB(
                                              255, 255, 88, 88)
                                      : Colors.red,
                                  size: 16,
                                ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "$totalReviews reviews",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 88, 88, 88),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Color.fromRGBO(198, 198, 198, 0.8),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

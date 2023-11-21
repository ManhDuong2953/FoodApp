import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../DetailProductPage/DetailProductPage.dart';
import '../SearchFood/SearchFood.dart';

class SearchResultFoodScreen extends StatefulWidget {
  final String keyword;

  const SearchResultFoodScreen({Key? key, required this.keyword})
      : super(key: key);

  @override
  State<SearchResultFoodScreen> createState() => _SearchResultFoodScreenState();
}

class _SearchResultFoodScreenState extends State<SearchResultFoodScreen> {
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:2953/foods/search'),
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
  Widget build(BuildContext context) {
    final keywordSearch = widget.keyword ?? "''";

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(219, 22, 110, 1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        "assets/images/arrow-left.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
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
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  'Search for address, food...',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color.fromRGBO(172, 20, 88, 1),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                const Text(
                  "Results for ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  keywordSearch,
                  style: const TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _data.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      final foodItem = _data[index];
                      return ItemListResultFood(
                        key: UniqueKey(),
                        id: int.parse(foodItem['id'].toString()),
                        name: foodItem['name'].toString(),
                        description: foodItem['description'].toString(),
                        ingredients: foodItem['ingredients'].toString(),
                        imageUrl: foodItem['img_thumbnail'].toString(),
                        avgRate: (foodItem["average_rating"] != null)
                            ? double.parse(
                                foodItem["average_rating"].toString())
                            : 0.0,
                        totalReview:
                            int.parse(foodItem["total_reviews"].toString()) ??
                                0,
                      );
                    },
                  )
                : const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("No results available"),
                  ),
          ),
        ],
      ),
    );
  }
}

class ItemListResultFood extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final String ingredients;
  final String imageUrl;
  final double avgRate;
  final int totalReview;

  ItemListResultFood({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.imageUrl,
    required this.avgRate,
    required this.totalReview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailProductScreen(idProduct: id),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 220, 139, 139),
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 204, 204, 204),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          ingredients,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(95, 95, 95, 1),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  "$totalReview reviews",
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color.fromRGBO(134, 134, 134, 1),
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}

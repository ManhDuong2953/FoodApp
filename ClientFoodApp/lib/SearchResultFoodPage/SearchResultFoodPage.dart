import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/SearchFood/SearchFood.dart';
import 'package:http/http.dart' as http;

class SearchResultFoodScreen extends StatefulWidget {
  final String? keyword;

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
            "keyword": "${widget.keyword}",
          });
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON data
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonDecode(response.body)["data"]);

        setState(() {
          _data = data;
        });
      } else {
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
                Expanded(
                  flex: 1,
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
                  flex: 7,
                  child: TextField(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchFoodScreen()));
                    },
                    decoration: InputDecoration(
                      filled: true,
                      enabled: false,
                      // không cho input
                      fillColor: Colors.white,
                      hintText: 'Search for address, food...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color.fromRGBO(172, 20, 88, 1),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              "Results for '$keywordSearch'",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final foodItem = _data[index];
                return ItemListResultFood(
                  id: foodItem['id'],
                  name: foodItem['name'],
                  description: foodItem['description'],
                  ingredients: foodItem['ingredients'],
                  imageUrl: foodItem['img_thumbnail'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ItemListResultFood extends StatelessWidget {
  final int? id;
  final String? name;
  final String? description;
  final String? ingredients;
  final String? imageUrl;

  const ItemListResultFood({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: InkWell(
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
                        "$imageUrl",
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "$name",
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
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "$ingredients",
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
                          SvgPicture.asset(
                            "assets/vectors/star_solid.svg",
                            width: 12,
                            height: 12,
                          ),
                          SvgPicture.asset(
                            "assets/vectors/star_solid.svg",
                            width: 12,
                            height: 12,
                          ),
                          SvgPicture.asset(
                            "assets/vectors/star_solid.svg",
                            width: 12,
                            height: 12,
                          ),
                          SvgPicture.asset(
                            "assets/vectors/star_solid.svg",
                            width: 12,
                            height: 12,
                          ),
                          SvgPicture.asset(
                            "assets/vectors/star_solid.svg",
                            width: 12,
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "443 reviews",
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/api/food.api.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/screen/OrderPage/OrderPage.dart';
import 'package:foodapp/widgets/ReviewItem/ReviewItem.dart';
import 'package:foodapp/widgets/Star/Star.dart';
import 'package:http/http.dart' as http;

import '../../models/entities/food.entity..dart';

class DetailProductScreen extends StatefulWidget {
  final int? idProduct;

  const DetailProductScreen({super.key, required this.idProduct});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  Food? foodEntity;
  LoadStatus foodLoadStatus = LoadStatus.loading;
  LoadStatus reviewLoadStatus = LoadStatus.loading;

  List<Map<String, dynamic>> _review = [];
  late int _idProduct;

  @override
  void initState() {
    super.initState();
    _idProduct = widget.idProduct!;
    fetchReview();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      String apiUrl = ApiFood.getFoodEndpoint(_idProduct);
      final response = await http.get(Uri.parse(apiUrl));
      await Future.delayed(Duration(seconds: 3));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)["data"];
        setState(() {
          foodEntity = Food.fromJson(data);
          foodLoadStatus = LoadStatus.success;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        foodLoadStatus = LoadStatus.failure;
      });
    }
  }

  Future<void> fetchReview() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://food-app-server-murex.vercel.app/reviews/food_id/$_idProduct'),
      );
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON data
        final List<Map<String, dynamic>> review =
            List<Map<String, dynamic>>.from(
                    jsonDecode(response.body)["data"]) ??
                [];

        setState(() {
          _review = review;
        });
      } else {
        setState(() {
          _review = [];
        });
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
          Expanded(
            child: foodLoadStatus == LoadStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : foodLoadStatus == LoadStatus.failure
                    ? const Center(child: Text("No food available"))
                    : ListView(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            height: 290,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("${foodEntity?.imgThumbnail}" ??
                                    "https://e7.pngegg.com/pngimages/321/641/png-clipart-load-the-map-loading-load.png"),
                                // Update the image path
                                fit: BoxFit
                                    .contain, // Use BoxFit.cover to fill the container
                              ),
                              color: const Color.fromARGB(255, 173, 8, 8),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                      padding: const EdgeInsets.all(17),
                                      child: Image.asset(
                                          "assets/images/arrow-left.png"))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 17,
                              left: 17,
                              right: 17,
                              bottom: 4,
                            ),
                            child: Text(
                              "${foodEntity?.name}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 17,
                            ),
                            child: Row(
                              children: [
                                StarRate(rate: foodEntity?.averageRating),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    "${foodEntity?.totalReviews} reviews",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(147, 147, 147, 1),
                                        fontSize: 13),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17, vertical: 10),
                            child: Text(
                              "\$${foodEntity?.price}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color.fromRGBO(219, 22, 110, 1),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(17, 5, 17, 17),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 4.0),
                                      child: Text(
                                        "Opening:",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "6:00am - 22:00pm",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(147, 147, 147, 1)),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 50),
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(219, 22, 110, 1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderScreen(
                                                        idProduct:
                                                            foodEntity!.id)));
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'BOOKING NOW',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 17.0),
                            child: Divider(
                              color: Color.fromRGBO(243, 243, 243, 1),
                              thickness: 14,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(17, 5, 17, 17),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Description",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(147, 147, 147, 1)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    "${foodEntity?.description}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 10,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 17.0),
                            child: Divider(
                              color: Color.fromRGBO(243, 243, 243, 1),
                              thickness: 14,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(17, 5, 17, 17),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Service criteria:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 180, 30, 0)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    " ❣ Food quality: The food should be fresh, well-prepared, and flavorful.\n ❣ Service: The service should be friendly, attentive, and efficient.\n ❣ Ambiance: The atmosphere should be inviting and comfortable.\n ❣ Value: The price should be reasonable for the quality of food and service.",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 10,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromARGB(255, 206, 48, 16)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 17.0),
                            child: Divider(
                              color: Color.fromRGBO(243, 243, 243, 1),
                              thickness: 14,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 17),
                            child: Text("Reviews",
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                          Column(
                            children: [
                              if (_review.isNotEmpty)
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _review.length,
                                  itemBuilder: (context, index) {
                                    final itemReview = _review[index];
                                    return ReviewItem(
                                      name: itemReview['name'].toString() ??
                                          "FoodApp user",
                                      avatarThumbnail:
                                          // itemReview['avatar_thumbnail'] ??
                                          "https://i.pinimg.com/originals/63/f8/fb/63f8fbab7ef0b960dff3913c0c27a9e1.jpg",
                                      reviewsDatetime: DateTime.parse(
                                          itemReview['reviews_datetime']),
                                      rate: itemReview['rate'] ?? 0,
                                      comment:
                                          itemReview['comment'].toString() ??
                                              "Comment has been deleted",
                                    );
                                  },
                                )
                              else
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text("No reviews available"),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}

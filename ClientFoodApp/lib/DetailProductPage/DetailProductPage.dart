import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/OrderPage/OrderPage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailProductScreen extends StatefulWidget {
  final int? idProduct;

  const DetailProductScreen({super.key, required this.idProduct});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  Map<String, dynamic> _data = {};
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
      final response = await http.get(
        Uri.parse('http://10.0.2.2:2953/foods/find/$_idProduct'),
      );
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON data
        final Map<String, dynamic> data = jsonDecode(response.body)["data"];
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

  Future<void> fetchReview() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:2953/reviews/food_id/$_idProduct'),
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
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: 290,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${_data['img_thumbnail']}"),
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
                            child:
                                Image.asset("assets/images/arrow-left.png"))),
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
                    _data["name"],
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
                      for (int i = 0; i < 5; i++)
                        Icon(
                          i <
                                  double.parse(_data["average_rating"] ?? "0")
                                      .round()
                              ? Icons.star
                              : Icons.star_border,
                          color: i <
                                  double.parse(_data["average_rating"] ?? "0")
                                      .round()
                              ? (double.parse(_data["average_rating"] ?? "0") -
                                          i >=
                                      0.5)
                                  ? Colors.red
                                  : const Color.fromARGB(255, 255, 88, 88)
                              : Colors.red,
                          size: 16,
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "${_data['total_reviews']} reviews",
                          style: const TextStyle(
                              color: Color.fromRGBO(147, 147, 147, 1),
                              fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                  child: Text(
                    "\$${_data['price']}",
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
                                color: Color.fromRGBO(147, 147, 147, 1)),
                          ),
                        ],
                      ),
                      const SizedBox(width: 50),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(219, 22, 110, 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OrderScreen(idProduct: _data["id"])));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'BOOKING NOW',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
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
                          _data["description"],
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
                              color: Color.fromARGB(255, 206, 48, 16)),
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
                            name:
                                itemReview['name'].toString() ?? "FoodApp user",
                            avatarThumbnail:
                                // itemReview['avatar_thumbnail'] ??
                                "https://i.pinimg.com/originals/63/f8/fb/63f8fbab7ef0b960dff3913c0c27a9e1.jpg",
                            reviewsDatetime:
                                DateTime.parse(itemReview['reviews_datetime']),
                            rate: itemReview['rate'] ?? 0,
                            comment: itemReview['comment'].toString() ??
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

class ReviewItem extends StatelessWidget {
  final String name;
  final String avatarThumbnail;
  final DateTime reviewsDatetime;
  final int rate;
  final String comment;

  const ReviewItem({
    super.key,
    required this.name,
    required this.avatarThumbnail,
    required this.reviewsDatetime,
    required this.rate,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Color.fromRGBO(220, 220, 220, 0.7),
          thickness: 0.8,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(17, 10, 17, 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: ClipOval(
                  child: Image.network(
                    avatarThumbnail,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(children: [
                            for (int i = 0; i < 5; i++)
                              Icon(
                                i < rate ? Icons.star : Icons.star_border,
                                color: i < rate.round()
                                    ? (rate - i >= 0.5)
                                        ? Colors.red
                                        : const Color.fromARGB(255, 255, 88, 88)
                                    : Colors.red,
                                size: 16,
                              ),
                          ]),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            DateFormat('yyyy-MM-dd').format(reviewsDatetime),
                            style: const TextStyle(
                              color: Color.fromRGBO(95, 95, 95, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              comment,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: const TextStyle(
                                fontSize: 14,
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
      ],
    );
  }
}

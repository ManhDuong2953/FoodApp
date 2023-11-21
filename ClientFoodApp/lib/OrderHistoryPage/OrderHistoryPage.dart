import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/BottomBar/BottomBar.dart';
import 'package:foodapp/ReviewPage/ReviewInputScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../DetailProductPage/DetailProductPage.dart';
import '../SearchFood/SearchFood.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int selectedTab = 2;

  void changeTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  List<Map<String, dynamic>> _data = [];

  Future<void> fetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? IDUser = prefs.getString('IDUser') ?? '';
      final response = await http.get(
        Uri.parse('http://10.0.2.2:2953/orders/list/$IDUser'),
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
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 68,
            color: const Color.fromRGBO(219, 22, 110, 1),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchFoodScreen(),
                          ),
                        );
                      },
                      child: SvgPicture.asset("assets/vectors/searchIcon.svg")),
                  const Text(
                    "ORDER HISTORY",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Image.asset(
                    "assets/images/settings.png",
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color.fromRGBO(250, 240, 240, 1),
              child: _data.isNotEmpty
                  ? ListView.builder(
                      itemCount: _data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final itemOrder = _data[index];
                        return ListOrderHistory(
                          orderID: itemOrder['order_id'],
                          foodID: itemOrder['food_id'],
                          name: itemOrder['name'],
                          ingredients: itemOrder['ingredients'],
                          imageUrl: itemOrder['img_thumbnail'],
                          orderDatetime:
                              (itemOrder['order_datetime']).toString(),
                          quantity: itemOrder['quantity'],
                          price: double.parse(itemOrder['price']),
                          totalPrice: double.parse(itemOrder['total_price']),
                        );
                      },
                    )
                  : const Center(
                      child: Text('No order available'),
                    ),
            ),
          ),
          BottomBar(tab: selectedTab, changeTab: changeTab)
        ],
      ),
    );
  }
}

class ListOrderHistory extends StatelessWidget {
  final int orderID;
  final int foodID;
  final String name;
  final String ingredients;
  final String imageUrl;
  final String orderDatetime;
  final int quantity;
  final double price;
  final double totalPrice;

  // Constructor
  const ListOrderHistory({
    super.key,
    required this.orderID,
    required this.foodID,
    required this.name,
    required this.ingredients,
    required this.imageUrl,
    required this.orderDatetime,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white, // Màu nền của container
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(255, 214, 214, 0.8),
                  // Màu của shadow
                  offset: Offset(0, 2),
                  // Độ dịch chuyển của shadow (theo chiều ngang và chiều dọc)
                  blurRadius: 4,
                  // Độ mờ của shadow
                  spreadRadius: 4, // Phạm vi mở rộng của shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailProductScreen(idProduct: foodID),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            child: Image.network(
                              imageUrl,
                              height: 80,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 3, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  ingredients,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(149, 149, 149, 1)),
                                ),
                              ),
                              Text(
                                "\$ $price",
                                style: const TextStyle(
                                  color: Color.fromRGBO(219, 22, 110, 1),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: Text("x3"),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ReviewInputScreen(
                                                idFood:
                                                    foodID), // Replace ReviewScreen with your desired screen
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Rate",
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(219, 22, 110, 1),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    color: Color.fromRGBO(200, 200, 200, 1),
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/vectors/listIcon.svg'),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: Text(
                                      orderDatetime,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("\$ $totalPrice",
                              style: const TextStyle(
                                  color: Color.fromRGBO(219, 22, 110, 1),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

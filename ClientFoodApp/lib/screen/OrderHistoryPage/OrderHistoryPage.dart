import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/api/order.api.dart';
import 'package:foodapp/models/entities/order.entity.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/widgets/BottomBar/BottomBar.dart';
import 'package:foodapp/widgets/ListOrderHistory/ListOrderHistory.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../SearchFood/SearchFood.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int selectedTab = 2;
  List<Order> listHistory = [];
  LoadStatus loadStatus = LoadStatus.loading;

  void changeTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  Future<void> fetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getString('idUser') ?? '';

      String apiUrl = ApiOrder.getListEndpoint(int.parse(idUser));
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonDecode(response.body)["data"]);
        await Future.delayed(const Duration(seconds: 2));

        if (data.isNotEmpty) {
          setState(() {
            loadStatus = LoadStatus.success;
            listHistory = data.map((item) {
              final order = Order.fromJson(item);
              print("Order from JSON: $order");
              return order;
            }).toList();
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
              child: loadStatus == LoadStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : loadStatus == LoadStatus.failure
                      ? const Center(child: Text("No food available"))
                      : ListView.builder(
                          itemCount: listHistory.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final itemOrder = listHistory[index];
                            return ListOrderHistory(
                              orderID: itemOrder.orderId!,
                              foodID: itemOrder.foodId!,
                              name: itemOrder.name!,
                              ingredients: itemOrder.ingredients!,
                              imageUrl: itemOrder.imgThumbnail!,
                              orderDatetime: itemOrder.orderDatetime!,
                              quantity: itemOrder.quantity!,
                              price: itemOrder.price!,
                              totalPrice: itemOrder.totalPrice!,
                            );
                          },
                        ),
            ),
          ),
          BottomBar(tab: selectedTab, changeTab: changeTab)
        ],
      ),
    );
  }
}

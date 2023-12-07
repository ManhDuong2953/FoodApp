import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/api/food.api.dart';
import 'package:foodapp/api/order.api.dart';
import 'package:foodapp/models/entities/order.entity.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/screen/order_history_page/order_history_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/entities/food.entity..dart';

class OrderScreen extends StatefulWidget {
  final int? idProduct;

  const OrderScreen({
    Key? key,
    this.idProduct,
  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Food? foodEntity;
  Order? orderEntity;

  LoadStatus loadFoodStatus = LoadStatus.loading;
  LoadStatus loadOrderStatus = LoadStatus.success;

  double _totalPrice = 0;
  int? idUser;
  int _quantity = 1;
  int? _idProduct;

  @override
  void initState() {
    super.initState();
    _idProduct = widget.idProduct;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      String apiUrl = ApiFood.getFoodEndpoint(_idProduct!);
      final response = await http.get(
        Uri.parse(apiUrl),
      );
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON data
        final Map<String, dynamic> data = jsonDecode(response.body)["data"];
        setState(() {
          loadFoodStatus = LoadStatus.success;
          foodEntity = Food.fromJson(data);
          _totalPrice = foodEntity?.price ?? 0;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        loadFoodStatus = LoadStatus.failure;
      });
    }
  }

  final TextEditingController _quantityController = TextEditingController();

  Future<void> pushData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getString('idUser') ?? '';
      String apiUrlOrder = ApiOrder.postOrderEndpoint;
      setState(() {
        loadOrderStatus = LoadStatus.loading;
      });
      orderEntity = Order(
        foodId: _idProduct,
        userID: int.parse(idUser),
        quantity: _quantity,
        totalPrice: _totalPrice,
      );

      final response = await http.post(
        Uri.parse(apiUrlOrder),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode(orderEntity?.toJson()),
      );

      if (response.statusCode == 200) {
        setState(() {
          loadOrderStatus = LoadStatus.success;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const OrderHistoryScreen()));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        loadOrderStatus = LoadStatus.failure;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color.fromRGBO(219, 22, 110, 1),
            height: 75,
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/images/arrow-left.png"),
                ),
                const Text(
                  "ORDER CONFIRMATION AND PAYMENT",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 17),
                  child: Column(
                    children: [
                      loadFoodStatus == LoadStatus.loading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                          : loadFoodStatus == LoadStatus.failure
                              ? const Center(child: Text("No food available"))
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          child: Image.network(
                                            foodEntity?.imgThumbnail ??
                                                "https://e7.pngegg.com/pngimages/321/641/png-clipart-load-the-map-loading-load.png",
                                            fit: BoxFit.cover,
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            14, 3, 0, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${foodEntity?.name}",
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              child: Text(
                                                "${foodEntity?.ingredients}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      149, 149, 149, 1),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              child: Text(
                                                  "\$ ${foodEntity?.price}",
                                                  style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        219, 22, 110, 1),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              _quantity = int.parse(text);
                              _totalPrice =
                                  _quantity * (foodEntity?.price ?? 0) + 1.5;
                            });
                          },
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text("Enter quantity"),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      style: BorderStyle.solid))),
                        ),
                      ),
                      const Divider(
                        color: Color.fromRGBO(200, 200, 200, 1),
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Food price",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text("\$ ${foodEntity?.price}",
                                style: const TextStyle(
                                  color: Color.fromRGBO(219, 22, 110, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Quantity:",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text("x $_quantity",
                                style: const TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Shipping fee:",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text("\$ 1.5",
                                style: TextStyle(
                                  color: Color.fromRGBO(219, 22, 110, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Color.fromRGBO(200, 200, 200, 1),
                        thickness: 1.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "\$ $_totalPrice",
                                style: const TextStyle(
                                    color: Color.fromRGBO(219, 22, 110, 1),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/images/orderbg.png",
                  fit: BoxFit.cover,
                  height: 300,
                  alignment: Alignment.bottomCenter,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              pushData();
            },
            child: Container(
              height: 50,
              color: const Color.fromRGBO(219, 22, 110, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      loadOrderStatus == LoadStatus.loading
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white))
                          : loadOrderStatus == LoadStatus.success
                              ? const Text(
                                  'PAYMENT NOW',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )
                              : const Text(
                                  'ERROR SERVER! PLEASE BACK AGAIN',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

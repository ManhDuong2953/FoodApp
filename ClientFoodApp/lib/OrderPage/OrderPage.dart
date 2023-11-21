import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/OrderHistoryPage/OrderHistoryPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderScreen extends StatefulWidget {
  final int idProduct;

  const OrderScreen({
    Key? key,
    required this.idProduct,
  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String _message = 'Đang xử lý đơn hàng...';
  double _totalPrice = 0;
  int? idUser;
  int _quantity = 1;
  int? _idProduct;
  Map<String, dynamic> _data = {};

  @override
  void initState() {
    super.initState();
    _idProduct = widget.idProduct;
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
          _totalPrice = double.parse(_data["price"]);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  final TextEditingController _quantityController = TextEditingController();

  Future<void> pushData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? IDUser = prefs.getString('IDUser') ?? '';
    final Map<String, dynamic> dataReq = {
      "food_id": _idProduct,
      "user_id": int.parse(IDUser),
      "quantity": _quantity,
      "total_price": _totalPrice
    };

    final response = await http.post(
      Uri.parse('http://10.0.2.2:2953/orders/post_orders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(dataReq),
    );

    if (response.statusCode == 200) {
      setState(() {
        _message =
            "Your order has been placed, please wait for the carrier's call!";
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OrderHistoryScreen()));
    } else {
      setState(() {
        _message =
            "So sorry! Your order has been canceled due to an unknown error. Please re-order";
      });
      throw Exception('Failed to load data');
    }
  }

  //
  // double handlePrice(_quantity, _totalPrice){
  //   return double.parse(int.parse(_quantityController) * _totalPrice)
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color.fromRGBO(219, 22, 110, 1),
            height: 75,
            padding: EdgeInsets.symmetric(horizontal: 17),
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
          Text(
            _message,
            style: const TextStyle(color: Colors.red),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 17),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                child: Image.network(
                                  _data["img_thumbnail"],
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
                              padding: const EdgeInsets.fromLTRB(14, 3, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _data["name"],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      _data["ingredients"],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(149, 149, 149, 1),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Text("\$ ${_data['price']}",
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(219, 22, 110, 1),
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
                                  _quantity * double.parse(_data["price"]) +
                                      1.5;
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
                            Text("\$ ${_data['price']}",
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
          Container(
            height: 50,
            color: const Color.fromRGBO(219, 22, 110, 1),
            child: GestureDetector(
              onTap: () {
                pushData();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PAYMENT NOW',
                    style: TextStyle(color: Colors.white, fontSize: 14),
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/api/order.api.dart';
import 'package:foodapp/models/entities/notice.entity.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/widgets/bottom_bar/bottom_bar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedTab = 4;

  void changeTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  List<Notice> noticeList = [];
  LoadStatus loadStatus = LoadStatus.loading;

  Future<void> fetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getString('idUser') ?? '';
      String apiUrl = ApiOrder.getNoticeEndpoint(int.parse(idUser));
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonDecode(response.body)["data"]);

        if (data.isNotEmpty) {
          setState(() {
            loadStatus = LoadStatus.success;
            noticeList = data.map((item) => Notice.fromJson(item)).toList();
          });
        } else {
          print("không có data");
          throw Exception('Failed to load data');
        }
      } else {
        print("Lỗi 404");

        throw Exception('Failed to load data');
      }
    } catch (error) {
      print("Lỗi fetch: $error");

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
                  SvgPicture.asset("assets/vectors/searchIcon.svg"),
                  const Text(
                    "NOTIFICATION",
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
            child: loadStatus == LoadStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : loadStatus == LoadStatus.failure
                    ? const Center(child: Text("No food available"))
                    : Container(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: noticeList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final itemNotice = noticeList[index];
                            return ItemListNotification(
                              orderID: itemNotice.orderId!,
                              noticesMessage: itemNotice.noticesMessage!,
                              foodImage: itemNotice.foodImage!,
                              foodName: itemNotice.foodName!,
                              quantity: itemNotice.quantity!,
                              time: itemNotice.noticesDatetime!,
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

class ItemListNotification extends StatelessWidget {
  final int orderID;
  final String noticesMessage;
  final String foodImage;
  final String foodName;
  final int quantity;
  final DateTime time;

  const ItemListNotification({
    super.key,
    required this.orderID,
    required this.noticesMessage,
    required this.foodImage,
    required this.foodName,
    required this.quantity,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Ink(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    foodImage,
                    height: 59,
                    width: 59,
                    fit: BoxFit.cover,
                  ),
                  noticesMessage == "success"
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order Success (ĐH$orderID - $foodName x$quantity)",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    "Invoice ĐH$orderID has been created, the order has been transferred to the shipping unit.",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('dd/MM/yyyy').format(time),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(95, 95, 95, 1)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order Error (ĐH$orderID - $foodName x$quantity)",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    "Invoice ĐH$orderID has been canceled, possibly due to overbooking, please reorder",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('dd/MM/yyyy').format(time),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(95, 95, 95, 1)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
          const Divider(
            color: Color.fromRGBO(204, 204, 204, 1),
            thickness: 1,
          )
        ],
      ),
    );
  }
}

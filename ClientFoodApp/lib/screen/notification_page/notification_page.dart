import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/api/order.api.dart';
import 'package:foodapp/models/entities/notice.entity.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/widgets/bottom_bar/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../widgets/app_bar/app_bar.dart';
import '../../widgets/item_list_notification/item_list_notification.dart';

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
      appBar: const AppBarWidget(title: "NOTIFICATION"),
      body: Column(
        children: [
          Expanded(
            child: loadStatus == LoadStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
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
        ],
      ),
      bottomNavigationBar: BottomBar(tab: selectedTab, changeTab: changeTab),
    );
  }
}

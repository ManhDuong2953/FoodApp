import 'package:flutter/material.dart';
import 'package:foodapp/BottomBar/BottomBar.dart';
import 'package:foodapp/OrderHistoryPage/OrderHistoryPage.dart';
import 'package:intl/intl.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  int selectedTab = 5;

  void changeTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(25),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/bgPerson.png'), // Hình ảnh PNG
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Color.fromRGBO(219, 22, 110, 1),
                    BlendMode.multiply,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "assets/images/settings.png",
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/avtuser.png",
                        ),
                        radius: 35,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Erik Walters",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "0123456789",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                const Divider(
                  color: Color.fromRGBO(239, 239, 239, 1),
                  thickness: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderHistoryScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/order.png"),
                                ),
                              ),
                              child: Image.asset("assets/images/OrderIcon.png"),
                            ),
                            const Text(
                              "Orders History",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Image.asset("assets/images/chevronRight.png")
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Color.fromRGBO(239, 239, 239, 1),
                  thickness: 20,
                ),
                Text(
                  _getCurrentTime(),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          BottomBar(tab: selectedTab, changeTab: changeTab)
        ],
      ),
    );
  }
}

String _getCurrentTime() {
  try {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm:ss dd/mm/yyyy');
    return formatter.format(now);
  } catch (e) {
    print('Lỗi: $e');
    return 'Không thể lấy thời gian';
  }
}

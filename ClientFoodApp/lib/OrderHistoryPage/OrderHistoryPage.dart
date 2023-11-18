import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/BottomBar/BottomBar.dart';
import 'package:foodapp/ReviewPage/ReviewInputScreen.dart';

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
              color: Color.fromRGBO(250, 240, 240, 1),
              child: ListView(
                children: const [
                  ListOrderHistory(),
                  ListOrderHistory(),
                  ListOrderHistory(),
                  ListOrderHistory(),
                  ListOrderHistory(),
                  ListOrderHistory(),
                  ListOrderHistory(),
                ],
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
  const ListOrderHistory({
    super.key,
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
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child:
                              Image.asset("assets/images/food_thumbnail.png"),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(14, 3, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Bánh mỳ Hamburgers",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
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
                                            builder: (context) =>
                                                ReviewInputScreen(), // Replace ReviewScreen with your desired screen
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Đánh giá",
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
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: Text(
                                      "28 Nov 2021 10 : 32 AM",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                      const Column(
                        children: [
                          Text("\$ 332.00",
                              style: TextStyle(
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/BottomBar/BottomBar.dart';
import 'package:foodapp/DetailProductPage/DetailProductPage.dart';
import 'package:foodapp/SignupPage/SignupPage.dart';

import '../SearchResultFoodPage/SearchResultFoodPage.dart';

class SearchFoodScreen extends StatefulWidget {
  const SearchFoodScreen({Key? key});

  @override
  State<SearchFoodScreen> createState() => _SearchFoodScreenState();
}

class _SearchFoodScreenState extends State<SearchFoodScreen> {
  final TextEditingController _keywordSearch = TextEditingController();
  int selectedTab = 1;

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
          Column(
            children: [
              Container(
                height: 91,
                color: const Color.fromRGBO(219, 22, 110, 1),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 13),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextField(
                          controller: _keywordSearch,
                          onSubmitted: (String keywordSearch) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SearchResultFoodScreen(
                                            keyword: keywordSearch)));
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search for address, food...',
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: const Color.fromRGBO(250, 240, 240, 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Text("RECOMMENDED FOR YOU",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(155, 155, 155, 1),
                          )),
                    ),
                    ListResultSearchFood(context),
                    ListResultSearchFood(context),
                    ListResultSearchFood(context),
                    ListResultSearchFood(context),
                    ListResultSearchFood(context),
                    ListResultSearchFood(context),
                    ListResultSearchFood(context),
                    ListResultSearchFood(context),
                    ListResultSearchFood(context),
                  ],
                ),
              ),
            ),
          ),
          BottomBar(tab: selectedTab, changeTab: changeTab),
        ],
      ),
    );
  }

  Column ListResultSearchFood(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailProductScreen(),
              ),
            )
          },
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                child: Image.asset(
                                  "assets/images/food_thumbnail.png",
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Bánh mỳ Hambergers",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                "\$400",
                                style: TextStyle(
                                  color: Color.fromRGBO(95, 95, 95, 1),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/vectors/star_solid.svg"),
                                  SvgPicture.asset(
                                      "assets/vectors/star_solid.svg"),
                                  SvgPicture.asset(
                                      "assets/vectors/star_solid.svg"),
                                  SvgPicture.asset(
                                      "assets/vectors/star_solid.svg"),
                                  SvgPicture.asset(
                                      "assets/vectors/star_solid.svg"),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "433 reviews",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 88, 88, 88),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Color.fromRGBO(198, 198, 198, 0.8),
                thickness: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/BottomBar/BottomBar.dart';
import 'package:foodapp/SearchFood/SearchFood.dart';
import 'package:foodapp/SearchPage/SearchPage.dart';

class FavoritePageScreen extends StatefulWidget {
  const FavoritePageScreen({super.key});

  @override
  State<FavoritePageScreen> createState() => _FavoritePageScreenState();
}

class _FavoritePageScreenState extends State<FavoritePageScreen> {
  int selectedTab = 3;

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
            height: 75,
            color: Color.fromRGBO(219, 22, 110, 1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchFoodScreen(),
                          ),
                        );
                      },
                      child: SvgPicture.asset("assets/vectors/searchIcon.svg"),
                    ),
                  ),
                  const Expanded(
                    flex: 20,
                    child: Text(
                      "THE MOST FAVORITES",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color.fromRGBO(250, 240, 240, 1),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 17),
                child: ListView(
                  children: [
                    ItemListFavorites(context),
                    ItemListFavorites(context),
                    ItemListFavorites(context),
                    ItemListFavorites(context),
                    ItemListFavorites(context),
                    ItemListFavorites(context),
                    ItemListFavorites(context),
                    ItemListFavorites(context),
                    ItemListFavorites(context),
                  ],
                ),
              ),
            ),
          ),
          BottomBar(tab: selectedTab, changeTab: changeTab)
        ],
      ),
    );
  }

  InkWell ItemListFavorites(BuildContext context) {
    String name = "Mạnh";

    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchPage()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white, // Màu nền của container
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(255, 214, 214, 0.8), // Màu của shadow
              offset: Offset(0,
                  2), // Độ dịch chuyển của shadow (theo chiều ngang và chiều dọc)
              blurRadius: 4, // Độ mờ của shadow
              spreadRadius: 4, // Phạm vi mở rộng của shadow
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              // Sử dụng ClipRRect để áp dụng BorderRadius cho hình ảnh ở phía trên
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                "assets/images/imgFood.png",
                width: double.infinity,
                height: 174,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Grilled Squid Tentacles",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        "Sushi Platter | Tuna (2 pcs), Semi-fatty Tuna (2 pcs), Prime Fatty Tuna (2 pcs)",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Color.fromRGBO(95, 95, 95, 1),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/vectors/star_solid.svg"),
                        SvgPicture.asset("assets/vectors/star_solid.svg"),
                        SvgPicture.asset("assets/vectors/star_solid.svg"),
                        SvgPicture.asset("assets/vectors/star_solid.svg"),
                        SvgPicture.asset("assets/vectors/star_solid.svg"),
                        const Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "433 reviews",
                            style: TextStyle(
                              color: Color.fromRGBO(96, 96, 96, 1),
                              fontSize: 11,
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
    );
  }
}

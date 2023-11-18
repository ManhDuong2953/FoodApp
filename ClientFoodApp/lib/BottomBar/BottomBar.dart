import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/FavoritePage/FavoritePage.dart';
import 'package:foodapp/NotificationPage/NotificationPage.dart';
import 'package:foodapp/OrderHistoryPage/OrderHistoryPage.dart';
import 'package:foodapp/PersonPage/PersonPage.dart';
import 'package:foodapp/SearchFood/SearchFood.dart';

class BottomBar extends StatefulWidget {
  final int tab;
  final Function changeTab;

  const BottomBar({Key? key, required this.tab, required this.changeTab})
      : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int tab1 = 1;
  int tab2 = 2;
  int tab3 = 3;
  int tab4 = 4;
  int tab5 = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(220, 220, 220, 0.95),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  widget.changeTab(tab1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchFoodScreen(),
                    ),
                  );
                },
                highlightColor: Colors.transparent,
                child: Image.asset(
                  "assets/bottomBar/meal.png",
                  color: widget.tab == tab1
                      ? const Color.fromRGBO(219, 22, 110, 1)
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  widget.changeTab(tab2);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderHistoryScreen(),
                    ),
                  );
                },
                highlightColor: Colors.transparent,
                // child: Icon(Icons.add,
                //     color: widget.tab == tab2 ? Colors.red : Colors.green),
                child: Image.asset(
                  "assets/bottomBar/list.png",
                  color: widget.tab == tab2
                      ? const Color.fromRGBO(219, 22, 110, 1)
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  widget.changeTab(tab3);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritePageScreen(),
                    ),
                  );
                },
                highlightColor: Colors.transparent,
                child: Image.asset(
                  "assets/bottomBar/heart.png",
                  color: widget.tab == tab3
                      ? const Color.fromRGBO(219, 22, 110, 1)
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  widget.changeTab(tab4);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(),
                    ),
                  );
                },
                highlightColor: Colors.transparent,
                child: Image.asset(
                  "assets/bottomBar/note.png",
                  color: widget.tab == tab4
                      ? const Color.fromRGBO(219, 22, 110, 1)
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  widget.changeTab(tab5);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonScreen(),
                    ),
                  );
                },
                highlightColor: Colors.transparent,
                child: Image.asset(
                  "assets/bottomBar/person.png",
                  color: widget.tab == tab5
                      ? const Color.fromRGBO(219, 22, 110, 1)
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

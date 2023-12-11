import 'package:flutter/material.dart';
import 'package:foodapp/models/assets_dir/assets_direct.dart';
import 'package:foodapp/screen/favorite_page/favorite_page.dart';
import 'package:foodapp/screen/notification_page/notification_page.dart';
import 'package:foodapp/screen/order_history_page/order_history_page.dart';
import 'package:foodapp/screen/person_page/person_page.dart';
import 'package:foodapp/screen/search_page/search_page.dart';

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
            InkWell(
              onTap: () {
                widget.changeTab(tab1);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
              highlightColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  assetsDirect.iconMealBottom,
                  color: widget.tab == tab1
                      ? assetsDirect.homeColor
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
            InkWell(
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  assetsDirect.iconListBottom,
                  color: widget.tab == tab2
                      ? assetsDirect.homeColor
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
            InkWell(
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  assetsDirect.iconHeartBottom,
                  color: widget.tab == tab3
                      ? assetsDirect.homeColor
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
            InkWell(
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  assetsDirect.iconNoticeBottom,
                  color: widget.tab == tab4
                      ? assetsDirect.homeColor
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
            InkWell(
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  assetsDirect.iconProfileBottom,
                  color: widget.tab == tab5
                      ? assetsDirect.homeColor
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

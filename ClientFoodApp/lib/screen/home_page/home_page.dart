import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/models/assets_direct.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 444,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(219, 22, 110, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                ),
              ),
              child: Image.asset(
                assetsDirect.logoFoodPanda, // Make sure the asset path is correct
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
                assetsDirect.vector), // Make sure the asset path is correct
          ),
        ],
      ),
    );
  }
}

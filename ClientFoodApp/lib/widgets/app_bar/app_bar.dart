import 'package:flutter/material.dart';
import 'package:foodapp/models/assets_dir/assets_direct.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: assetsDirect.homeColor,
      toolbarHeight: 60,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(60); // Adjust the height as needed
}

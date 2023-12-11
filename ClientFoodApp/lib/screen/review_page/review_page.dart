import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/api/review.api.dart';
import 'package:foodapp/models/assets_dir/assets_direct.dart';
import 'package:foodapp/models/entities/review.entity..dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/screen/detail_product_page/detail_product_page.dart';
import 'package:foodapp/screen/order_history_page/order_history_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../widgets/app_bar/app_bar.dart';

class ReviewInputScreen extends StatefulWidget {
  final int idFood;

  const ReviewInputScreen({Key? key, required this.idFood}) : super(key: key);

  @override
  _ReviewInputScreenState createState() => _ReviewInputScreenState();
}

class _ReviewInputScreenState extends State<ReviewInputScreen> {
  int _rating = 0;
  int? _idFood;
  LoadStatus loadStatus = LoadStatus.success;
  final TextEditingController _reviewController = TextEditingController();
  Review? reviewEntity;

  @override
  void initState() {
    super.initState();
    _idFood = widget.idFood;
  }

  Future<void> fetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getString('idUser') ?? '';
      String urlApi = ApiReview.postReviewpEndpoint;
      reviewEntity = Review(
        idFood: _idFood,
        idUser: int.parse(idUser),
        comment: _reviewController.text,
        rate: _rating,
      );

      final response = await http.post(
        Uri.parse(urlApi),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode(
            reviewEntity?.toJson()), // No need for parentheses around dataReq
      );
      setState(() {
        loadStatus = LoadStatus.loading;
      });
      if (response.statusCode == 200) {
        setState(() {
          loadStatus = LoadStatus.success;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailProductScreen(idProduct: _idFood)));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        loadStatus = LoadStatus.failure;
      });
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "REVIEWS"),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Stars:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _rating = index + 1;
                        });
                      },
                      child: Icon(
                        index < _rating ? Icons.star : Icons.star_border,
                        size: 40,
                        color: Colors.amber,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your comments:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _reviewController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText:
                        'Write your comments about the dish in the box...',
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: assetsDirect.homeColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20)),
                  onPressed: () {
                    fetchData();
                  },
                  child: loadStatus == LoadStatus.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : loadStatus == LoadStatus.failure
                          ? const Center(child: Text("ERROR SERVER!!"))
                          : const Text('Submit your review '),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

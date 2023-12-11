import "package:flutter/material.dart";
import 'package:foodapp/models/assets_dir/assets_direct.dart';
import 'package:foodapp/screen/detail_product_page/detail_product_page.dart';
import 'package:foodapp/widgets/star/star.dart';

class ItemListRecommendFood extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final String ingredients;
  final String imageUrl;
  final double avgRate;
  final int totalReviews;

  const ItemListRecommendFood({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.imageUrl,
    required this.avgRate,
    required this.totalReviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProductScreen(
              idProduct: id,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              imageUrl ?? assetsDirect.errFood,
                              fit: BoxFit.cover,
                              height: 60,
                              width: 60,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              ingredients,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: const TextStyle(
                                color: Color.fromRGBO(95, 95, 95, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              StarRate(rate: avgRate),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "$totalReviews reviews",
                                  style: const TextStyle(
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
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Color.fromRGBO(198, 198, 198, 0.8),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

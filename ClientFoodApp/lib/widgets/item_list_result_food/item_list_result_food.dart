import 'package:flutter/material.dart';
import 'package:foodapp/models/assets_dir/assets_direct.dart';
import 'package:foodapp/screen/detail_product_page/detail_product_page.dart';
import 'package:foodapp/widgets/star/star.dart';

class ItemListResultFood extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final String ingredients;
  final String imageUrl;
  final double avgRate;
  final int totalReview;

  const ItemListResultFood({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.imageUrl,
    required this.avgRate,
    required this.totalReview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailProductScreen(idProduct: id),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(255, 214, 214, 0.8),
                offset: Offset(0, 2),
                blurRadius: 4,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 220, 139, 139),
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 204, 204, 204),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        imageUrl ?? assetsDirect.errFood,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          ingredients,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(95, 95, 95, 1),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              StarRate(rate: avgRate),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  "$totalReview reviews",
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color.fromRGBO(134, 134, 134, 1),
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}

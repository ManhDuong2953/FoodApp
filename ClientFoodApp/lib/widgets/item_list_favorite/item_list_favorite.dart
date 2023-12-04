import "package:flutter/material.dart";
import 'package:foodapp/screen/detail_product_page/detail_product_page.dart';
import 'package:foodapp/widgets/star/star.dart';

class ItemListFavorites extends StatelessWidget {
  final int id;
  final String name;
  final double price;
  final String ingredients;
  final String description;
  final String imgThumbnail;
  final int totalOrders;
  final double averageRating;
  final int totalReviews;

  const ItemListFavorites({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.ingredients,
    required this.description,
    required this.imgThumbnail,
    required this.totalOrders,
    required this.averageRating,
    required this.totalReviews,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailProductScreen(idProduct: id)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
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
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                color: const Color.fromARGB(255, 220, 139, 139),
                child: Image.network(
                  imgThumbnail ??
                      "https://e7.pngegg.com/pngimages/321/641/png-clipart-load-the-map-loading-load.png",
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                      child: Text(
                        ingredients,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Color.fromRGBO(95, 95, 95, 1),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                      child: Text(
                        "\$ $price",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Color.fromRGBO(219, 22, 110, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StarRate(rate: averageRating),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "${totalReviews.toString()} reviews",
                            style: const TextStyle(
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

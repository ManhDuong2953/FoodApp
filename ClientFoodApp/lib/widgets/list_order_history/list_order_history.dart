import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import 'package:foodapp/models/assets_dir/assets_direct.dart';
import 'package:foodapp/screen/detail_product_page/detail_product_page.dart';
import 'package:foodapp/screen/review_page/review_page.dart';

class ListOrderHistory extends StatelessWidget {
  final int orderID;
  final int foodID;
  final String name;
  final String ingredients;
  final String imageUrl;
  final String orderDatetime;
  final int quantity;
  final double price;
  final double totalPrice;

  // Constructor
  const ListOrderHistory({
    super.key,
    required this.orderID,
    required this.foodID,
    required this.name,
    required this.ingredients,
    required this.imageUrl,
    required this.orderDatetime,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProductScreen(idProduct: foodID),
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white, // Màu nền của container
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(255, 214, 214, 0.8),
                    // Màu của shadow
                    offset: Offset(0, 2),
                    // Độ dịch chuyển của shadow (theo chiều ngang và chiều dọc)
                    blurRadius: 4,
                    // Độ mờ của shadow
                    spreadRadius: 4, // Phạm vi mở rộng của shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            child: Image.network(
                              imageUrl ?? assetsDirect.errFood,
                              height: 80,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(14, 3, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Text(
                                    ingredients,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromRGBO(149, 149, 149, 1)),
                                  ),
                                ),
                                Text(
                                  "\$ $price",
                                  style: const TextStyle(
                                    color: assetsDirect.homeColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Text("x$quantity"),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ReviewInputScreen(
                                                idFood: foodID,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Ink(
                                          padding: const EdgeInsets.all(15),
                                          child: const Text(
                                            "Rate",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  218, 22, 109, 1.0), // Màu chữ
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      color: Color.fromRGBO(200, 200, 200, 1),
                      thickness: 1.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/vectors/listIcon.svg'),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Text(
                                    orderDatetime,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ]),
                        ),
                        Text("\$ $totalPrice",
                            style: const TextStyle(
                                color: assetsDirect.homeColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

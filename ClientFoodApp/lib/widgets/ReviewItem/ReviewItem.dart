import 'package:flutter/material.dart';
import 'package:foodapp/widgets/Star/Star.dart';
import 'package:intl/intl.dart';

class ReviewItem extends StatelessWidget {
  final String name;
  final String avatarThumbnail;
  final DateTime reviewsDatetime;
  final int rate;
  final String comment;

  const ReviewItem({
    super.key,
    required this.name,
    required this.avatarThumbnail,
    required this.reviewsDatetime,
    required this.rate,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Color.fromRGBO(220, 220, 220, 0.7),
          thickness: 0.8,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(17, 10, 17, 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: ClipOval(
                  child: Image.network(
                    avatarThumbnail ??
                        "https://e7.pngegg.com/pngimages/321/641/png-clipart-load-the-map-loading-load.png",
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(children: [StarRate(rate: rate.toDouble())]),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            DateFormat('yyyy-MM-dd').format(reviewsDatetime),
                            style: const TextStyle(
                              color: Color.fromRGBO(95, 95, 95, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              comment,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: const TextStyle(
                                fontSize: 14,
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
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemListNotification extends StatelessWidget {
  final int id;
  final int userId;
  final String titleNotifi;
  final String noticesMessage;
  final DateTime noticesDatetime;

  const ItemListNotification({
    super.key,
    required this.id,
    required this.userId,
    required this.titleNotifi,
    required this.noticesDatetime,
    required this.noticesMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Ink(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      "https://cdn.pixabay.com/photo/2020/03/12/11/43/bell-4924849_960_720.png",
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  titleNotifi,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              noticesMessage,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(noticesDatetime),
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(95, 95, 95, 1)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(
            color: Color.fromRGBO(204, 204, 204, 1),
            thickness: 1,
          )
        ],
      ),
    );
  }
}

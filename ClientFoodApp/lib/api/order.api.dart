import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiOrder {
  static String? baseUrl = "${dotenv.env['BASE_URL']}/orders";
  static String postOrderEndpoint = '$baseUrl/post_orders';
  static String getNoticeEndpoint(int id) => '$baseUrl/get_notices/$id';
  static String getListEndpoint(int id) => '$baseUrl/list/$id';
}

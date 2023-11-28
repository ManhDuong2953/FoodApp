import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiFood {
  static String? baseUrl = "${dotenv.env['BASE_URL']}/foods";

  static String getAllFoodEndpoint = '$baseUrl/';
  static String postSearchEndpoint = '$baseUrl/search';
  static String getRecommendEndpoint = '$baseUrl/recommend';
  static String getFoodEndpoint(int id) => '$baseUrl/find/$id';
}

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiReview {
  static String? baseUrl = "${dotenv.env['BASE_URL']}/reviews";
  static String postReviewpEndpoint = '$baseUrl/post_reviews';
  static String getReviewEndpoint(int id) => '$baseUrl/food_id/$id';
}

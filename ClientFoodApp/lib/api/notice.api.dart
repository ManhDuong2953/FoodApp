import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiNotices {
  static String? baseUrl = "${dotenv.env['BASE_URL']}/notices";

  static String getNoticeEndpoint(int id) => '$baseUrl/list_notices/$id';
  static String postNoticeEndpoint = '$baseUrl/post_notices';
}
